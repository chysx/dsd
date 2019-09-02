import 'package:dsd/application.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/res/strings.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
import 'package:dsd/ui/widget/fold_widget.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:fluintl/fluintl.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/26 17:01

class CheckoutShipmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var header = ListHeaderWidget(
      names: [
        IntlUtil.getString(context, Ids.shipment_shipment),
        IntlUtil.getString(context, Ids.shipment_type),
        IntlUtil.getString(context, Ids.shipment_status)
      ],
      weights: [1, 1, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
        TextAlign.center,
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('SHIPMENT'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('button'),
          onPressed: (){
            Application.router
                .navigateTo(context, Routers.check_out, replace: false,transition: TransitionType.inFromLeft);
          },
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
