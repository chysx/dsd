import 'package:dsd/application.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/shipment_info.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

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
      String path =
      '''${Routers.route}?${FragmentArg.ROUTE_SHIPMENT_NO}=${info.no}''';
      Application.router.navigateTo(context, path, replace: true,transition: TransitionType.inFromLeft);
    }else if(info.status == ShipmentStatus.CHKI){

    }else{
      String path =
      '''${Routers.check_out}?${FragmentArg.ROUTE_SHIPMENT_NO}=${info.no}''';
      await Application.router.navigateTo(context, path, transition: TransitionType.inFromLeft);

      onResume();
    }
  }

  void onResume(){
    onEvent(ShipmentEvent.InitData);
  }

}
