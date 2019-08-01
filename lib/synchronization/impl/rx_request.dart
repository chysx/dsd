import 'package:dio/dio.dart';
import 'package:dsd/db/manager/app_log_manager.dart';
import 'package:dsd/exception/exception_type.dart';
import 'package:dsd/log/log_util.dart';
import 'package:dsd/synchronization/base/abstract_request.dart';
import 'package:dsd/synchronization/bean/sync_response_bean.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_status.dart';
import 'package:rxdart/rxdart.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 15:29

class RxRequest extends AbstractRequest<Response<Map<String, dynamic>>> {
  RxRequest() {
    isShow = true;
  }

  @override
  void execute(
      Observable<Response<Map<String, dynamic>>> observable, SyncCallBack syncCallBack) {
    AppLogManager.insert(
        ExceptionType.INFO.toString(), syncMode.getSyncType().toString());

    observable.flatMap((syncDataBean) {
      return Observable.fromFuture(syncMode.getParser().parse(syncDataBean));
    }).map((isSuccess) {
      if (!isSuccess) {
//        AppLogManager.insert(
//            ExceptionType.WARN.toString(), syncDataBean.toString());
      }
      return isSuccess;
    }).listen((isSuccess) {
      if (isSuccess) {
        AppLogManager.insert(
            ExceptionType.INFO.toString(),
            syncMode.getSyncType().toString() +
                ":" +
                SyncStatus.SYNC_SUCCESS.toString());
        syncMode.onSuccess();
        if (syncCallBack != null) {
          syncCallBack.onSuccess();
        }
      } else {
        AppLogManager.insert(
            ExceptionType.INFO.toString(),
            syncMode.getSyncType().toString() +
                ":" +
                SyncStatus.SYNC_FAIL.toString());
        syncMode.onFail();
        if (syncCallBack != null) {
          syncCallBack.onFail(new Exception("False"));
        }
      }
    }, onError: (e) {
      AppLogManager.insert(ExceptionType.WARN.toString(), e);
      Log().logger.e(e.toString());
      try {
        AppLogManager.insert(
            ExceptionType.INFO.toString(),
            syncMode.getSyncType().toString() +
                ":" +
                SyncStatus.SYNC_FAIL.toString());
        syncMode.onFail();
      } catch (ex) {
        Log().logger.e(e.toString());
        AppLogManager.insert(ExceptionType.WARN.toString(), ex);
      }

      try {
        if (syncCallBack != null) {
          syncCallBack.onFail(e);
        }
      } catch (ex) {
        Log().logger.e(e.toString());
        AppLogManager.insert(ExceptionType.WARN.toString(), ex);
      }
      syncMode.onFinish();
    }, onDone: () {syncMode.onFinish();});
  }
}

