import 'package:dsd/common/constant.dart';
import 'package:dsd/res/dimens.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/route/page_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/26 17:38

class DrawerWidget extends StatelessWidget {
  final List<MenuInfo> menuInfoList = [];
  final String page;

  DrawerWidget({this.page, Key key}) : super(key: key) {
    MenuInfo menuInfo1 = new MenuInfo();
    menuInfo1
      ..page = ConstantMenu.CHECK_OUT
      ..title = ConstantMenu.CHECK_OUT
      ..imgPath = 'assets/imgs/menu_check_out.png';

    MenuInfo menuInfo2 = new MenuInfo();
    menuInfo2
      ..page = ConstantMenu.ROUTE
      ..title = ConstantMenu.ROUTE
      ..imgPath = 'assets/imgs/menu_route.png';

    MenuInfo menuInfo3 = new MenuInfo();
    menuInfo3
      ..page = ConstantMenu.CHECK_IN
      ..title = ConstantMenu.CHECK_IN
      ..imgPath = 'assets/imgs/menu_check_in.png';

    MenuInfo menuInfo4 = new MenuInfo();
    menuInfo4
      ..page = ConstantMenu.SYNC
      ..title = ConstantMenu.SYNC
      ..imgPath = 'assets/imgs/menu_sync.png';

    MenuInfo menuInfo5 = new MenuInfo();
    menuInfo5
      ..page = ConstantMenu.SETTING
      ..title = ConstantMenu.SETTING
      ..imgPath = 'assets/imgs/menu_setting.png';

    MenuInfo menuInfo6 = new MenuInfo();
    menuInfo6
      ..page = ConstantMenu.LOGOUT
      ..title = ConstantMenu.LOGOUT
      ..imgPath = 'assets/imgs/menu_log_out.png';

    menuInfoList.add(menuInfo1);
    menuInfoList.add(menuInfo2);
    menuInfoList.add(menuInfo3);
    menuInfoList.add(menuInfo4);
    menuInfoList.add(menuInfo5);
    menuInfoList.add(menuInfo6);

    _setCurMenuInfo();
  }

  _setCurMenuInfo() {
    for (MenuInfo menuInfo in menuInfoList) {
      if (menuInfo.page == page) {
        menuInfo.isSelect = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildDrawer(context);
  }

  void _onTap(BuildContext context, String goPage) {
    print('page = $goPage');
    if (page != goPage) {
      if (goPage == ConstantMenu.CHECK_OUT) {
        Navigator.pushReplacementNamed(context, PageName.check_out_shipment.toString(),arguments: <String,dynamic>{});
      }
      if (goPage == ConstantMenu.CHECK_IN) {
        Navigator.pushReplacementNamed(context, PageName.check_in_shipment.toString(),arguments: <String,dynamic>{});

      }
      if (goPage == ConstantMenu.ROUTE) {
        Navigator.pushReplacementNamed(context, PageName.route.toString(),arguments: <String,dynamic>{});

      }
      if (goPage == ConstantMenu.SYNC) {
        Navigator.pushReplacementNamed(context, PageName.sync.toString(),arguments: <String,dynamic>{});

      }
      if (goPage == ConstantMenu.SETTING) {
        Navigator.pushReplacementNamed(context, PageName.settings.toString(),arguments: <String,dynamic>{});

      }
    }
  }

  Widget _buildHeader() {
    return DrawerHeader(
        padding: EdgeInsets.zero,
        child: Container(
          color: Colors.blue,
          child: Stack(
            alignment: FractionalOffset.centerLeft,
            children: <Widget>[
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Image.asset('assets/imgs/login_logo_480.png'),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                    ),
                    Expanded(
                      child: Text(
                        Application.user.userName,
                        style: TextStyles.normal,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> _buildContent(BuildContext context) {
    return menuInfoList.map((menu) {
      return Container(
        color: menu.isSelect ? Colors.blue : Colors.grey,
        child: ListTile(
          leading: Image.asset(menu.imgPath),
          title: Text(
            menu.title,
            style: TextStyle(color: Colors.white, fontSize: Dimens.font_normal),
          ),
          onTap: () {
            _onTap(context, menu.page);
          },
        ),
      );
    }).toList();
  }

  Widget _buildDrawer(BuildContext context) {
    List<Widget> list = [];
    list.add(_buildHeader());
    list.addAll(_buildContent(context));
    return Drawer(
      child: Container(
        color: Colors.grey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: list,
        ),
      ),
    );
  }
}

class MenuInfo {
  bool isSelect = false;
  String imgPath;
  String title;
  String page;
}
