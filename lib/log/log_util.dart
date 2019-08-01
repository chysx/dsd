import 'package:logger/logger.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/26 17:46

class Log {
  static Log _instance;
  Logger logger;

  Log._();

  static Log _getInstance() {
    if (_instance == null) {
      _instance = new Log._();
      _instance.logger = new Logger(printer: PrettyPrinter());
    }
    return _instance;
  }

  factory Log() => _getInstance();
}
