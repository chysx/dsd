
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/ui/page/visit_summary_detail/visit_summary_detail_presenter.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/22 15:53

class VisitSummaryDetailPage extends StatelessWidget{
  Widget createListHeaderWidget(){
    return ListHeaderWidget(
      names: ['Product', 'Planned','Actual'],
      supNames: ['', 'CS/EA','CS/EA'],
      weights: [2, 1,1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
        TextAlign.center,
      ],
      onChange: (value){},
    );
  }

  Widget createListFooterWidget(VisitSummaryDetailPresenter presenter) {
    return ListHeaderWidget(
      names: [
        'toal:',
        BaseProductInfo.getPlanTotal(presenter.productList),
        BaseProductInfo.getActualTotal(presenter.productList),
      ],
      supNames: ['', '',''],
      weights: [2, 1,1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
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
        ),
        body: Consumer<VisitSummaryDetailPresenter>(builder: (context, presenter, _) {
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
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${info.actualCs}/${info.actualEa}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
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