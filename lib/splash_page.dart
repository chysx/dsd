import 'package:dsd/route/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/28 17:26

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(new Duration(seconds: 3),(){
      Application.initDataBase();
      Application.router
          .navigateTo(context, Routers.root, replace:true,transition: TransitionType.inFromLeft);
    });
    return Scaffold(
      body: Container(
        color: Color(0xFFFDF2E4),
        child: Center(
          child: Image.asset(
            'assets/imgs/login_logo_960.png',
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}