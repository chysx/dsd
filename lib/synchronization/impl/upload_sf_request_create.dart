import 'package:dsd/log/log_util.dart';
import 'package:dsd/synchronization/base/abstract_request_create.dart';
import 'package:dsd/synchronization/base/abstract_sync_sf_upload_model.dart';
import 'package:dsd/db/database.dart';
import 'package:dsd/synchronization/bean/sync_sf_up_request_bean.dart';
import 'package:dsd/synchronization/sync/sync_config.dart';
import 'package:dsd/synchronization/sync/sync_mapping.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:dsd/synchronization/bean/table_uploade_bean.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 15:57

class UploadSfRequestCreate extends AbstractRequestCreate<Future<SyncSfUpRequestBean>> {
  UploadSfRequestCreate(AbstractSyncSfUploadModel syncUploadModel) : super.bySf(null,syncUploadModel);

  @override
  Future<SyncSfUpRequestBean> create() async {
    List<TableUploadBean> uploadBeanList = syncSfUploadModel.getTableUploadList();
    Map<String, List<String>> tableRowsMap = await getTableRowsMap(uploadBeanList);
    List<Record> syncTableBeanList = createSyncTableBeanList(tableRowsMap);
    return await createSyncDataRequestBean(syncTableBeanList);
  }

  ///
  /// 获取要上传的表名和表数据集
  ///
  /// @param uploadBeanList 需要上传的sql语句封装的对象
  /// @return HashMap<key,value> key:表名，value:查询到的数据集（例如："sno1|sname1","sno2|sname2"）
  ///
  Future<Map<String, List<String>>> getTableRowsMap(final List<TableUploadBean> uploadBeanList) async {
    Map<String, List<String>> tableRowsMap = new Map();
    sqflite.DatabaseExecutor sqfliteDb = DbHelper().database.database;
    for (TableUploadBean uploadBean in uploadBeanList) {
      List<Map<String, dynamic>> list = await sqfliteDb.rawQuery(uploadBean.getSqlFindBuild());
      List<String> rows = new List();
      for (Map<String, dynamic> map in list) {
        StringBuffer sb = new StringBuffer();
        for (dynamic value in map.values) {
          value ??= ''; //后台不接受null，否则会上传失败
          sb..write(value)..write(SyncConfig.ROW_SEPARATOR);
        }
        String row = sb.toString();
        rows.add(row.substring(0, row.length - 1));
      }
      tableRowsMap[uploadBean.name] = rows;
    }
    return tableRowsMap;
  }

  List<Record> createSyncTableBeanList(Map<String, List<String>> tableRowsMap) {
    List<Record> syncTableBeanList = new List();
    for (MapEntry<String, List<String>> entry in tableRowsMap.entries) {
      Record tableBean = new Record();
      tableBean.name = local2SfMapping[entry.key];
      tableBean.fields = createFields(entry.key);
      tableBean.values = entry.value;
      syncTableBeanList.add(tableBean);
    }
    return syncTableBeanList;
  }

  String createFields(String tableName) {
    List<TableUploadBean> uploadBeanList = syncSfUploadModel.getTableUploadList();
    TableUploadBean tableUploadBean = uploadBeanList.firstWhere((bean){
      return bean.name.toLowerCase() == tableName.toLowerCase();
    });
    String sql = tableUploadBean.getSqlFindBuild();
    sql = sql.replaceAll('\n', '');
    sql = sql.replaceAll('\t', '');
    sql = sql.substring(sql.indexOf('SELECT') + 6,sql.indexOf('FROM')).trim();
    List<String> fieldList = sql.split(',');
    if(fieldList[0].contains('.')){
      fieldList = fieldList.map((item){
        return item.substring(item.indexOf('.') + 1);
      }).toList();
    }
    String mark = local2SfMapping[tableName] + MARK;
    Map<String,String> map = {};
    for(String key in fieldMapping.keys){
      if(key.contains(mark)){
        String value = fieldMapping[key];
        map[value] = key.substring(key.indexOf(MARK) + 1);
      }
    }
    List<String> resultList = [];
    for(String field in fieldList) {
      resultList.add(map[field.trim()]);
    }
    return resultList.join(',');
  }

  Future<SyncSfUpRequestBean> createSyncDataRequestBean(List<Record> syncTableBeanList) async {
    SyncSfUpRequestBean sfUpRequestBean = new SyncSfUpRequestBean();
    sfUpRequestBean.records = syncTableBeanList;

    Log().logger.i('*****************upload request*************\n${sfUpRequestBean.toJson()}');
    return sfUpRequestBean;
  }
}
