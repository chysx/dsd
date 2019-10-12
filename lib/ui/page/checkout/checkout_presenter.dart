import 'package:dsd/application.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/checkout_model.dart';
import 'package:dsd/route/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/30 11:43

enum CheckOutEvent {
  InitData
}

class CheckoutPresenter extends EventNotifier<CheckOutEvent> {
  String shipmentNo;
  @override
  void onEvent(CheckOutEvent event, [dynamic data]) async {

    switch(event){
      case CheckOutEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  void setPageParams(Map<String, List<String>> params) {
    shipmentNo = params[FragmentArg.ROUTE_SHIPMENT_NO].first;
  }

  Future initData() async {
    await CheckoutModel().initData(shipmentNo);
  }

  bool isComplete(){
    return CheckoutModel().shipmentItemList.length > 0;
  }

  String getIsCompleteText() {
    if(isComplete()){
      return 'Completed';
    }
    return 'Not Completed';
  }

  Future onClickItem(BuildContext context,String shipmentNo) async {
    String path =
    '''${Routers.check_out_inventory}?${FragmentArg.ROUTE_SHIPMENT_NO}=$shipmentNo''';
    await Application.router.navigateTo(context, path, transition: TransitionType.inFromLeft);

    onResume();
  }

  void onResume(){
    onEvent(CheckOutEvent.InitData);
  }

  void onClickRight(){
    CheckoutModel().updateShipmentHeader();
  }

}