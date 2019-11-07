import 'package:dsd/db/dao/app_log_dao.dart';
import 'package:dsd/db/database.dart';
import 'package:dsd/db/table/app_log_entity.dart';
import 'package:dsd/synchronization/sync/sync_dirty_status.dart';
import 'package:flustars/flustars.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:uuid/uuid.dart';

import 'dart:io';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 16:51

class AppLogManager {
  static Future insert(String type, {String msg, dynamic error}) async {
    AppLogDao dao = new DbHelper().database.appLogDao;
    if (error != null) {
      msg = msg?? "";
      msg = msg + "  \n" + error.toString();
    }
    AppLogEntity entity = await _createAppLogEntity(type, msg);
    await dao.insertEntity(entity);
  }

  static Future<AppLogEntity> _createAppLogEntity(String type, String content) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppLogEntity entity = new AppLogEntity();
    entity
      ..id = Uuid().v1()
      ..versionName = packageInfo.version
      ..type = type
      ..device = await createDeviceInfo()
      ..content = content
      ..stackTrace = ""
      ..time = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.NORMAL)
      ..dirty = SyncDirtyStatus.DEFAULT;
    return entity;
  }

  static Future<String> createDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    StringBuffer sb = new StringBuffer();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      sb..write("VersionName = ")..write(packageInfo.version)..write(";");
      sb..write("VersionCode = ")..write(packageInfo.buildNumber)..write(";");
      sb..write("SdkLevel = ")..write(androidInfo.version.sdkInt)..write(";");
      sb..write("SdkVersion = ")..write(androidInfo.version)..write(";");
      sb..write("Brand = ")..write(androidInfo.brand)..write(";");
      sb..write("Model = ")..write(androidInfo.model);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      sb..write("VersionName = ")..write(packageInfo.version)..write(";");
      sb..write("VersionCode = ")..write(packageInfo.buildNumber)..write(";");
      sb..write("SdkVersion = ")..write(iosInfo.systemVersion)..write(";");
      sb..write("Model = ")..write(iosInfo.model);
    }

    return sb.toString();
  }
}
