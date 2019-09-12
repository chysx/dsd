import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/shipment_info.dart';

enum ShipmentEvent {
  InitData
}

class CheckoutShipmentPresenter extends EventNotifier<ShipmentEvent> {
  List<ShipmentInfo> list = new List();

  @override
  void onEvent(ShipmentEvent event, [dynamic data]) async {

    switch(event){
      case ShipmentEvent.InitData:
        print("123");
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  Future initData() async {
    //initSettingList();
    await getCheckoutShipmentInfo();
  }

  Future<ShipmentInfo> getCheckoutShipmentInfo() async {
    list = await ShipmentManager.getShipmentList();
    print("size:" + list.length.toString());
    /*ShipmentInfo item = new ShipmentInfo();
    item.no = "111";
    item.type = "222";
    item.status = "333";
    list.add(item);
    print(list.length);*/
  }
}
