import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_constant.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'base/abstract_sync_mode.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/31 17:16

class SyncManager {
  registerSyncModel(AbstractSyncMode syncMode, SyncParameter syncParameter,
      SyncCallBack callBackBack) {
    syncParameter
        .putCommon(SyncConstant.USER_CODE, "D5096")
        .putCommon(SyncConstant.PASSWORD, "11111111");
    syncMode.setSyncCallBack(callBackBack);
    syncMode.setParameter(syncParameter);
    syncMode.start();
  }
}
