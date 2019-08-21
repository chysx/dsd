import 'package:dio/dio.dart';
import 'package:dsd/log/log_util.dart';
import 'package:dsd/ui/page/login/user.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:logger/logger.dart';

import 'db/database.dart';
import 'net/http_service.dart';
import 'utils/device_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 14:28

class Application {
  static AppDatabase database;
  static Logger logger;
  static Dio httpService;
  static Router router;
  static DeviceInfo deviceInfo;
  static User user;

  static void install() {
    new DbHelper();
    deviceInfo = new DeviceInfo();
    Future.delayed(new Duration(seconds: 3),(){
      database = new DbHelper().database;
      print('database = $database');
    });
    logger = new Log().logger;
    httpService = new HttpService().dio;
    router = new Router();
    DirectoryUtil.getInstance();
    user = new User();
  }
}
