import 'package:dsd/application.dart';
import 'package:dsd/route/routers.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';

import 'res/strings.dart';

void main() {
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Application.router.generator,
      localizationsDelegates: [CustomLocalizations.delegate],
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }

  @override
  void initState() {
    super.initState();
    setLocalizedSimpleValues(localizedSimpleValues);
  }
}
