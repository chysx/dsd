import 'package:dsd/db/dao/sync_download_logic_dao.dart';
import 'package:dsd/db/database.dart';
import 'package:dsd/db/table/sync_download_logic_entity.dart';
import 'package:dsd/synchronization/base/abstract_sync_download_model.dart';
import 'package:dsd/synchronization/base/abstract_sync_upload_model.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/utils/sync_util.dart';
import 'package:package_info/package_info.dart';
import 'package:dsd/synchronization/base/abstract_request_create.dart';
import 'package:dsd/synchronization/bean/sync_request_bean.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 16:00

class DownloadRequestCreate
    extends AbstractRequestCreate<Future<SyncRequestBean>> {
  DownloadRequestCreate(AbstractSyncDownloadModel syncDownloadModel) : super(syncDownloadModel, null);


  @override
  Future<SyncRequestBean> create() async {
    return createSyncDataRequestBean(syncDownloadModel.getTableDownloadList());
  }

  Future<SyncRequestBean> createSyncDataRequestBean(List<String> tableList) async {
    SyncRequestBean syncDataRequestBean =
        await SyncUtil.createSyncDataRequestBean(
            syncDownloadModel.syncParameter);

    ReqContent syncContentBean = new ReqContent();
    if (tableList == null) {
      //表示全表请求
      syncContentBean.tables = await createSyncTableBeanList();
    } else {
      //表示指定表请求
      syncContentBean.tables = await createSyncTableBeanListByCon(tableList, syncDownloadModel.syncParameter);
    }
    syncDataRequestBean.reqContent = syncContentBean;

    return syncDataRequestBean;
  }

  Future<List<Tables>> createSyncTableBeanListByCon(List<String> tableList, SyncParameter syncParameter) async {
    Map<String, List<String>> hashMap = new Map();
    int index = -1;
    for (String tableName in tableList) {
      hashMap[tableName] = syncParameter.getDownloadParameterValues()[++index];
    }

    List<SyncDownloadLogicEntity> entityList = await getSyncDownloadLogicList();
    List<Tables> syncTableBeanList = new List();

    for (SyncDownloadLogicEntity entity in entityList) {
      if (tableList.contains(entity.tableName)) {
        Tables tableBean = new Tables();
        List<String> paramValues = new List();
        String timeStamp;
        if (syncDownloadModel.isAllDataAndAllInsert(entity.tableName)) {
          timeStamp = null;
        } else {
          timeStamp = entity.timeStamp;
        }
        paramValues.add(timeStamp);
        paramValues.addAll(hashMap[entity.tableName]);
        tableBean.paramValues = paramValues;
        tableBean.name = entity.tableName;

        syncTableBeanList.add(tableBean);
      }
    }
    return syncTableBeanList;
  }

   Future<List<Tables>> createSyncTableBeanList() async {
    List<SyncDownloadLogicEntity> entityList = await getSyncDownloadLogicList();
    print("length = ${entityList?.length}");
    List<Tables> syncTableBeanList = new List();
    for (SyncDownloadLogicEntity entity in entityList) {
      print("tableName = ${entity.tableName}");
      Tables tableBean = new Tables();
      List<String> paramValues = new List();
      String timeStamp;
      if (syncDownloadModel.isAllDataAndAllInsert(entity.tableName)){
        timeStamp = null;
      }else{
        timeStamp = entity.timeStamp;
      }
      paramValues.add(timeStamp);
      tableBean.paramValues = paramValues;
      tableBean.name = entity.tableName;

      syncTableBeanList.add(tableBean);
    }
    return syncTableBeanList;
  }

  static Future<List<SyncDownloadLogicEntity>> getSyncDownloadLogicList() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    SyncDownloadLogicDao dao = DbHelper().database.syncDownloadLogicDao;
    return await dao.findEntityByVersion(packageInfo.version, "1");
  }

}
