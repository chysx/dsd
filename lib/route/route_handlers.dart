import 'package:dsd/common/constant.dart';
import 'package:dsd/ui/page/checkin/checkin_shipment_page.dart';
import 'package:dsd/ui/page/checkout/checkout_inventory_page.dart';
import 'package:dsd/ui/page/checkout/checkout_inventory_presenter.dart';
import 'package:dsd/ui/page/checkout/checkout_page.dart';
import 'package:dsd/ui/page/checkout/checkout_presenter.dart';
import 'package:dsd/ui/page/checkout/checkout_shipment_page.dart';
import 'package:dsd/ui/page/checkout/checkout_shipment_presenter.dart';
import 'package:dsd/ui/page/delivery/delivery_page.dart';
import 'package:dsd/ui/page/delivery/delivery_presenter.dart';
import 'package:dsd/ui/page/delivery_summary/delivery_summary_page.dart';
import 'package:dsd/ui/page/delivery_summary/delivery_summary_presenter.dart';
import 'package:dsd/ui/page/login/login_page.dart';
import 'package:dsd/ui/page/login/login_presenter.dart';
import 'package:dsd/ui/page/profile/profile_page.dart';
import 'package:dsd/ui/page/profile/profile_presenter.dart';
import 'package:dsd/ui/page/route/route_page.dart';
import 'package:dsd/ui/page/route/route_presenter.dart';
import 'package:dsd/ui/page/route_plan/route_plan_page.dart';
import 'package:dsd/ui/page/route_plan/route_plan_presenter.dart';
import 'package:dsd/ui/page/settings/settings_page.dart';
import 'package:dsd/ui/page/settings/settings_presenter.dart';
import 'package:dsd/ui/page/sync/sync_page.dart';
import 'package:dsd/ui/page/task_list/task_list_page.dart';
import 'package:dsd/ui/page/task_list/task_list_presenter.dart';
import 'package:fluro/fluro.dart';

import '../application.dart';
import 'package:provider/provider.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 15:17

Handler notFoundHandler = Handler(handlerFunc: (_, params) {
  Application.logger.i('not found router');
  return null;
});

Handler rootHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(builder: (context) => new LoginPresenter()..initData()),
    ],
    child: LoginPage(),
  );
});

Handler settingsHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(builder: (context) => new SettingPresenter()..initData()),
    ],
    child: SettingsPage(),
  );
});

Handler routeHandler = Handler(handlerFunc: (_, params) {
  RouteTitle routeTitle = new RouteTitle();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<RouteTitle>(builder: (context) => routeTitle),
      ChangeNotifierProvider<RoutePresenter>(
          builder: (context) => new RoutePresenter()
            ..routeTitle = routeTitle
            ..onEvent(RouteEvent.InitData)),
    ],
    child: RoutePage(),
  );
});

Handler checkoutShipmentHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      //ChangeNotifierProvider(builder: (context) => new CheckoutShipmentPresenter()..initData()),

      ChangeNotifierProvider<CheckoutShipmentPresenter>(
          builder: (context) => new CheckoutShipmentPresenter()..onEvent(ShipmentEvent.InitData)),
    ],
    child: CheckoutShipmentPage(),
  );
});

Handler checkoutHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
          builder: (context) => new CheckoutPresenter()
            ..setPageParams(params)
            ..onEvent(CheckOutEvent.InitData)),
    ],
    child: CheckoutPage(),
  );
});

Handler checkoutInventoryHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
          builder: (context) => new CheckoutInventoryPresenter()
            ..setPageParams(params)
            ..onEvent(CheckOutInventoryEvent.InitData)),
    ],
    child: CheckoutInventoryPage(),
  );
});

Handler checkInShipmentHandler = Handler(handlerFunc: (_, params) {
  return CheckInShipmentPage();
});

Handler syncHandler = Handler(handlerFunc: (_, params) {
  return SyncPage();
});

Handler routePlanHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
          builder: (context) => new RoutePlanPresenter()
            ..setPageParams(params)
            ..onEvent(RoutePlanEvent.InitData)),
    ],
    child: RoutePlanPage(),
  );
});

Handler taskListHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<TaskListPresenter>(
          builder: (context) => new TaskListPresenter()
            ..setPageParams(params)
            ..onEvent(TaskListEvent.InitData)),
    ],
    child: TaskListPage(),
  );
});

Handler deliveryHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<DeliveryPresenter>(
          builder: (context) => new DeliveryPresenter()
            ..setPageParams(params)
            ..onEvent(DeliveryEvent.InitData)),
    ],
    child: DeliveryPage(),
  );
});

Handler deliverySummaryHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<DeliverySummaryPresenter>(
          builder: (context) => new DeliverySummaryPresenter()
            ..setPageParams(params)
            ..onEvent(DeliverySummaryEvent.InitData)),
    ],
    child: DeliverySummaryPage(),
  );
});

Handler profileHandler = Handler(handlerFunc: (_, params) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ProfilePresenter>(
          builder: (context) => new ProfilePresenter()
            ..setPageParams(params)
            ..onEvent(ProfileEvent.InitData)),
    ],
    child: ProfilePage(),
  );
});
