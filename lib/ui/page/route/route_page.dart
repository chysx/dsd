import 'package:dsd/db/util.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/20 10:41

class RoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RouteState();
  }

}

class _RouteState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: GestureDetector(
        child: Text('Route'),
        onLongPress: () {
          DbUtil.copyDb();
        },
      ),),
      body: Center(
        child: Text('body'),
      ),
    );
  }

}