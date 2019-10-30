import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/delivery_model.dart';
import 'package:flutter/material.dart';

import '../../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/30 15:33

enum PrintDeliverySlipEvent {
  InitData,
}

class PrintDeliverySlipPresenter extends EventNotifier<PrintDeliverySlipEvent> {
  List<BaseProductInfo> productList = [];
  List<BaseProductInfo> emptyProductList = [];
  String shipmentNo;
  String accountNumber;
  String customerName;
  String deliveryNo;


  @override
  Future onEvent(PrintDeliverySlipEvent event, [dynamic data]) async {
    switch (event) {
      case PrintDeliverySlipEvent.InitData:
        await initData();
        break;
    }
    super.onEvent(event, data);
  }

  void setPageParams(Map<String, List<String>> params) {
    deliveryNo = params[FragmentArg.DELIVERY_NO].first;
    shipmentNo = params[FragmentArg.DELIVERY_SHIPMENT_NO].first;
    accountNumber = params[FragmentArg.DELIVERY_ACCOUNT_NUMBER].first;
    customerName = params[FragmentArg.TASK_CUSTOMER_NAME].first;
  }

  Future initData() async {
    await DeliveryModel().initData(deliveryNo);
    fillProductData();
    fillEmptyProductData();
  }

  void fillProductData() {
    productList.clear();

    List<DSD_T_DeliveryItem_Entity> tList = DeliveryModel().deliveryItemList;

    for (DSD_T_DeliveryItem_Entity tItem in tList) {
      if(tItem.IsReturn == IsReturn.TRUE) continue;
      if (int.tryParse(tItem.ActualQty) == 0) continue;

      BaseProductInfo info = new BaseProductInfo();
      info.code = tItem.ProductCode;
      info.name = Application.productMap[tItem.ProductCode];
      if (tItem.ProductUnit == ProductUnit.CS) {
        info.plannedCs = int.tryParse(tItem.PlanQty);
        info.actualCs = int.tryParse(tItem.ActualQty);
      } else {
        info.plannedEa = int.tryParse(tItem.PlanQty);
        info.actualEa = int.tryParse(tItem.ActualQty);
      }
      info.isInMDelivery = true;
      productList.add(info);
    }
  }

  void fillEmptyProductData() {
    emptyProductList.clear();

    List<DSD_T_DeliveryItem_Entity> tList = DeliveryModel().deliveryItemList;

    for (DSD_T_DeliveryItem_Entity tItem in tList) {
      if(tItem.IsReturn != IsReturn.TRUE) continue;
      if (int.tryParse(tItem.ActualQty) == 0) continue;

      BaseProductInfo info = new BaseProductInfo();
      info.code = tItem.ProductCode;
      info.name = Application.productMap[tItem.ProductCode];
      info.actualCs = int.tryParse(tItem.ActualQty);
      emptyProductList.add(info);
    }
  }

  void onClickRight(BuildContext context) {

  }

  @override
  void dispose() {
    DeliveryModel().clear();
    print('****************dispose:DeliveryModel().clear()**********************');
    super.dispose();
  }
}