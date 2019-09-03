import 'package:dsd/model/shipment_info.dart';
import 'package:dsd/res/strings.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'checkout_shipment_presenter.dart';

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
      body:
          Consumer<CheckoutShipmentPresenter>(builder: (context, presenter, _) {
        return new Column(
          children: <Widget>[
            header,
            Expanded(
              child: ListView.builder(
                  itemCount: presenter.list.length,
                  itemBuilder: (content, index) {
                    ShipmentInfo info = presenter.list[index];
                    return Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            info.no,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            info.type,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            info.status,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }),
            )
          ],
        );
      }),
      drawer: DrawerWidget(),
    );
  }
}
