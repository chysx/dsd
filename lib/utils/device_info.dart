import 'package:package_info/package_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/1 14:32

class DeviceInfo {
  static DeviceInfo _instance;
  String versionName;

  DeviceInfo._();

  static DeviceInfo _getInstance() {
    if (_instance == null) {
      _instance = DeviceInfo._();
      _initDeviceInfo(_instance);
    }
    return _instance;
  }

  static Future _initDeviceInfo(DeviceInfo deviceInfo) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    deviceInfo.versionName = packageInfo.version;
  }

  factory DeviceInfo() => _getInstance();
}
