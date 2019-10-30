import 'package:dsd/common/dictionary.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/res/dimens.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/document/document_info.dart';
import 'package:dsd/ui/page/print/print_delivery_slip_presenter.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/30 15:31

class PrintDeliverySlipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIEFERSCHEIN'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              PrintDeliverySlipPresenter presenter = Provider.of<PrintDeliverySlipPresenter>(context);
              presenter.onClickRight(context);
            },
          )
        ],
      ),
      body: Consumer<PrintDeliverySlipPresenter>(
        builder: (context, presenter, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        'assets/imgs/login_logo.png',
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        '''Valser Service AG\nSchermenweg 151\n3072 Ostermundigen''',
                        style: TextStyle(fontSize: Dimens.font_large, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Kunde:',
                            style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Kunde:value',
                            style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(
                            'Tel:',
                            style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Tel:value',
                            style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Kunde:',
                            style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Kunde:value',
                            style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(
                            'Tel:',
                            style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Tel:value',
                            style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),
                          )
                        ],
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
                  ListHeaderWidget(
                    names: ['Product', 'Qty'],
                    supNames: ['', 'CS/EA'],
                    weights: [1, 1],
                    aligns: [
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
                                '${info.code} ${info.name ?? ''}',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: Dimens.font_small, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                info.getActualShowStrByType(TaskType.Delivery),
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
                  ListHeaderWidget(
                    names: ['Product', 'Qty'],
                    supNames: ['', ''],
                    weights: [1, 1],
                    aligns: [
                      TextAlign.center,
                      TextAlign.center,
                    ],
                    isBold: true,
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
                                '${info.code} ${info.name ?? ''}',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: Dimens.font_small, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                info.getActualShowStrByType(TaskType.EmptyReturn),
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Unterschrift Kunde:',style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Image.asset('assets/imgs/pick_slip.png'),
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
                            Image.asset('assets/imgs/pick_slip.png'),
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
                  Text('www.qwell.ch / info@qwell.ch / Tel. 0848 00 44 00',style: TextStyle(fontSize: Dimens.font_normal, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
