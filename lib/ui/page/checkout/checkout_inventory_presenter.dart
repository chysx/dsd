import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/common/system_config.dart';
import 'package:dsd/db/manager/reason_manager.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/db/manager/system_config_manager.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/check_out_and_in_model.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/dialog/list_dialog.dart';
import 'package:dsd/ui/dialog/model/key_value_info.dart';
import 'package:flutter/material.dart';


/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/10 10:12

enum CheckOutInventoryEvent {
  InitData,
  SelectOrCancelAll,
  OnInput
}

class CheckoutInventoryPresenter extends EventNotifier<CheckOutInventoryEvent> {
  List<BaseProductInfo> productList = [];
  List<KeyValueInfo> reasonList = [];
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
      case CheckOutInventoryEvent.OnInput:
        onInput(data);
        break;
    }

    super.onEvent(event, data);
  }


  void setBundle(Map<String,dynamic> bundle){
    shipmentNo = bundle[FragmentArg.ROUTE_SHIPMENT_NO];
  }

  Future initData() async {
    initConfig();
    await fillProductData();
    await fillReasonData();
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
    List<DSD_T_ShipmentItem_Entity> tList = CheckOutModel().shipmentItemList;
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

  Future fillReasonData() async {
    reasonList = await ReasonManager.getReasonData(CheckOutDiffReason.CATEGORY);
  }

  void showReasonDialog(BuildContext context,BaseProductInfo info){
    ListDialog.show(context,title: 'title',data: reasonList,onSelect: (reason){
      info.reasonValue = reason.value;
      notifyListeners();
    });
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

  onInput(BaseProductInfo info){
    info.isCheck = info.plannedCs == info.actualCs && info.plannedEa == info.actualEa;
  }

  onClickRight(BuildContext context) async {
    if(isPass()){
      await saveData();
      Navigator.of(context).pop();
    }else{
      CustomerDialog.show(context,msg: 'Please select a difference reason.');
    }
  }

  bool isPass(){
    for(BaseProductInfo info in productList){
      if(!info.isPass()) return false;
    }
    return true;
  }

  Future saveData() async {
    await CheckOutModel().saveShipmentHeader();
    CheckOutModel().cacheShipmentItemList(productList, productUnitValue);
    await CheckOutModel().saveShipmentItems();
  }

}