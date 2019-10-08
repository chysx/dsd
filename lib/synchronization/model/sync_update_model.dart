import 'package:dsd/synchronization/base/abstract_sync_download_model.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/19 10:48

class SyncUpdateModel extends AbstractSyncDownloadModel {
  SyncUpdateModel(SyncType syncType, {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync})
      : super(syncType, syncParameter: syncParameter, onSuccessSync: onSuccessSync, onFailSync: onFailSync);

  @override
  List<String> getTableDownloadList() {
    return null;
  }

  @override
  bool isAllDataAndAllInsert(String tableName) {
    if('MD_Account' == tableName || 'MD_Contact' == tableName){
      return true;
    }
    return false;
  }

}