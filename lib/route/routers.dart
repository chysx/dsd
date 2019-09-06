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
  static const route = '/route';
  static const check_out_shipment = '/check_out_shipment';
  static const check_out = '/check_out';
  static const check_in_shipment = '/check_in_shipment';
  static const sync = '/sync';
  static const route_plan = '/route_plan';

  static configRouters(Router router) {
    router.notFoundHandler = notFoundHandler;
    router.define(root, handler: rootHandler);
    router.define(settings, handler: settingsHandler);
    router.define(route, handler: routeHandler);
    router.define(check_out_shipment, handler: checkoutShipmentHandler);
    router.define(check_out, handler: checkoutHandler);
    router.define(check_in_shipment, handler: checkInShipmentHandler);
    router.define(sync, handler: syncHandler);
    router.define(route_plan, handler: routePlanHandler);
  }
}
