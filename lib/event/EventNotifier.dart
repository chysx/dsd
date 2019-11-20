import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/15 10:35

class EventNotifier<T> with ChangeNotifier{
  @mustCallSuper
  void onEvent(T event,[dynamic data]){
    notifyListeners();
  }
}