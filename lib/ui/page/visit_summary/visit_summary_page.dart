import 'package:dsd/common/dictionary.dart';
import 'package:dsd/ui/page/visit_summary/visit_summary_info.dart';
import 'package:dsd/ui/page/visit_summary/visit_summary_presenter.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/22 14:28

class VisitSummaryPage extends StatelessWidget{
  Widget createListHeaderWidget(){
    return ListHeaderWidget(
      names: ['', 'Qty'],
      supNames: ['', 'CS/EA'],
      weights: [2, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
      ],
      onChange: (value){},
    );
  }

  Widget createListFooterWidget(VisitSummaryPresenter presenter) {
    return ListHeaderWidget(
      names: [
        'toal:',
        '${presenter.totalCsQty}/${presenter.totalEaQty}',
      ],
      supNames: ['', '',],
      weights: [2, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
      ],
      onChange: (value) {},
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('VISIT SUMMARY'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                VisitSummaryPresenter presenter = Provider.of<VisitSummaryPresenter>(context);
                presenter.onClickRight(context);
              },
            )
          ],
        ),
        body: Consumer<VisitSummaryPresenter>(builder: (context, presenter, _) {
          return Column(
            children: <Widget>[
              createListHeaderWidget(),
              Expanded(
                child: ListView.separated(
                    itemCount: presenter.productList.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 2,
                      );
                    },
                    itemBuilder: (context, index) {
                      VisitSummaryInfo info = presenter.productList[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          presenter.onItemClick(context,info);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${info.deliveryType}(${DeliveryStatus.getDeliveryStatusDescription(info.deliveryStatus)})',
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      'No.${info.deliveryNo}',
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${info.csQty}/${info.eaQty}',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              createListFooterWidget(presenter),
            ],
          );
        }));
  }

}