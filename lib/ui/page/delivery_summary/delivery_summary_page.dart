import 'package:dsd/common/dictionary.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/delivery_model.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/delivery_summary/delivery_summary_presenter.dart';
import 'package:dsd/ui/widget/fold_widget.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/17 18:44

class DeliverySummaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeliverySummarySate();
  }

}

class _DeliverySummarySate extends State<DeliverySummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DeliverySummary'),
        actions: <Widget>[
          Builder(builder: (context)  {
            DeliverySummaryPresenter presenter = Provider.of<DeliverySummaryPresenter>(context);
            Widget icon = IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                presenter.onClickRight(context);
              },
            );
            return presenter.isHideNextButton() ? Container() : icon;
          }),
        ],
      ),
      body: Consumer<DeliverySummaryPresenter>(builder: (context, presenter, _) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FoldWidget(
                msg: 'DELIVERY INFO',
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Delivery No:',style: TextStyles.normal,),
                          Spacer(),
                          Text(presenter.deliveryNo,style: TextStyles.normal,),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Row(
                        children: <Widget>[
                          Text('Delivery Date:',style: TextStyles.normal,),
                          Spacer(),
                          Text(DeliveryModel().mDeliveryHeader?.PlanDeliveryDate ?? '',style: TextStyles.normal,),
                        ],
                      ),
//                      Padding(padding: EdgeInsets.only(top: 10),),
//                      Row(
//                        children: <Widget>[
//                          Text('Delivery Note:',style: TextStyles.normal,),
//                          Spacer(),
//                          Text(DeliveryModel().mDeliveryHeader?.DeliveryNote ?? '',style: TextStyles.normal,),
//                        ],
//                      )
                    ],
                  ),
                ),
              ),
              FoldWidget(
                msg: 'DELIVERY DETAIL',
                isMore: true,
                child: Column(
                  children: <Widget>[
                    ListHeaderWidget(
                      names: ['Product', 'Qty'],
                      supNames: ['', 'CS/EA'],
                      weights: [1, 1],
                      aligns: [
                        TextAlign.center,
                        TextAlign.center,
                      ],
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: presenter.productList.length,
                      itemBuilder: (context, index){
                        BaseProductInfo info = presenter.productList[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text('${info.code} ${info.name??''}',textAlign:TextAlign.left,style: TextStyles.small,),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(info.getActualShowStrByType(TaskType.Delivery),textAlign:TextAlign.center,style: TextStyles.small,),
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
                    ListHeaderWidget(
                      names: ['Total', BaseProductInfo.getActualTotal(presenter.productList).toString()],
                      supNames: ['', ''],
                      weights: [1, 1],
                      aligns: [
                        TextAlign.center,
                        TextAlign.center,
                      ],
                    ),
                  ],
                ),
              ),
              FoldWidget(
                msg: 'EMPTY RETURN',
                isMore: true,
                child: Column(
                  children: <Widget>[
                    ListHeaderWidget(
                      names: ['Product', 'Qty'],
                      supNames: ['', ''],
                      weights: [1, 1],
                      aligns: [
                        TextAlign.center,
                        TextAlign.center,
                      ],
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: presenter.emptyProductList.length,
                      itemBuilder: (context, index){
                        BaseProductInfo info = presenter.emptyProductList[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text('${info.code} ${info.name??''}',textAlign:TextAlign.left,style: TextStyles.small,),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(info.getActualShowStrByType(TaskType.EmptyReturn),textAlign:TextAlign.center,style: TextStyles.small,),
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
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      })
    );
  }

}