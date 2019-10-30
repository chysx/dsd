import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/synchronization/base/abstract_sync_mode.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/sync_manager.dart';
import 'package:dsd/synchronization/utils/sync_manager_util.dart';
import 'package:dsd/ui/dialog/signature_dialog.dart';
import 'package:dsd/ui/page/sync/sync_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/23 10:14

enum SyncEvent { InitData }

class SyncPresenter extends EventNotifier<SyncEvent> {
  List<SyncInfo> syncCheckOutList = [];
  List<SyncInfo> syncCheckInList = [];
  List<SyncInfo> syncVisitList = [];

  @override
  void onEvent(SyncEvent event, [dynamic data]) async {
    switch (event) {
      case SyncEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  Future initData() async {
    syncCheckOutList = await SyncManagerUtil.getSyncInfoList(SyncType.SYNC_UPLOAD_CHECKOUT);
    syncCheckInList = await SyncManagerUtil.getSyncInfoList(SyncType.SYNC_UPLOAD_CHECKIN);
    syncVisitList = await SyncManagerUtil.getSyncInfoList(SyncType.SYNC_UPLOAD_VISIT);
  }

  void onClickInit(BuildContext context) {
    SyncManager.start(SyncType.SYNC_INIT, context: context, onSuccessSync: () {
      Fluttertoast.showToast(msg: "onSuccessSync");
      onEvent(SyncEvent.InitData);
    }, onFailSync: (e) {
//      appConfigEntity.syncInitFlag = null;
      Fluttertoast.showToast(msg: "onFailSync");
      onEvent(SyncEvent.InitData);
    });
  }

  void onClickUpdate(BuildContext context) {
    SignatureDialog.show(context);
  }

  void onClickUpload(BuildContext context, int index) {
    List<AbstractSyncMode> syncModeList = [];
    if (index == 0) {
      syncModeList = syncCheckOutList.map((item) {
        return item.syncMode;
      }).toList();
    } else if (index == 1) {
      syncModeList = syncVisitList.map((item) {
        return item.syncMode;
      }).toList();
    } else if (index == 2) {
      syncModeList = syncCheckInList.map((item) {
        return item.syncMode;
      }).toList();
    }

    if(syncModeList.length <= 0){
      Fluttertoast.showToast(msg: "No data to be uploaded.");
      return;
    }

    SyncManager.startAll(syncModeList, context: context,
        onSuccessSync: () {
          Fluttertoast.showToast(msg: "The data upload success.");
          onEvent(SyncEvent.InitData);
        },
        onFailSync: (e) {
          Fluttertoast.showToast(msg: "The data upload failed.");
          onEvent(SyncEvent.InitData);
        });
  }
}
