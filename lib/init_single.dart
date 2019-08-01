import 'package:dsd/db/database.dart';
import 'package:dsd/device_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/1 14:29

class InitSingle {
  static void init() {
    DbHelper();
    DeviceInfo();
  }
}