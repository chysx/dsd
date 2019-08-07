import 'package:dsd/synchronization/base/abstract_request.dart';
import 'package:dsd/synchronization/base/abstract_sync_mode.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:rxdart/src/observables/observable.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 16:14

 class RxPhotoRequest extends AbstractRequest<void> {

  RxPhotoRequest(AbstractSyncMode syncMode) : super(syncMode);


  @override
  void execute(Observable<void> observable, {onSuccessSync, onFailSync}) {
    // TODO: implement execute
  }

}