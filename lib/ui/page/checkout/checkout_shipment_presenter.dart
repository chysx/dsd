import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/shipment_info.dart';

class CheckoutShipmentPresenter extends EventNotifier<ShipmentInfo> {
  List<ShipmentInfo> list = new List();

  @override
  void onEvent(ShipmentInfo event, [data]) {
    super.onEvent(event, data);
  }

  Future initData() {
    //initSettingList();
    initCheckoutShipmentInfo();
  }

  void initCheckoutShipmentInfo() async {
    await getCheckoutShipmentInfo();
  }

  Future<ShipmentInfo> getCheckoutShipmentInfo() async {
    //list = await ShipmentManager.getShipmentList();

    ShipmentInfo item = new ShipmentInfo();
    item.no = "111";
    item.type = "222";
    item.status = "333";
    list.add(item);
    print(list.length);
  }
}
