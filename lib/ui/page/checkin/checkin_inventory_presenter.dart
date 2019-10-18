import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_item_entity.dart';
import 'package:dsd/db/table/entity/md_product_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/check_out_and_in_model.dart';


/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/12 16:21

enum CheckInInventoryEvent {
  InitData,
  SelectOrCancelAll,
  SelectOrCancelEmptyAll,
  OnInput,
}

class CheckInInventoryPresenter extends EventNotifier<CheckInInventoryEvent> {
  List<BaseProductInfo> productList = [];
  List<BaseProductInfo> emptyProductList = [];
  String shipmentNo;
  String productUnitValue;

  @override
  void onEvent(CheckInInventoryEvent event, [dynamic data]) async {
    switch (event) {
      case CheckInInventoryEvent.InitData:
        await initData();
        break;
      case CheckInInventoryEvent.SelectOrCancelAll:
        selectOrCancelAll(productList,data);
        break;
      case CheckInInventoryEvent.SelectOrCancelEmptyAll:
        selectOrCancelAll(emptyProductList,data);
        break;
      case CheckInInventoryEvent.OnInput:
        onInput(data);
        break;
    }

    super.onEvent(event, data);
  }

  void setPageParams(Map<String, List<String>> params) {
    shipmentNo = params[FragmentArg.ROUTE_SHIPMENT_NO].first;
  }

  Future initData() async {
    //默认CSEA都显示
    productUnitValue = ProductUnit.CS_EA;
    await fillProductData();
    await fillEmptyProductData();
  }

  Future<void> fillProductData() async {
    List<DSD_T_ShipmentItem_Entity> tList = CheckInModel().shipmentItemList;
    productList = await ShipmentManager.getShipmentItemProductStockByNo(shipmentNo);

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

  Future<void> fillEmptyProductData() async {
    emptyProductList.clear();

    List<MD_Product_Entity> list = await Application.database.productDao.findEntityByEmpty(Empty.TRUE);
    List<BaseProductInfo> stockProductList = await ShipmentManager.getEmptyProductByShipmentNo(shipmentNo);
    for(MD_Product_Entity entity in list){
      BaseProductInfo info = new BaseProductInfo();
      info.code = entity.ProductCode;
      info.name = entity.Name;
      for(BaseProductInfo stock in stockProductList){
        if(entity.ProductCode == stock.code){
          info.plannedCs = stock.plannedCs;
        }
      }
      emptyProductList.add(info);
    }
  }

  void selectOrCancelAll(List<BaseProductInfo> productList,bool isCheck){
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

  String getActualTotal(List<BaseProductInfo> productList){
    int totalCs = 0;
    int totalEa = 0;
    for(BaseProductInfo info in productList){
      totalCs += info.actualCs ?? 0;
      totalEa += info.actualEa ?? 0;
    }
    return '$totalCs/$totalEa';
  }

  String getStockTotal(List<BaseProductInfo> productList){
    int totalCs = 0;
    int totalEa = 0;
    for(BaseProductInfo info in productList){
      totalCs += info.plannedCs;
      totalEa += info.plannedEa;
    }
    return '$totalCs/$totalEa';
  }

  onInput(BaseProductInfo info){
    info.isCheck = info.plannedCs == info.actualCs && info.plannedEa == info.actualEa;
  }

  onClickRight() async {
    await CheckInModel().saveShipmentHeader();
    CheckInModel().setShipmentItemList(productList, productUnitValue);
    await CheckInModel().saveShipmentItems();
  }

}