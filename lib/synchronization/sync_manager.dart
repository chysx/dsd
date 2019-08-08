import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_constant.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/ui/dialog/dialog.dart';
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
    if (context != null) LoadingDialog.showLoadingDialog(context);
    if (syncParameter == null) syncParameter = new SyncParameter();
    new SyncInitModel(syncType, syncParameter: syncParameter, onSuccessSync: () {
      print("onSuccessSync");
      if (context != null) LoadingDialog.dismiss(context);
      onSuccessSync();
    }, onFailSync: (e) {
      print("onFailSync");
      if (context != null) LoadingDialog.dismiss(context);

      onFailSync(e);
    }).start();
  }
}
