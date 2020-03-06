import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_status.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/sync_factory.dart';
import 'package:dsd/ui/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'base/abstract_sync_mode.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/31 17:16

class SyncManager {
  static void start(SyncType syncType,
      {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync, BuildContext context}) {
    if (context != null) {
      if(syncType != SyncType.SYNC_UPLOAD_PHOTO){
        LoadingDialog.show(context);
      }
    }

    if (syncParameter == null) syncParameter = new SyncParameter();
    AbstractSyncMode syncMode = SyncFactory.createSyncModel(syncType);

    syncMode
      ..syncParameter = syncParameter
      ..onSuccessSync = () {
        print("onSuccessSync");

        if (context != null) {
          if(syncType != SyncType.SYNC_UPLOAD_PHOTO){
            LoadingDialog.dismiss(context);
          }
        }

        onSuccessSync();
      }
      ..onFailSync = (e) {
        print("onFailSync");

        if (context != null) {
          if(syncType != SyncType.SYNC_UPLOAD_PHOTO){
            LoadingDialog.dismiss(context);
          }
        }

        onFailSync(e);
      };
    syncMode.start();
  }

  static int _getCompleteSyncCount(List<AbstractSyncMode> syncModeList){
    int count = 0;
    for(AbstractSyncMode syncMode in syncModeList){
      if(syncMode.syncStatus == SyncStatus.SYNC_FAIL || syncMode.syncStatus == SyncStatus.SYNC_SUCCESS){
        count++;
      }
    }
    return count;
  }

  static Future startAll(List<AbstractSyncMode> syncModeList,{OnSuccessSync onSuccessSync, OnFailSync onFailSync, BuildContext context}) async {
    if (context != null) LoadingDialog.show(context);
    final BehaviorSubject<int> subject = BehaviorSubject<int>();
    for(AbstractSyncMode syncMode in syncModeList){
      syncMode
        ..onSuccessSync = () {
          int completeSyncCount = _getCompleteSyncCount(syncModeList);
          subject.add(completeSyncCount);
        }
        ..onFailSync = (e) {
          int completeSyncCount = _getCompleteSyncCount(syncModeList);
          subject.add(completeSyncCount);
        };
      syncMode.start();
    }

    subject.listen((data){
      if(data == syncModeList.length){
        subject.close();
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
    });


  }
}



