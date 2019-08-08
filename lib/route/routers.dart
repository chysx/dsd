import 'package:dsd/route/route_handlers.dart';
import 'package:fluro/fluro.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 14:52

class Routers {
  static const root = '/';
  static const settings = '/settings';

  static configRouters(Router router) {
    router.notFoundHandler = notFoundHandler;
    router.define(root, handler: rootHandler);
    router.define(settings, handler: settingsHandler);
  }
}
