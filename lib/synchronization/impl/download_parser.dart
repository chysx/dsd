import 'package:dio/dio.dart';
import 'package:dsd/db/database.dart';
import 'package:dsd/db/manager/app_log_manager.dart';
import 'package:dsd/exception/exception_type.dart';
import 'package:dsd/log/log_util.dart';
import 'package:dsd/synchronization/base/abstract_parser.dart';
import 'package:dsd/synchronization/base/i_parse_policy.dart';
import 'package:dsd/synchronization/sync/sync_config.dart';
import 'package:dsd/synchronization/sync/sync_response_status.dart';
import 'package:dsd/synchronization/utils/sync_download_util.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite/sqlite_api.dart' as sqlite_api;
import 'package:dsd/synchronization/bean/sync_response_bean.dart';

import '../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 15:59

class DownloadParser extends AbstractParser<Response<Map<String, dynamic>>> {
  DownloadParser(IParsePolicy parsePolicy) : super(parsePolicy);

  void _printDataStr(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   " + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   " + da);
        da = "";
      }
    }
  }

  @override
  Future<bool> parse(Response<Map<String, dynamic>> response) async {
    print("**********************Request*****************************");
    Application.logger.i('''url = ${response.request.baseUrl + response.request.path}''');
    _printDataStr("response",response.request);
    print("**********************Request*****************************");

    print("**********************Response*****************************");
//    _printDataStr("response",response.data);
    print("**********************Response*****************************");

    bool result = true;
    try {
      sqflite.DatabaseExecutor sqfliteDb = DbHelper().database.database;
      sqlite_api.Database database = sqfliteDb as sqlite_api.Database;
      await database.transaction((txn) async {
        SyncResponseBean syncDataResponseBean = SyncResponseBean.fromJson(response.data);
        print(syncDataResponseBean.status);
        if (syncDataResponseBean.status != SyncResponseStatus.SUCCESS) {
          result = false;
          return;
        }
        Result syncContentBean = syncDataResponseBean.result;
        List<Tables> syncTableBeanList = syncContentBean.tables;
        for (Tables table in syncTableBeanList) {
          print("111111111111111");
          String tableName = table.name;
          if (!await _isTableInDb(txn, tableName)) {
            result = false;
            return;
          }
          String fields = table.fields;
          if (!await _isColumnInTable(txn, _getFieldNames(fields), tableName)) {
            result = false;
            return;
          }
          List<String> primaryKeys = await _getTablePrimaryKeys(txn, tableName);
          if (!await _isColumnInTable(txn, primaryKeys, tableName)) {
            result = false;
            return;
          }
          List<String> rows = table.rows;
          if (rows != null && rows.length > 0) {
            await _parseRows(txn, primaryKeys, _getFieldNames(fields), rows, tableName);
          }
          String timeStamp = table.paramValues[0];
          await _updateTimeStamp(txn, tableName, timeStamp);
        }
      });
    } catch (e) {
      result = false;
      Log().logger.e(e.toString());
      AppLogManager.insert(ExceptionType.ERROR.toString(), error: e);
      throw e;
    }

    return result;
  }

  ///
  /// 解析指定的表
  /// @param primaryKeys 主键列表
  /// @param fieldNames 服务端返回的列名数组
  /// @param rows 服务端返回的该表所有的行
  /// @param tableName 表名
  ///
  Future _parseRows(sqlite_api.Transaction transaction, List<String> primaryKeys, List<String> fieldNames,
      List<String> rows, String tableName) async {
    String tempRow = "";
    try {
      if (parsePolicy.isAllDataAndAllInsert(tableName)) {
        String sql = "delete from " + tableName;
        await transaction.execute(sql);
        for (String row in rows) {
          tempRow = row;
          await transaction.insert(tableName, _createContentValues(tableName, fieldNames, _getRowValue(row), true));
        }
      } else {
        for (String row in rows) {
          tempRow = row;
          List<String> rowValue = _getRowValue(row);
          if (await _isRowValueInDb(transaction, primaryKeys, fieldNames, rowValue, tableName)) {
            transaction.update(tableName, _createContentValues(tableName, fieldNames, rowValue, false),
                where: _getTableWhereCondition(primaryKeys),
                whereArgs: _getPrimaryKeyValues(primaryKeys, fieldNames, rowValue));
          } else {
            transaction.insert(tableName, _createContentValues(tableName, fieldNames, rowValue, true));
          }
        }
      }
    } catch (e) {
      Log().logger.e("tableName = $tableName row = $tempRow \n" + e.toString());
      AppLogManager.insert(ExceptionType.ERROR.toString(), msg: "tableName = $tableName row = $tempRow");
      throw e;
    }
  }

  ///
  /// 创建数据库行对象
  /// @param fieldNames 服务端返回的列名数组
  /// @param rowValue 服务端返回的某行
  /// @return
  ///
  Map<String, String> _createContentValues(
      String tableName, List<String> fieldNames, List<String> rowValue, bool isAddId) {
    Map<String, String> contentValues = new Map();
    int index = 0;
    for (String fieldName in fieldNames) {
      contentValues[fieldName] = rowValue[index++];
    }
    Map<String, String> uuidContentValues = SyncDownloadUtil.createContentValue(tableName, isAddId);
    if (uuidContentValues != null) {
      contentValues.addAll(uuidContentValues);
    }
    return contentValues;
  }

  ///
  /// 根据主键列表查询该行是否存在本地数据库中
  /// @param primaryKeys 主键列表
  /// @param fieldNames 服务端返回的列名数组
  /// @param rowValue 服务端返回的某行
  /// @param tableName 表名
  /// @return
  ///
  Future<bool> _isRowValueInDb(sqlite_api.Transaction transaction, List<String> primaryKeys, List<String> fieldNames,
      List<String> rowValue, String tableName) async {
    try {
      List<String> values = _getPrimaryKeyValues(primaryKeys, fieldNames, rowValue);
      if (values.length == 0) return false; //没有指定跟新的主键
      if (values[0] == null) return false; //指定跟新的主键不在服务端返回的列名数组中
      String selection = _getTableWhereCondition(primaryKeys);
      List<Map<String, dynamic>> list =
          await transaction.query(tableName, columns: primaryKeys, where: selection, whereArgs: values);
      if (list != null && list.length > 0) return true;
    } catch (e) {
      Log().logger.e(e.toString());
      AppLogManager.insert(ExceptionType.ERROR.toString(), error: e);
      throw e;
    }

    return false;
  }

  ///
  /// 获取主键列表对应的各个值
  /// @param primaryKeys 主键列表
  /// @param fieldNames 服务端返回的列名数组
  /// @param rowValue 服务端返回的某行
  /// @return
  ///
  List<String> _getPrimaryKeyValues(List<String> primaryKeys, List<String> fieldNames, List<String> rowValue) {
    List<String> primaryKeyValues = new List(primaryKeys.length);
    int index = 0;
    int position = 0;
    for (String primaryKey in primaryKeys) {
      position = 0;
      for (String fieldName in fieldNames) {
        if (fieldName.toLowerCase() == primaryKey.toLowerCase()) {
          primaryKeyValues[index] = rowValue[position];
        }
        position++;
      }
      index++;
    }
    return primaryKeyValues;
  }

  ///
  /// 根据主键列表拼接where子句（例如 key1 = ? and key2 = ?）
  /// @param primaryKeys 主键列表
  /// @return
  ///
  String _getTableWhereCondition(List<String> primaryKeys) {
    StringBuffer selection = new StringBuffer();
    for (String key in primaryKeys) {
      selection..write(key)..write(" = ? and ");
    }

    String result = selection.toString();
    if (result.length > 0) {
      return result.substring(0, result.length - 4);
    }
    return selection.toString();
  }

  ///
  /// 得到表名的主键列表
  /// @param tableName 表名
  /// @return
  ///
  Future<List<String>> _getTablePrimaryKeys(sqlite_api.Transaction transaction, String tableName) async {
    try {
      List<Map<String, dynamic>> list =
          await transaction.rawQuery("SELECT keys FROM sync_download_logic WHERE tableName = ?", [tableName]);
      if (list != null && list.length > 0) {
        return _getPrimaryKeys(list[0]["keys"]);
      }
    } catch (e) {
      Log().logger.e(e.toString());
      AppLogManager.insert(ExceptionType.ERROR.toString(), error: e);
      throw e;
    }
    return null;
  }

  ///
  /// 将行字符串转化为字符串数组（例如：no1|name1|age1）
  /// @param rowValueStr ML_PDADownloadLogic表中的主键列表字符串
  /// @return
  ///
  List<String> _getRowValue(String rowValueStr) {
    return rowValueStr.split(SyncConfig.ROW_SEPARATOR);
  }

  ///
  /// 将主键列表字符串转化为字符串数组（例如：no1;no2;no3）
  /// @param primaryKeyStr ML_PDADownloadLogic表中的主键列表字符串
  /// @return
  ///
  List<String> _getPrimaryKeys(String primaryKeyStr) {
    return primaryKeyStr.split(SyncConfig.PRIMARY_KEY_SEPARATOR);
  }

  ///
  /// 将列明字符串转化为字符串数组（例如：no,name,age）
  /// @param fields 服务端返回的列明字符串
  /// @return
  ///
  List<String> _getFieldNames(String fields) {
    return fields.split(SyncConfig.FIELD_SEPARATOR);
  }

  ///
  /// 指定表是否在本地数据库中
  /// @param tableName 表名
  /// @return
  ///
  Future<bool> _isTableInDb(sqlite_api.Transaction transaction, String tableName) async {
    try {
      List<Map<String, dynamic>> list =
          await transaction.rawQuery("select * from sqlite_master where type = 'table' and name = ?", [tableName]);

      if (list == null || list.length <= 0) {
        Log().logger.e("表不存在:$tableName");
        AppLogManager.insert(ExceptionType.ERROR.toString(), msg: "表不存在:" + tableName);
        return false;
      }
    } catch (e) {
      Log().logger.e(e.toString());
      AppLogManager.insert(ExceptionType.ERROR.toString(), error: e);
      throw e;
    }
    return true;
  }

  ///
  /// 指定的列名是否存在本地数据库中
  /// @param fieldNames 列名字符串数组
  /// @param tableName 表名
  /// @return
  ///
  Future<bool> _isColumnInTable(sqlite_api.Transaction transaction, List<String> fieldNames, String tableName) async {
    try {
      List<Map<String, dynamic>> list =
          await transaction.rawQuery("select sql from sqlite_master where type = 'table' and name = ?", [tableName]);
      if (list != null && list.length > 0) {
        String sqlStr = list[0]["sql"] as String;
        for (String fieldName in fieldNames) {
          if (!sqlStr.toLowerCase().contains(fieldName.toLowerCase())) {
            Log().logger.e("表:$tableName 不存在字段:$fieldName");
            AppLogManager.insert(ExceptionType.ERROR.toString(), msg: "表:$tableName 不存在字段:$fieldName");
            return false;
          }
        }
      }
    } catch (e) {
      Log().logger.e(e.toString());
      AppLogManager.insert(ExceptionType.ERROR.toString(), error: e);
      throw e;
    }
    return true;
  }

  ///
  ///  跟新时间戳
  ///  @param sqLiteDatabase 数据库访问对象
  ///  @param tableName 表名
  ///  @param timeStamp 时间戳
  ///
  Future _updateTimeStamp(sqlite_api.Transaction transaction, String tableName, String timeStamp) async {
    await transaction.update("sync_download_logic", {"TimeStamp": timeStamp, "Transferred": 1},
        where: "TableName = ?", whereArgs: [tableName]);
  }
}
