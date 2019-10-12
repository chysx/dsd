import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkout_inventory_presenter.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/10 10:14

class CheckoutInventoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CheckoutInventoryState();
  }
}

class _CheckoutInventoryState extends State<CheckoutInventoryPage> {
  List<TextEditingController> csList = [];
  List<TextEditingController> eaList = [];

  void initControllerCs(List<BaseProductInfo> productList){
//    if(csList.length > 0) return ;
    csList.clear();
    for(BaseProductInfo info in productList){
      TextEditingController controller = new TextEditingController();
      controller.text = info.actualCs.toString();
      controller.addListener((){
        info.actualCs = int.tryParse(controller.text);
      });
      csList.add(controller);
    }
  }
  void initControllerEa(List<BaseProductInfo> productList){
//    if(eaList.length > 0) return ;
      eaList.clear();
    for(BaseProductInfo info in productList){
      TextEditingController controller = new TextEditingController();
      controller.text = info.actualEa.toString();
      controller.addListener((){
        info.actualEa = int.tryParse(controller.text);
      });
      eaList.add(controller);
    }
  }

  Widget createListHeaderWidget(CheckoutInventoryPresenter presenter){
    return ListHeaderWidget(
      names: ['SKU', 'Planned', 'Actual'],
      supNames: ['', 'CS/EA', 'CS/EA'],
      weights: [2, 1, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
        TextAlign.center,
      ],
      isCheck: false,
      onChange: (value){
        presenter.onEvent(CheckOutInventoryEvent.SelectOrCancelAll,value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build***");
    return Scaffold(
        appBar: AppBar(
          title: Text('INVENTORY COUNT'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () async {
                CheckoutInventoryPresenter presenter = Provider.of<CheckoutInventoryPresenter>(context);
                await presenter.onClickRight();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Consumer<CheckoutInventoryPresenter>(builder: (context, presenter, _) {
          initControllerCs(presenter.productList);
          initControllerEa(presenter.productList);
          return Column(
            children: <Widget>[
              createListHeaderWidget(presenter),
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
                                '${info.code} ${info.desc}',
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
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(
//                                height: 36,
                                      child: Theme(
                                        data: ThemeData(primaryColor: Colors.grey),
                                        child: TextField(
                                          controller: csList.length > 0 ? csList[index] : new TextEditingController(),
                                          style: TextStyles.normal,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: 6, bottom: 6, left: 2, right: 2),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
//                                height: 36,
                                      child: Theme(
                                        data: ThemeData(primaryColor: Colors.grey),
                                        child: TextField(
                                          controller: eaList.length > 0 ? eaList[index] : new TextEditingController(),
                                          style: TextStyles.normal,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: 6, bottom: 6, left: 2, right: 2),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Checkbox(
                                  value: info.isCheck,
                                  onChanged: (value){
                                    presenter.selectOrCancel(info, value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        }));
  }
}
