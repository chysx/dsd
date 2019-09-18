import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/widget/fold_widget.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: (){
              DeliveryPresenter presenter = Provider.of<DeliveryPresenter>(context);
              presenter.onClickRight(context);
            },
          )
        ],
      ),
      body: Consumer<DeliveryPresenter>(builder: (context, presenter, _) {

        return Column(
          children: <Widget>[
            FoldWidget(
              msg: 'DELIVERY PRODUCTS',
              isMore: true,
              child: Column(
                children: <Widget>[
                  ListHeaderWidget(
                    names: ['Product', 'Planned', 'Actual'],
                    supNames: ['', 'cs', 'cs'],
                    weights: [1, 1, 1],
                    aligns: [
                      TextAlign.center,
                      TextAlign.center,
                      TextAlign.center,
                    ],
                  ),
                  Container(
                    height: 300,
                    child: ListView.separated(
                      itemCount: presenter.showProductList.length,
                      itemBuilder: (context, index){
                        BaseProductInfo info = presenter.showProductList[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(info.name??'product',textAlign:TextAlign.left,style: TextStyles.small,),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(info.getPlanShowStr(presenter.productUnitValue),textAlign:TextAlign.center,style: TextStyles.small,),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(info.getActualShowStr(presenter.productUnitValue),textAlign:TextAlign.center,style: TextStyles.small,),
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
                  ),
                ],
              ),
            ),
            FoldWidget(
              msg: 'EMPTY RETURN',
              child: Container(),
            ),
          ],
        );
      }),
    );
  }
}
