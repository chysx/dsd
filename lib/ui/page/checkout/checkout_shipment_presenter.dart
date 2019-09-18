import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/shipment_info.dart';

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
}
