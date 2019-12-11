/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 17:10

class Constant {
  static const String DB_NAME = "dsd.db";
  static const String WORK_DB = 'db';
  static const String WORK_IMG = 'img';
  static const String WORK_LOG = 'log';
}

class ConstantMenu {
  static const String CHECK_OUT = 'Check Out';
  static const String CHECK_IN = 'Check In';
  static const String ROUTE = 'Route';
  static const String SYNC = 'Sync';
  static const String SETTING = 'Setting';
  static const String LOGOUT = 'Logout';
}

class FragmentArg {
  static const String CHECKOUT_SHIPMENT_NO = "shipment_no";
  static const String CHECKOUT_SHIPMENT_FLAG = "flag";
  static const String TASK_SHIPMENT_NO = "shipment_no";
  static const String TASK_ACCOUNT_NUMBER = "account_number";
  static const String TASK_NO_SCAN_REASON = "no_scan_reason";
  static const String TASK_SHIPMENT_TYPE = "task_shipment_type";
  static const String TASK_CUSTOMER_NAME = "TASK_CUSTOMER_NAME";
  static const String TASK_CUSTOMER_TYPE = "TASK_CUSTOMER_TYPE";
  static const String TASK_IS_BLOCK = "TASK_IS_BLOCK";
  static const String DELIVERY_VISIT_NO = "visit_id";
  static const String DELIVERY_NO = "delivery_no";
  static const String DELIVERY_SHIPMENT_NO = "delivery_shipment_no";
  static const String DELIVERY_ACCOUNT_NUMBER = "delivery_account_number";
  static const String ROUTE_SHIPMENT_NO = "route_shipment_no";
  static const String ROUTE_ACCOUNT_NUMBER = "route_account_number";
  static const String ROUTE_DELIVERY_NO = "route_delivery_no";
  static const String ROUTE_DELIVERY_ADDRESS = "route_delivery_address";
  static const String ROUTE_DELIVERY_TYPE = "route_delivery_type";
  static const String ROUTE_ORDER_NO = "route_order_no";
  static const String ROUTE_CONFIG_INFO = "route_config_info";
  static const String DELIVERY_SUMMARY_READONLY = "delivery_summary_readonly";
  static const String CHECKIN_SHIPMENTS = "checkin_shipments";
  static const String ARCOLLECTION_MODEL = "arcollection_models";
  static const String VISIT_TASK_NO = "visit_task_no";
  static const String VISIT_TASK_TYPE = "visit_task_type";
  static const String DELIVERY_TYPE = "delivery_type";
  static const String MAP_CUSTOMER_LIST = "map_customer_list";
  static const String NAVIGATION_CUSTOMER = "navigation_customer";
  static const String PRE_SALES_SELECTITEMS = "pre_sales_selectitems";
  static const String PRINT_PRAMETER = "print_prameter";
  static const String IS_FROM_VISIT = "is_from_visit";
}

class ReadyOnly {
  static const String TRUE = "true";
  static const String FALSE = "false";
}

String getMonth(int monthInt) {
  List<String> months = <String>['Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'];
  return months[monthInt - 1];
}
