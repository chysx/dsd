
import 'package:dsd/ui/page/checkin/checkin_shipment_page.dart';
import 'package:dsd/ui/page/checkout/checkout_shipment_page.dart';
import 'package:dsd/ui/page/login/login_page.dart';
import 'package:dsd/ui/page/login/login_presenter.dart';
import 'package:dsd/ui/page/route/route_page.dart';
import 'package:dsd/ui/page/settings/settings_page.dart';
import 'package:dsd/ui/page/settings/settings_presenter.dart';
import 'package:dsd/ui/page/sync/sync_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

Handler routeHandler = Handler(handlerFunc: (_,params) {
  return RoutePage();
});

Handler checkoutShipmentHandler = Handler(handlerFunc: (_,params) {
  return CheckoutShipmentPage();
});

Handler checkInShipmentHandler = Handler(handlerFunc: (_,params) {
  return CheckInShipmentPage();
});

Handler syncHandler = Handler(handlerFunc: (_,params) {
  return SyncPage();
});
