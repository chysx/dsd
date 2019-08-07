
import 'package:dsd/application.dart';
import 'package:dsd/route/routers.dart';
import 'package:flutter/material.dart';

void main(){
  Application.install();
  Routers.configRouters(Application.router);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Application.router.generator,
    );
  }
}