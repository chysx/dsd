import 'package:dsd/common/constant.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('SHIPMENT'),
      ),
      body: Center(
        child: Text('body'),
      ),
      drawer: DrawerWidget(),
    );
  }

}