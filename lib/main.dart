
import 'package:dsd/application.dart';
import 'package:dsd/res/colors.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/splash_page.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'res/strings.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Application.install();
  Routers.configRouters(Application.router);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCH',
      theme: ThemeData(
        primarySwatch: ColorsRes.themTitle,
      ),
      onGenerateRoute: Application.router.generator,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      supportedLocales: CustomLocalizations.supportedLocales,
      home: SplashPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    setLocalizedSimpleValues(localizedSimpleValues);
  }
}