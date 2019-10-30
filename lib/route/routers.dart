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
  static const check_out_inventory = '/check_out_inventory';
  static const check_in_shipment = '/check_in_shipment';
  static const check_in = '/check_in';
  static const check_in_inventory = '/check_in_inventory';
  static const sync = '/sync';
  static const route_plan = '/route_plan';
  static const task_list = '/task_list';
  static const delivery = '/delivery';
  static const delivery_summary = '/delivery_summary';
  static const visit_summary = '/visit_summary';
  static const visit_summary_detail = '/visit_summary_detail';
  static const profile = '/profile';
  static const document = '/document';
  static const print_delivery_slip = '/print_delivery_slip';

  static configRouters(Router router) {
    router.notFoundHandler = notFoundHandler;
    router.define(root, handler: rootHandler);
    router.define(settings, handler: settingsHandler);
    router.define(route, handler: routeHandler);
    router.define(check_out_shipment, handler: checkoutShipmentHandler);
    router.define(check_out, handler: checkoutHandler);
    router.define(check_in_shipment, handler: checkInShipmentHandler);
    router.define(check_in_inventory, handler: checkInInventoryHandler);
    router.define(check_in, handler: checkInHandler);
    router.define(sync, handler: syncHandler);
    router.define(route_plan, handler: routePlanHandler);
    router.define(task_list, handler: taskListHandler);
    router.define(delivery, handler: deliveryHandler);
    router.define(delivery_summary, handler: deliverySummaryHandler);
    router.define(profile, handler: profileHandler);
    router.define(check_out_inventory, handler: checkoutInventoryHandler);
    router.define(visit_summary, handler: visitSummaryHandler);
    router.define(visit_summary_detail, handler: visitSummaryDetailHandler);
    router.define(document, handler: documentHandler);
    router.define(print_delivery_slip, handler: printDeliverySlipHandler);
  }
}
