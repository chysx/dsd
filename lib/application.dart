import 'package:dio/dio.dart';
import 'package:dsd/log/log_util.dart';
import 'package:fluro/fluro.dart';
import 'package:logger/logger.dart';

import 'db/database.dart';
import 'net/http_service.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 14:28

class Application {
  static AppDatabase database = new DbHelper().database;
  static Logger logger = new Log().logger;
  static Dio httpService = new HttpService().dio;
  static Router router = new Router();
}