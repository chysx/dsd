

import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/route_plan_info.dart';

class RoutePlanPresenter extends EventNotifier<RoutePlanInfo>{

  List<RoutePlanInfo> list = new List();

  @override
  void onEvent(RoutePlanInfo event, [data]) {
    // TODO: implement onEvent
    super.onEvent(event, data);
  }

  Future initData() {
    initRoutePlanInfo();
  }

  void initRoutePlanInfo() async {
    await getInitRoutePlanInfo();
  }

  Future<RoutePlanInfo> getInitRoutePlanInfo() async {
    //list = await ShipmentManager.getShipmentList();

    RoutePlanInfo item = new RoutePlanInfo();
    list.add(item);
    print(list.length);
  }

}