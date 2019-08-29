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

String curPage = ConstantMenu.CHECK_OUT;
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildDrawer(context);
  }

  Color _getColor(String page){
    return page == curPage ? Colors.blue : Colors.grey;
  }

  void _onTap(BuildContext context,String page){
    print('page = $page');
    Navigator.pop(context);
    if(page == ConstantMenu.CHECK_OUT){
      if(curPage != ConstantMenu.CHECK_OUT){
        Application.router
            .navigateTo(context, Routers.check_out_shipment, replace: true,transition: TransitionType.inFromLeft);
        curPage = ConstantMenu.CHECK_OUT;
      }
    }else if(page == ConstantMenu.ROUTE){
      if(curPage != ConstantMenu.ROUTE){
        Application.router
            .navigateTo(context, Routers.route, replace: true,transition: TransitionType.inFromLeft);
        curPage = ConstantMenu.ROUTE;
      }
    }else if(page == ConstantMenu.CHECK_IN){
      if(curPage != ConstantMenu.CHECK_IN){
        Application.router
            .navigateTo(context, Routers.check_in_shipment, replace: true,transition: TransitionType.inFromLeft);
        curPage = ConstantMenu.CHECK_IN;
      }
    }else if(page == ConstantMenu.SYNC){
      if(curPage != ConstantMenu.SYNC){
        Application.router
            .navigateTo(context, Routers.sync, replace: false,transition: TransitionType.inFromLeft);
        curPage = ConstantMenu.SYNC;
      }
    }else if(page == ConstantMenu.SETTING){
      if(curPage != ConstantMenu.SETTING){
        Application.router
            .navigateTo(context, Routers.settings, replace: false,transition: TransitionType.inFromLeft);
        curPage = ConstantMenu.SETTING;
      }
    }else if(page == ConstantMenu.SETTING){
      Navigator.pop(context);
    }
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildHeader(),
            Container(
              color: _getColor(ConstantMenu.CHECK_OUT),
              child: ListTile(
                leading: Image.asset('assets/imgs/menu_check_out.png'),
                title: Text('Check Out',style: TextStyle(color: Colors.white,fontSize: Dimens.font_normal),),
                onTap: () {
                  _onTap(context,ConstantMenu.CHECK_OUT);
                },
              ),
            ),
            Container(
              color: _getColor(ConstantMenu.ROUTE),
              child: ListTile(
                leading: Image.asset('assets/imgs/menu_route.png'),
                title: Text('Route',style: TextStyle(color: Colors.white,fontSize: Dimens.font_normal),),
                onTap: () {
                  _onTap(context,ConstantMenu.ROUTE);
                },
              ),
            ),
            Container(
              color: _getColor(ConstantMenu.CHECK_IN),
              child: ListTile(
                leading: Image.asset('assets/imgs/menu_check_in.png'),
                title: Text('Check In',style: TextStyle(color: Colors.white,fontSize: Dimens.font_normal),),
                onTap: () {
                  _onTap(context,ConstantMenu.CHECK_IN);
                },
              ),
            ),
            Container(
              child: ListTile(
                leading: Image.asset('assets/imgs/menu_setting.png'),
                title: Text('Setting',style: TextStyle(color: Colors.white,fontSize: Dimens.font_normal),),
                onTap: () {
                  _onTap(context,ConstantMenu.SETTING);
                },
              ),
            ),
            Container(
              child: ListTile(
                leading: Image.asset('assets/imgs/menu_sync.png'),
                title: Text('Sync',style: TextStyle(color: Colors.white,fontSize: Dimens.font_normal),),
                onTap: () {
                  _onTap(context,ConstantMenu.SYNC);
                },
              ),
            ),
            Container(
              child: ListTile(
                leading: Image.asset('assets/imgs/menu_log_out.png'),
                title: Text('Logout',style: TextStyle(color: Colors.white,fontSize: Dimens.font_normal),),
                onTap: () {
                  _onTap(context,ConstantMenu.LOGOUT);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
        padding: EdgeInsets.zero,
        child: Container(
          color: Colors.blue,
          child: Stack(
            alignment: FractionalOffset.bottomLeft,
            children: <Widget>[
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/imgs/icon_user.png'),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Phil',
                            style: TextStyles.normal,
                          ),
                          Text(
                            'phil@ebest.mobile',
                            style: TextStyles.small,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

}