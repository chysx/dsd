import 'package:rxdart/rxdart.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/26 16:46

abstract class ISyncFlow<T> {
  Future<Observable<T>> prepare();

  void start();
}
