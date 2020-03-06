import 'package:dsd/synchronization/base/abstract_sync_mode.dart';
import 'package:dsd/synchronization/sync/sync_status.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/utils/sync_util.dart';
import 'package:rxdart/src/observables/observable.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-02-27 18:43

class SyncUploadPhotoModel extends AbstractSyncMode {
  SyncUploadPhotoModel(SyncType syncType) : super(syncType);

  @override
  Future start() {
    request.execute(null,onSuccessSync: onSuccessSync, onFailSync: onFailSync);
  }

  @override
  void onSuccess() {
    super.onSuccess();

    SyncUtil.updateStatus(syncParameter,syncType, SyncStatus.SYNC_SUCCESS);
  }

  @override
  void onFail() {
    super.onFail();
    SyncUtil.updateStatus(syncParameter,syncType, SyncStatus.SYNC_FAIL);
  }

  @override
  void onLoad() {
    super.onLoad();
    SyncUtil.updateStatus(syncParameter,syncType, SyncStatus.SYNC_LOAD);
  }

  @override
  bool isAllDataAndAllInsert(String tableName) {
    return false;
  }

  @override
  void policy() {
  }

  @override
  Future<Observable> prepare() {
    return null;
  }

}