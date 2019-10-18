import 'package:dsd/common/constant.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/check_out_and_in_model.dart';
import 'package:dsd/route/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/12 16:21

enum CheckInEvent {
  InitData
}

class CheckInPresenter extends EventNotifier<CheckInEvent> {
  String shipmentNo;

  @override
  void onEvent(CheckInEvent event, [dynamic data]) async {
    switch (event) {
      case CheckInEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  void setPageParams(Map<String, List<String>> params) {
    shipmentNo = params[FragmentArg.ROUTE_SHIPMENT_NO].first;
  }

  Future initData() async {
    await CheckInModel().initData(shipmentNo);
  }

  bool isComplete(){
    return CheckInModel().shipmentItemList.length > 0;
  }

  String getIsCompleteText() {
    if(isComplete()){
      return 'Completed';
    }
    return 'Not Completed';
  }

  Future onClickItem(BuildContext context,String shipmentNo) async {
    String path =
    '''${Routers.check_in_inventory}?${FragmentArg.ROUTE_SHIPMENT_NO}=$shipmentNo''';
    await Application.router.navigateTo(context, path, transition: TransitionType.inFromLeft);

    onResume();
  }

  void onResume(){
    onEvent(CheckInEvent.InitData);
  }

  void onClickRight(){
    CheckInModel().updateShipmentHeader();
  }

}