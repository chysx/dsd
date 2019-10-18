import 'package:dsd/common/constant.dart';
import 'package:dsd/res/dimens.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/26 17:38

//class DrawerWidget extends StatelessWidget {
//  final List<MenuInfo> menuInfoList = [];
//  final String page;
//  DrawerWidget({this.page,Key key}): super(key: key) {
//    MenuInfo menuInfo = new MenuInfo();
//    menuInfo
//      ..page = ConstantMenu.CHECK_OUT
//      ..title = ConstantMenu.CHECK_OUT
//      ..imgPath = 'assets/imgs/menu_check_out.png';
//    menuInfo
//      ..page = ConstantMenu.CHECK_IN
//      ..title = ConstantMenu.CHECK_IN
//      ..imgPath = 'assets/imgs/menu_check_in.png';
//    menuInfo
//      ..page = ConstantMenu.SYNC
//      ..title = ConstantMenu.SYNC
//      ..imgPath = 'assets/imgs/menu_sync.png';
//    menuInfo
//      ..page = ConstantMenu.SETTING
//      ..title = ConstantMenu.SETTING
//      ..imgPath = 'assets/imgs/menu_setting.png';
//    menuInfo
//      ..page = ConstantMenu.ROUTE
//      ..title = ConstantMenu.CHECK_OUT
//      ..imgPath = 'assets/imgs/menu_route.png';
//    menuInfo
//      ..page = ConstantMenu.LOGOUT
//      ..title = ConstantMenu.CHECK_OUT
//      ..imgPath = '';
//    menuInfoList.add(menuInfo);
//
//    _setCurMenuInfo();
//  }
//
//  _setCurMenuInfo(){
//    for(MenuInfo menuInfo in menuInfoList){
//      if(menuInfo.page == page){
//        menuInfo.isSelect = true;
//      }
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return _buildDrawer(context);
//  }
//
//  void _onTap(BuildContext context, String goPage) {
//    print('page = $goPage');
////    Navigator.pop(context);
//    if(page != goPage){
//      if(goPage == ConstantMenu.CHECK_OUT){
//        curPage = ConstantMenu.CHECK_OUT;
//        Application.router
//            .navigateTo(context, Routers.check_out_shipment, replace: true, transition: TransitionType.inFromLeft);
//      }
//      if(goPage == ConstantMenu.CHECK_IN){
//        curPage = ConstantMenu.CHECK_IN;
//        Application.router
//            .navigateTo(context, Routers.check_in_shipment, replace: true, transition: TransitionType.inFromLeft);
//      }
//      if(goPage == ConstantMenu.ROUTE){
//        curPage = ConstantMenu.ROUTE;
//        Application.router
//            .navigateTo(context, Routers.route, replace: true, transition: TransitionType.inFromLeft);
//      }
//      if(goPage == ConstantMenu.SYNC){
//        Application.router
//            .navigateTo(context, Routers.sync, replace: false, transition: TransitionType.inFromLeft);
//      }
//      if(goPage == ConstantMenu.SETTING){
//        Application.router
//            .navigateTo(context, Routers.settings, replace: false, transition: TransitionType.inFromLeft);
//      }
//    }
//  }
//
//  Widget _buildHeader() {
//    return DrawerHeader(
//        padding: EdgeInsets.zero,
//        child: Container(
//          color: Colors.blue,
//          child: Stack(
//            alignment: FractionalOffset.bottomLeft,
//            children: <Widget>[
//              Container(
//                height: 80,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    Image.asset('assets/imgs/icon_user.png'),
//                    Container(
//                      margin: EdgeInsets.only(left: 20),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Text(
//                            'Phil',
//                            style: TextStyles.normal,
//                          ),
//                          Text(
//                            'phil@ebest.mobile',
//                            style: TextStyles.small,
//                          )
//                        ],
//                      ),
//                    )
//                  ],
//                ),
//              )
//            ],
//          ),
//        ));
//  }
//
//  List<Widget> _buildContent(BuildContext context) {
//    return menuInfoList.map((menu){
//      return Container(
//        color: menu.isSelect ? Colors.blue : Colors.grey,
//        child: ListTile(
//          leading: Image.asset(menu.imgPath),
//          title: Text(
//            menu.title,
//            style: TextStyle(color: Colors.white, fontSize: Dimens.font_normal),
//          ),
//          onTap: () {
//            _onTap(context, menu.page);
//          },
//        ),
//      );
//    }).toList();
//  }
//
//
//  Widget _buildDrawer(BuildContext context) {
//    List<Widget> list = [];
//    list.add(_buildHeader());
//    list.addAll(_buildContent(context));
//    return Drawer(
//      child: Container(
//        color: Colors.grey,
//        child: ListView(
//          padding: EdgeInsets.zero,
//          children: list,
//        ),
//      ),
//    );
//  }
//}
//
//class MenuInfo {
//  bool isSelect = false;
//  String imgPath;
//  String title;
//  String page;
//}