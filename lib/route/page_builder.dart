import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019-11-19 10:11

typedef Widget HandlerFunc(
    BuildContext context, Map<String, List<String>> parameters);

typedef Widget PageBuilderFunc(Map<String, dynamic> bundle);

class PageBuilder {
  final PageBuilderFunc builder;
  HandlerFunc handlerFunc;

  PageBuilder({this.builder}) {
    handlerFunc = (context, _) {
      return this.builder(
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>);
    };
  }

  HandlerFunc getHandlerFunc() {
    return handlerFunc;
  }
}

enum PageName {
  root,
  settings,
  route,
  check_out_shipment,
  check_out,
  check_out_inventory,
  check_in_shipment,
  check_in,
  check_in_inventory,
  sync,
  route_plan,
  task_list,
  delivery,
  delivery_summary,
  visit_summary,
  visit_summary_detail,
  profile,
  document,
  print_delivery_slip,
}


