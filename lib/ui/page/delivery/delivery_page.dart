
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'delivery_presenter.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/16 12:05

class DeliveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DeliveryState();
  }

}

class _DeliveryState extends State<DeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery'),
      ),
      body: Consumer<DeliveryPresenter>(
          builder: (context, presenter, _) {
            return Center(
              child: Text('Center'),
            );
          }),
    );
  }

}