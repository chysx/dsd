import 'abstract_sync_mode.dart';
import 'i_request.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 11:47

abstract class AbstractRequest<T> implements IRequest<T> {
  AbstractSyncMode syncMode;
  bool isShow;

  void setSyncMode(AbstractSyncMode syncMode) {
    this.syncMode = syncMode;
  }

  void show() {}

  void dismiss() {}
}
