import 'package:dsd/log/log_util.dart';
import 'package:dsd/synchronization/base/abstract_sync_sf_download_model.dart';
import 'package:dsd/synchronization/bean/sync_sf_request_bean.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/base/abstract_request_create.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 16:00

class DownloadSfRequestCreate extends AbstractRequestCreate<Future<SyncSfRequestBean>> {
  DownloadSfRequestCreate(AbstractSyncSfDownloadModel syncDownloadModel) : super.bySf(syncDownloadModel);

  @override
  Future<SyncSfRequestBean> create() async {
    return createSyncDataRequestBean(syncSfDownloadModel.getTableDownloadList());
  }

  Future<SyncSfRequestBean> createSyncDataRequestBean(List<String> tableList) async {

    SyncSfRequestBean requestBean = SyncSfRequestBean();
//    requestBean.deviceId = '';
//    requestBean.userId = '';
    requestBean.groupNumber = '1';
    if(syncSfDownloadModel.syncType == SyncType.SYNC_INIT_SF){
      requestBean.syncType = '0';
    } else{
      requestBean.syncType = '1';
    }
    if (tableList == null) {
      //表示全表请求
      requestBean.objectNames = '';
    } else {
      //表示指定表请求
      requestBean.objectNames = tableList.join(',');
    }

    Log().logger.i('*****************download request*************\n${requestBean.toJson()}');

    return requestBean;
  }

}
