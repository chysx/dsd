import 'package:dsd/log/log_util.dart';
import 'package:dsd/synchronization/base/abstract_request_create.dart';
import 'package:dsd/synchronization/base/abstract_sync_upload_model.dart';
import 'package:dsd/synchronization/bean/sync_request_bean.dart';
import 'package:dsd/db/database.dart';
import 'package:dsd/synchronization/sync/sync_config.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/utils/sync_util.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:dsd/synchronization/bean/table_uploade_bean.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 15:57

class UploadRequestCreate extends AbstractRequestCreate<Future<SyncRequestBean>> {
  UploadRequestCreate(AbstractSyncUploadModel syncUploadModel) : super(null, syncUploadModel);

  @override
  Future<SyncRequestBean> create() async {
    List<TableUploadBean> uploadBeanList = syncUploadModel.getTableUploadList();
    Map<String, List<String>> tableRowsMap = await getTableRowsMap(uploadBeanList);
    List<Tables> syncTableBeanList = createSyncTableBeanList(tableRowsMap);
    return await createSyncDataRequestBean(syncTableBeanList, syncUploadModel.syncParameter);
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

  List<Tables> createSyncTableBeanList(Map<String, List<String>> tableRowsMap) {
    List<Tables> syncTableBeanList = new List();
    for (MapEntry<String, List<String>> entry in tableRowsMap.entries) {
      Tables tableBean = new Tables();
      tableBean.name = entry.key;
      tableBean.rows = entry.value;
      syncTableBeanList.add(tableBean);
    }
    return syncTableBeanList;
  }

  Future<SyncRequestBean> createSyncDataRequestBean(List<Tables> syncTableBeanList, SyncParameter syncParameter) async {
    SyncRequestBean syncDataRequestBean = await SyncUtil.createSyncDataRequestBean(syncParameter);
    ReqContent syncContentBean = new ReqContent();
    syncContentBean.tables = syncTableBeanList;
    syncDataRequestBean.reqContent = syncContentBean;
    Log().logger.i('*****************upload request*************\n${syncDataRequestBean.toJson()}');
    return syncDataRequestBean;
  }
}
