import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/ui/page/visit_summary/visit_summary_info.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/22 14:29

enum VisitSummaryEvent {
  InitData,
}

class VisitSummaryPresenter extends EventNotifier<VisitSummaryEvent> {
  List<VisitSummaryInfo> productList = [];
  String shipmentNo;
  String accountNumber;
  int totalCsQty = 0;
  int totalEaQty = 0;

  @override
  void onEvent(VisitSummaryEvent event, [dynamic data]) async {
    switch (event) {
      case VisitSummaryEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  void setPageParams(Map<String, List<String>> params) {
    shipmentNo = params[FragmentArg.DELIVERY_SHIPMENT_NO].first;
    accountNumber = params[FragmentArg.DELIVERY_ACCOUNT_NUMBER].first;
  }

  Future initData() async {
    await fillProductData();
    await fillQtyData();
  }

  Future fillProductData() async {
    List<DSD_T_DeliveryHeader_Entity> deliveryList = await Application.database.tDeliveryHeaderDao.findEntityByCon(
        shipmentNo, accountNumber);

    for(DSD_T_DeliveryHeader_Entity entity in deliveryList){
      VisitSummaryInfo info = new VisitSummaryInfo();
      info
        ..deliveryNo = entity.DeliveryNo
        ..deliveryType = entity.DeliveryType
        ..deliveryStatus = entity.DeliveryStatus;

      productList.add(info);
    }
  }

  fillQtyData() async {
    for(VisitSummaryInfo info in productList){
      List<DSD_T_DeliveryItem_Entity> list = await Application.database.tDeliveryItemDao.findEntityByDeliveryNo(info.deliveryNo);
      for(DSD_T_DeliveryItem_Entity entity in list){
        if(entity.ProductUnit == ProductUnit.CS){
          info.csQty += int.tryParse(entity.ActualQty);
        }
        if(entity.ProductUnit == ProductUnit.EA){
          info.eaQty += int.tryParse(entity.ActualQty);
        }
      }
      totalCsQty += info.csQty;
      totalEaQty += info.eaQty;
    }
  }

  void onItemClick(BuildContext context,VisitSummaryInfo info){
    String path =
    '''${Routers.visit_summary_detail}?${FragmentArg.DELIVERY_NO}=${info.deliveryNo}''';
    Application.router.navigateTo(context, path, transition: TransitionType.inFromLeft);
  }

  void onClickRight(BuildContext context) {
//    String path =
//    '''${Routers.delivery_summary}?${FragmentArg.TASK_CUSTOMER_NAME}=$customerName
//    ''';
//    Application.router.navigateTo(context, path, transition: TransitionType.inFromLeft);
  }

}