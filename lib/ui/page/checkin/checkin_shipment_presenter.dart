import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/route_manager.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/shipment_info.dart';
import 'package:dsd/route/page_builder.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/page/route/customer_info.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/12 15:46

enum CheckInShipmentEvent {
  InitData,
}

class ShipmentCustomer {
  int visitedCount;
  int totalCount;

  isAllVisited() {
    return visitedCount == totalCount;
  }

  String getShowStr() {
    return '$visitedCount/$totalCount';
  }
}

class CheckInShipmentPresenter extends EventNotifier<CheckInShipmentEvent> {
  List<ShipmentInfo> shipmentInfoList = [];
  Map<String, ShipmentCustomer> map = {};

  @override
  void onEvent(CheckInShipmentEvent event, [dynamic data]) async {
    switch (event) {
      case CheckInShipmentEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  Future initData() async {
    await fillShipmentData();
    await fillShipmentCustomerData();
  }

  Future fillShipmentData() async {
    shipmentInfoList = await ShipmentManager.getShipmentHeaderByCheckOutAndIn();
    shipmentInfoList.sort((ShipmentInfo si1, ShipmentInfo si2) {
      int result = si2.shipmentDate.compareTo(si1.shipmentDate);
      return result == 0 ? si1.sequence.compareTo(si2.sequence) : result;
    });
  }

  fillShipmentCustomerData() async {
    for (ShipmentInfo shipmentInfo in shipmentInfoList) {
      List<CustomerInfo> list =
          await RouteManager.getCustomerInfoListByDelivery(shipmentInfo.no);
      int count = 0;
      for (CustomerInfo info in list) {
        if (info.isVisitComplete) {
          count++;
        }
      }
      ShipmentCustomer shipmentCustomer = new ShipmentCustomer();
      shipmentCustomer.visitedCount = count;
      shipmentCustomer.totalCount = list.length;
      map[shipmentInfo.no] = shipmentCustomer;
    }
  }

  String getShipmentCustomerStatusStr(ShipmentInfo shipmentInfo){
    return map[shipmentInfo.no].getShowStr();
  }

  void onClickItem(BuildContext context, ShipmentInfo info) {
    if(!map[info.no].isAllVisited()){
      CustomerDialog.show(context,msg: 'Please upload all customer data first');
      return;
    }
    if(info.status == ShipmentStatus.CHKI){
      CustomerDialog.show(context,msg: 'This shipment had checked in');
      return;
    }
    Map<String, dynamic> bundle = {
      FragmentArg.ROUTE_SHIPMENT_NO: info.no,
    };
    Navigator.pushNamed(context, PageName.check_in.toString(),
        arguments: bundle);
  }
}
