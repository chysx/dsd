import 'package:dsd/route/route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'page_builder.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 14:52

class Routers {

  static configRouters(Router router) {
    Map<PageName, PageBuilder> pageRoutes = {
      PageName.root: rootHandler,
      PageName.route: routeHandler,
      PageName.settings: settingsHandler,
      PageName.check_out_shipment: checkoutShipmentHandler,
      PageName.check_out: checkoutHandler,
      PageName.check_out_inventory: checkoutInventoryHandler,
      PageName.check_in_shipment: checkInShipmentHandler,
      PageName.check_in: checkInHandler,
      PageName.check_in_inventory: checkInInventoryHandler,
      PageName.sync: syncHandler,
      PageName.route_plan: routePlanHandler,
      PageName.task_list: taskListHandler,
      PageName.delivery: deliveryHandler,
      PageName.delivery_summary: deliverySummaryHandler,
      PageName.visit_summary: visitSummaryHandler,
      PageName.visit_summary_detail: visitSummaryDetailHandler,
      PageName.profile: profileHandler,
      PageName.document: documentHandler,
      PageName.print_delivery_slip: printDeliverySlipHandler,
    };
    pageRoutes.forEach((pageName,pageBuilder){
      router.define(pageName.toString(), handler: Handler(handlerFunc:pageBuilder.getHandlerFunc()),transitionType: TransitionType.inFromLeft);
    });
  }
}
