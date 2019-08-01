import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:rxdart/rxdart.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 11:46

abstract class IRequest<T> {
  void execute(Observable<T> observable, SyncCallBack syncCallBack);
}
