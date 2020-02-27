import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/shipment_info.dart';
import 'package:dsd/route/page_builder.dart';
import 'package:flutter/material.dart';

enum ShipmentEvent {
  InitData
}

class CheckoutShipmentPresenter extends EventNotifier<ShipmentEvent> {
  List<ShipmentInfo> shipmentInfoList = [];

  @override
  void onEvent(ShipmentEvent event, [dynamic data]) async {

    switch(event){
      case ShipmentEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  Future initData() async {
    await fillShipmentData();
  }

   Future fillShipmentData() async {
    shipmentInfoList = await ShipmentManager.getShipmentList();
    shipmentInfoList.sort((ShipmentInfo si1, ShipmentInfo si2){
      int result = si2.shipmentDate.compareTo(si1.shipmentDate);
      return result == 0 ? si1.sequence.compareTo(si2.sequence) : result;
    });
  }

  Future onClickItem(BuildContext context,ShipmentInfo info) async {
    if(info.status == ShipmentStatus.CHKO){
      Map<String,dynamic> bundle = {
        FragmentArg.ROUTE_SHIPMENT_NO: info.no,
      };
      Navigator.pushReplacementNamed(context, PageName.route.toString(),arguments: bundle);

    }else if(info.status == ShipmentStatus.CHKI){

    }else{
      Map<String,dynamic> bundle = {
        FragmentArg.ROUTE_SHIPMENT_NO: info.no,
      };
      await Navigator.pushNamed(context, PageName.check_out.toString(),arguments: bundle);


      onResume();
    }

  }

  void onResume(){
    onEvent(ShipmentEvent.InitData);
  }

}
