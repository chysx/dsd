import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/res/colors.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/route_plan_detail/route_plan_detail_presenter.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-01-03 09:56

class RoutePlanDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var header = ListHeaderWidget(
      names: [
        'Product',
        'Qty',
      ],
      supNames: ['','CS/EA'],
      weights: [2, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
      ],
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DELIVERY'),
      ),
      body: Consumer<RoutePlanDetailPresenter>(builder: (context, presenter, _) {
        return new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              color: ColorsRes.gray_normal,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'ORDER NO: ${presenter.orderNo}',
                      style: TextStyles.large,
                    ),
                  ),
                ],
              ),
            ),
            header,
            Expanded(
              child: ListView.separated(
                  itemCount: presenter.productList.length,
                  separatorBuilder: (context, index){
                    return Divider(height: 2,);
                  },
                  itemBuilder: (context, index) {
                    BaseProductInfo info = presenter.productList[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${info.code} ${info.name}',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${info.plannedCs}/${info.plannedEa}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),

            ListHeaderWidget(
              names: ['Total', BaseProductInfo.getPlanTotal(presenter.productList).toString()],
              supNames: ['', ''],
              weights: [2, 1],
              aligns: [
                TextAlign.center,
                TextAlign.center,
              ],
            ),
          ],
        );
      }),
    );
  }

}