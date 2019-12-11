import 'package:dsd/application.dart';
import 'package:dsd/business/delivery_util.dart';
import 'package:dsd/business/product_util.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/manager/visit_manager.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/delivery_model.dart';
import 'package:dsd/model/visit_model.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/18 10:29

enum DeliverySummaryEvent {
  InitData,
}

class DeliverySummaryPresenter extends EventNotifier<DeliverySummaryEvent> {
  List<BaseProductInfo> productList = [];
  List<BaseProductInfo> emptyProductList = [];
  String deliveryNo;
  String shipmentNo;
  String accountNumber;
  String customerName;
  String deliveryType;
  String productUnitValue;
  bool isReadOnly;

  @override
  Future onEvent(DeliverySummaryEvent event, [dynamic data]) async {
    switch (event) {
      case DeliverySummaryEvent.InitData:
        await initData();
        break;
    }
    super.onEvent(event, data);
  }

  void setBundle(Map<String,dynamic> bundle){
    deliveryNo = bundle[FragmentArg.DELIVERY_NO];
    shipmentNo = bundle[FragmentArg.DELIVERY_SHIPMENT_NO];
    accountNumber = bundle[FragmentArg.DELIVERY_ACCOUNT_NUMBER];
    customerName = bundle[FragmentArg.TASK_CUSTOMER_NAME];
    deliveryType = bundle[FragmentArg.DELIVERY_TYPE];
    this.isReadOnly = bundle[FragmentArg.DELIVERY_SUMMARY_READONLY] == ReadyOnly.TRUE;
  }

  Future initData() async {
    if(!DeliveryModel().isInitData()){
      await DeliveryModel().initData(deliveryNo);
    }
    await fillProductData();
    await fillEmptyProductData();
  }

  Future fillProductData() async {
    productList.clear();

    List<DSD_T_DeliveryItem_Entity> tList = DeliveryModel().deliveryItemList;
    productList.addAll(await ProductUtil.mergeTProduct(tList, true));
  }

  Future fillEmptyProductData() async {
    emptyProductList.clear();

    emptyProductList.addAll(await DeliveryUtil.createEmptyProductList(DeliveryModel().deliveryItemList));
  }

  bool isHideNextButton() {
//    return VisitManager.isVisitCompleteByVisit(VisitModel().visit);
    return isReadOnly;
  }

  Future onClickRight(BuildContext context) async {
    await saveData();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future saveData() async {
    await DeliveryModel().saveDeliveryHeader();
    await DeliveryModel().saveDeliveryItems();
  }

  @override
  void dispose() {
    if(isReadOnly) {
      DeliveryModel().clear();
      print('****************dispose:DeliveryModel().clear()**********************');
    }
    super.dispose();
  }

}
