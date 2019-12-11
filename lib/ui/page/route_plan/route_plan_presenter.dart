import 'package:dsd/application.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_header_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/route_plan_info.dart';

enum RoutePlanEvent { InitData }

class RoutePlanPresenter extends EventNotifier<RoutePlanEvent> {
  List<RoutePlanInfo> routePlanList = [];
  String shipmentNo;
  String accountNumber;

  @override
  void onEvent(RoutePlanEvent event, [dynamic data]) async {
    switch (event) {
      case RoutePlanEvent.InitData:
        await initData();
        break;
    }
    super.onEvent(event, data);
  }

  void setBundle(Map<String,dynamic> bundle){
    shipmentNo = bundle[FragmentArg.ROUTE_SHIPMENT_NO];
    accountNumber = bundle[FragmentArg.ROUTE_ACCOUNT_NUMBER];
  }

  Future initData() async {
    await fillRoutePlanList();
  }

  Future fillRoutePlanList() async {
    routePlanList.clear();
    List<DSD_M_DeliveryHeader_Entity> deliveryHeaderList =
        await Application.database.mDeliveryHeaderDao.findEntityByCon(shipmentNo, accountNumber);
    for (DSD_M_DeliveryHeader_Entity entity in deliveryHeaderList) {
      RoutePlanInfo info = new RoutePlanInfo();
      info.no = entity.DeliveryNo;
      info.orderNo = entity.OrderNo;
      info.qty = double.tryParse(entity.PlanDeliveryQty).toInt();
      info.type = entity.DeliveryType;
      routePlanList.add(info);
    }
  }
}
