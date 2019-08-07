import 'package:dsd/bloc/bloc_base.dart';
import 'package:dsd/bloc/setting_bloc.dart';
import 'package:dsd/ui/page/login.dart';
import 'package:dsd/ui/page/settings/settings_page.dart';
import 'package:fluro/fluro.dart';

import '../application.dart';

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

Handler rootHandler = Handler(handlerFunc: (_, params) => LoginPage());

Handler settingsHandler = Handler(handlerFunc: (_, params) {
  return BlocProvider(
    bloc: new SettingBloc(),
    child: SettingsPage(),
  );
});
