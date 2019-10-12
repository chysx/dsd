import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/system_config.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/db/manager/system_config_manager.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/checkout_model.dart';


/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/10 10:12

enum CheckOutInventoryEvent {
  InitData,
  SelectOrCancelAll,
}

class CheckoutInventoryPresenter extends EventNotifier<CheckOutInventoryEvent> {
  List<BaseProductInfo> productList = [];
  String shipmentNo;
  String productUnitValue;

  @override
  void onEvent(CheckOutInventoryEvent event, [dynamic data]) async {

    switch(event){
      case CheckOutInventoryEvent.InitData:
        await initData();
        break;
      case CheckOutInventoryEvent.SelectOrCancelAll:
        selectOrCancelAll(data);
        break;
    }

    super.onEvent(event, data);
  }

  void setPageParams(Map<String, List<String>> params) {
    shipmentNo = params[FragmentArg.ROUTE_SHIPMENT_NO].first;
  }

  Future initData() async {
    initConfig();
    await fillProductData();
  }

  Future initConfig() async {
    String productUnit = await SystemManager.getSystemConfigValue(CheckOut.CATEGORY, CheckOut.PRODUCT_UNIT);
    switch (productUnit) {
      case ProductUnit.CS_EA_VALUE:
        productUnitValue = ProductUnit.CS_EA;
        break;
      case ProductUnit.CS_VALUE:
        productUnitValue = ProductUnit.CS;
        break;
      case ProductUnit.EA_VALUE:
        productUnitValue = ProductUnit.EA;
        break;
    }
  }

  Future<void> fillProductData() async {
    List<DSD_T_ShipmentItem_Entity> tList = CheckoutModel().shipmentItemList;
    productList = await ShipmentManager.getShipmentItemProductByNo(shipmentNo);

    for(BaseProductInfo info in productList){
      for (DSD_T_ShipmentItem_Entity tItem in tList) {
        if (info.code == tItem.ProductCode && tItem.ProductUnit == ProductUnit.CS) {
          info.actualCs = tItem.ActualQty;
          info.reasonValue = tItem.DifferenceReason;
        }else if (info.code == tItem.ProductCode && tItem.ProductUnit == ProductUnit.EA) {
          info.actualEa = tItem.ActualQty;
          info.reasonValue = tItem.DifferenceReason;
        }
      }
    }

  }

  void selectOrCancelAll(bool isCheck){
    for(BaseProductInfo info in productList){
      info.isCheck = isCheck;
      info.actualCs = info.plannedCs;
      info.actualEa = info.plannedEa;
    }
  }

  void selectOrCancel(BaseProductInfo info,bool isCheck){
    info.isCheck = isCheck;
    if(isCheck){
      info.actualCs = info.plannedCs;
      info.actualEa = info.plannedEa;
    }
    notifyListeners();
  }

  onClickRight() async {
    await CheckoutModel().saveShipmentHeader();
    CheckoutModel().setShipmentItemList(productList, productUnitValue);
    await CheckoutModel().saveShipmentItems();
  }

}