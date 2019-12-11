import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/widget/fold_widget.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checkin_inventory_presenter.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/12 16:21

class CheckInInventoryPage extends StatelessWidget {
  List<TextEditingController> csList = [];
  List<TextEditingController> eaList = [];
  List<TextEditingController> emptyList = [];

  void initControllerEmpty(CheckInInventoryPresenter presenter) {
//    if(csList.length > 0) return ;
    emptyList.clear();
    for (BaseProductInfo info in presenter.emptyProductList) {
      TextEditingController controller = TextEditingController.fromValue(TextEditingValue(
          // 设置内容
          text: (info.actualCs ?? '').toString(),
          // 保持光标在最后
          selection: TextSelection.fromPosition(
              TextPosition(affinity: TextAffinity.downstream, offset: (info.actualCs ?? 0).toString().length))));
      controller.addListener(() {
        info.actualCs = int.tryParse(controller.text);
        presenter.onEvent(CheckInInventoryEvent.OnInput, info);
      });
      emptyList.add(controller);
    }
  }

  void initControllerCs(CheckInInventoryPresenter presenter) {
//    if(csList.length > 0) return ;
    csList.clear();
    for (BaseProductInfo info in presenter.productList) {
      TextEditingController controller = TextEditingController.fromValue(TextEditingValue(
          // 设置内容
          text: (info.actualCs ?? '').toString(),
          // 保持光标在最后
          selection: TextSelection.fromPosition(
              TextPosition(affinity: TextAffinity.downstream, offset: (info.actualCs ?? 0).toString().length))));

      controller.addListener(() {
        info.actualCs = int.tryParse(controller.text);
        presenter.onEvent(CheckInInventoryEvent.OnInput, info);
      });
      csList.add(controller);
    }
  }

  void initControllerEa(CheckInInventoryPresenter presenter) {
//    if(eaList.length > 0) return ;
    eaList.clear();
    for (BaseProductInfo info in presenter.productList) {
      TextEditingController controller = TextEditingController.fromValue(TextEditingValue(
          // 设置内容
          text: (info.actualEa ?? '').toString(),
          // 保持光标在最后
          selection: TextSelection.fromPosition(
              TextPosition(affinity: TextAffinity.downstream, offset: (info.actualEa ?? 0).toString().length))));
      controller.addListener(() {
        info.actualEa = int.tryParse(controller.text);
        presenter.onEvent(CheckInInventoryEvent.OnInput, info);
      });
      eaList.add(controller);
    }
  }

  Widget createListHeaderWidget(CheckInInventoryPresenter presenter) {
    return ListHeaderWidget(
      names: ['Product', 'Stock', 'Actual'],
      supNames: ['', 'CS/EA', 'CS/EA'],
      weights: [2, 1, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
        TextAlign.center,
      ],
      isCheck: false,
      onChange: (value) {
        presenter.onEvent(CheckInInventoryEvent.SelectOrCancelAll, value);
      },
    );
  }

  Widget createListFooterWidget(CheckInInventoryPresenter presenter) {
    return ListHeaderWidget(
      names: [
        'toal:',
        BaseProductInfo.getPlanTotal(presenter.productList),
        BaseProductInfo.getActualTotal(presenter.productList),
        ''
      ],
      supNames: ['', '', '', ''],
      weights: [2, 1, 1, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
        TextAlign.center,
        TextAlign.center,
      ],
      onChange: (value) {},
    );
  }

  Widget createListHeaderEmptyWidget(CheckInInventoryPresenter presenter) {
    return ListHeaderWidget(
      names: ['Product', 'Stock', 'Actual'],
      supNames: ['', '', ''],
      weights: [2, 1, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
        TextAlign.center,
      ],
      isCheck: false,
      onChange: (value) {
        presenter.onEvent(CheckInInventoryEvent.SelectOrCancelEmptyAll, value);
      },
    );
  }

  Widget createListFooterEmptyWidget(CheckInInventoryPresenter presenter) {
    return ListHeaderWidget(
      names: [
        'toal:',
        BaseProductInfo.getPlanTotal(presenter.emptyProductList),
        BaseProductInfo.getActualTotal(presenter.emptyProductList),
        ''
      ],
      supNames: ['', '', '', ''],
      weights: [2, 1, 1, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
        TextAlign.center,
        TextAlign.center,
      ],
      onChange: (value) {
//        presenter.onEvent(CheckOutInventoryEvent.SelectOrCancelAll,value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INVENTORY CHECKIN'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              CheckInInventoryPresenter presenter = Provider.of<CheckInInventoryPresenter>(context);
              presenter.onClickRight(context);
            },
          )
        ],
      ),
      body: Consumer<CheckInInventoryPresenter>(
        builder: (context, presenter, _) {
          initControllerCs(presenter);
          initControllerEa(presenter);
          initControllerEmpty(presenter);
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FoldWidget(
                  msg: 'PRODUCTS',
                  child: Column(
                    children: <Widget>[
                      createListHeaderWidget(presenter),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: SizedBox(
//                                height: 36,
                                            child: Theme(
                                              data: ThemeData(primaryColor: Colors.grey),
                                              child: TextField(
                                                controller:
                                                    csList.length > 0 ? csList[index] : new TextEditingController(),
                                                keyboardType: TextInputType.number,
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
                                        Padding(
                                          padding: EdgeInsets.only(left: 2),
                                        ),
                                        Expanded(
                                          child: SizedBox(
//                                height: 36,
                                            child: Theme(
                                              data: ThemeData(primaryColor: Colors.grey),
                                              child: TextField(
                                                controller:
                                                    eaList.length > 0 ? eaList[index] : new TextEditingController(),
                                                keyboardType: TextInputType.number,
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
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.center,
                                          child: Checkbox(
                                            value: info.isCheck,
                                            onChanged: (value){
                                              presenter.onEvent(CheckInInventoryEvent.SelectOrCancel,info);
                                            },
                                          ),
                                        ),

                                        Positioned(
                                          right: 0,
                                          bottom: 16,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: (){
                                              presenter.showReasonDialog(context, info);
                                            },
                                            child: Offstage(
                                                offstage: info.isEqual(),
                                                child: Icon(Icons.info,color: info.isRedReasonIcon() ? Colors.red : Colors.grey,size: 18,)),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      Builder(
                        builder: (context) {
                          return createListFooterWidget(presenter);
                        },
                      ),
                    ],
                  ),
                ),
                FoldWidget(
                  msg: 'EMPTY PRODUCTS',
                  child: Column(
                    children: <Widget>[
                      createListHeaderEmptyWidget(presenter),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: presenter.emptyProductList.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 2,
                            );
                          },
                          itemBuilder: (context, index) {
                            BaseProductInfo info = presenter.emptyProductList[index];
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
                                      '${info.plannedCs}',
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
                                                controller: emptyList.length > 0
                                                    ? emptyList[index]
                                                    : new TextEditingController(),
                                                keyboardType: TextInputType.number,
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
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.center,
                                          child: Checkbox(
                                            value: info.isCheck,
                                            onChanged: (value){
                                              presenter.onEvent(CheckInInventoryEvent.SelectOrCancel,info);
                                            },
                                          ),
                                        ),

                                        Positioned(
                                          right: 0,
                                          bottom: 16,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: (){
                                              presenter.showReasonDialog(context, info);
                                            },
                                            child: Offstage(
                                                offstage: info.isEqual(),
                                                child: Icon(Icons.info,color: info.isRedReasonIcon() ? Colors.red : Colors.grey,size: 18,)),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      createListFooterEmptyWidget(presenter)
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
