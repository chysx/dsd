import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_constant.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_status.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/sync_factory.dart';
import 'package:dsd/ui/dialog/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'base/abstract_sync_mode.dart';
import 'model/sync_init_model.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/31 17:16

class SyncManager {
  static void start(SyncType syncType,
      {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync, BuildContext context}) {
    if (context != null) LoadingDialog.show(context);
    if (syncParameter == null) syncParameter = new SyncParameter();
    AbstractSyncMode syncMode = SyncFactory.createSyncModel(syncType);

    syncMode
      ..syncParameter = syncParameter
      ..onSuccessSync = () {
        print("onSuccessSync");
        if (context != null) LoadingDialog.dismiss(context);
        onSuccessSync();
      }
      ..onFailSync = (e) {
        print("onFailSync");
        if (context != null) LoadingDialog.dismiss(context);
        onFailSync(e);
      };
    syncMode.start();
  }

  static Future startAll(List<AbstractSyncMode> syncModeList,{OnSuccessSync onSuccessSync, OnFailSync onFailSync, BuildContext context}) async {
    if (context != null) LoadingDialog.show(context);
    for(AbstractSyncMode syncMode in syncModeList){
      await syncMode.start();
    }
    if (context != null) LoadingDialog.dismiss(context);

    bool isSuccess = syncModeList.every((syncMode){
      return syncMode.syncStatus == SyncStatus.SYNC_SUCCESS;
    });

    if(isSuccess) {
      onSuccessSync();
    }else{
      onFailSync('sync fail');
    }

  }
}


