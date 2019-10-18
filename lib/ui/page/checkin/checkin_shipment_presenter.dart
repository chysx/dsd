import 'package:dsd/common/constant.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/shipment_info.dart';
import 'package:dsd/route/routers.dart';
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
class CheckInShipmentPresenter extends EventNotifier<CheckInShipmentEvent> {
  List<ShipmentInfo> shipmentInfoList = [];
  @override
  void onEvent(CheckInShipmentEvent event, [dynamic data]) async {

    switch(event){
      case CheckInShipmentEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  Future initData() async {
    await fillShipmentData();
  }

  Future fillShipmentData() async {
    shipmentInfoList = await ShipmentManager.getShipmentHeaderByCheckOutAndIn();
    shipmentInfoList.sort((ShipmentInfo si1, ShipmentInfo si2){
      int result = si2.shipmentDate.compareTo(si1.shipmentDate);
      return result == 0 ? si1.sequence.compareTo(si2.sequence) : result;
    });
  }

  void onClickItem(BuildContext context,ShipmentInfo info) {
    String path =
    '''${Routers.check_in}?${FragmentArg.ROUTE_SHIPMENT_NO}=${info.no}''';
    Application.router.navigateTo(context, path, transition: TransitionType.inFromLeft);
  }

}