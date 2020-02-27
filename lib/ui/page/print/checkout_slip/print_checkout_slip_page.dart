import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/res/dimens.dart';
import 'package:dsd/ui/page/print/checkout_slip/print_checkout_slip_presenter.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019-12-31 16:15

class PrintCheckoutSlipPage extends StatelessWidget {

  final GlobalKey rootWidgetKey = GlobalKey();

  Widget getCustomerSign(PrintCheckoutSlipPresenter presenter) {
    var sign = presenter.getCustomerSign();
    return sign != null ? Image.memory(sign) : Container();
  }

  Widget getDriveSign(PrintCheckoutSlipPresenter presenter) {
    var sign = presenter.getDriverSign();
    return sign != null ? Image.memory(sign) : Container();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('CHECKOUT SLIP'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.print),
          onPressed: () async {
            PrintCheckoutSlipPresenter presenter = Provider.of<PrintCheckoutSlipPresenter>(context);
            presenter.onClickRight(context,rootWidgetKey);
          },
        ),
      ],
    ),
    body: Consumer<PrintCheckoutSlipPresenter>(
      builder: (context, presenter, _) {
        return SingleChildScrollView(
          child: RepaintBoundary(
            key: rootWidgetKey,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(children: <Widget>[
                    Text(
                      'Shipment No: ',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),

                    Text(
                      '${presenter.shipmentNo}',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                  ],),

                  Row(children: <Widget>[
                    Text(
                      'Shipment Time: ',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),

                    Text(
                      '${presenter.shipmentTime}',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                  ],),

                  Row(children: <Widget>[
                    Text(
                      'Driver No: ',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),

                    Text(
                      '${presenter.driverCode}',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                  ],),

                  Row(children: <Widget>[
                    Text(
                      'Driver Name: ',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),

                    Text(
                      '${presenter.driverName}',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                  ],),

                  Row(children: <Widget>[
                    Text(
                      'Checker No: ',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),

                    Text(
                      '${presenter.checkerCode ?? ''}',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                  ],),

                  Row(children: <Widget>[
                    Text(
                      'Checker Name: ',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),

                    Text(
                      '${presenter.checkerName ?? ''}',
                      style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                    ),
                  ],),

                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  ListHeaderWidget(
                    names: ['CODE', 'DESCRIPTION','CASES'],
                    supNames: ['', '',''],
                    weights: [1, 1,1],
                    aligns: [
                      TextAlign.center,
                      TextAlign.center,
                      TextAlign.center,
                    ],
                    isBold: true,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: presenter.productList.length,
                    itemBuilder: (context, index) {
                      BaseProductInfo info = presenter.productList[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${info.code}',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: Dimens.font_small, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${info.name ?? ''}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: Dimens.font_small, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${info.actualCs ?? ''}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: Dimens.font_small, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 2,
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Divider(
                    height: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: presenter.emptyProductList.length,
                    itemBuilder: (context, index) {
                      BaseProductInfo info = presenter.emptyProductList[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${info.code}',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: Dimens.font_small, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${info.name ?? ''}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: Dimens.font_small, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${info.actualCs ?? ''}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: Dimens.font_small, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 2,
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  ListHeaderWidget(
                    names: ['Total', '',BaseProductInfo.getTotalActualCs(presenter.productList).toString()],
                    supNames: ['', '',''],
                    weights: [1, 1,1],
                    aligns: [
                      TextAlign.center,
                      TextAlign.center,
                      TextAlign.center,
                    ],
                    isBold: true,
                  ),
                  Divider(
                    height: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Unterschrift Kunde:',style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            getCustomerSign(presenter),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Unterschrift Fahrer:',style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            getDriveSign(presenter),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Divider(
                    height: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
  }

}