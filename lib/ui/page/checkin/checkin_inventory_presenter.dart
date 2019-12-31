import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/reason_manager.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_item_entity.dart';
import 'package:dsd/db/table/entity/md_product_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/check_out_and_in_model.dart';
import 'package:dsd/res/strings.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/dialog/list_dialog.dart';
import 'package:dsd/ui/dialog/model/key_value_info.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';


/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/12 16:21

enum CheckInInventoryEvent {
  InitData,
  SelectOrCancelAll,
  SelectOrCancel,
  SelectOrCancelEmptyAll,
  OnInput,
}

class CheckInInventoryPresenter extends EventNotifier<CheckInInventoryEvent> {
  List<BaseProductInfo> productList = [];
  List<BaseProductInfo> emptyProductList = [];
  List<KeyValueInfo> reasonList = [];
  String shipmentNo;
  String productUnitValue;

  @override
  void onEvent(CheckInInventoryEvent event, [dynamic data]) async {
    switch (event) {
      case CheckInInventoryEvent.InitData:
        await initData();
        break;
      case CheckInInventoryEvent.SelectOrCancelAll:
        BaseProductInfo.selectOrCancelAll(productList, data);
        break;
      case CheckInInventoryEvent.SelectOrCancelEmptyAll:
        BaseProductInfo.selectOrCancelAll(emptyProductList, data);
        break;
      case CheckInInventoryEvent.SelectOrCancel:
        BaseProductInfo.selectOrCancel(data);
        break;
      case CheckInInventoryEvent.OnInput:
        BaseProductInfo.onInput(data);
        break;
    }

    super.onEvent(event, data);
  }


  void setBundle(Map<String,dynamic> bundle){
    shipmentNo = bundle[FragmentArg.ROUTE_SHIPMENT_NO];
  }

  Future initData() async {
    //默认CSEA都显示
    productUnitValue = ProductUnit.CS_EA;
    await fillProductData();
    await fillEmptyProductData();
    await fillReasonData();
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

  Future fillReasonData() async {
    reasonList = await ReasonManager.getReasonData(CheckInDiffReason.CATEGORY);
  }

  void showReasonDialog(BuildContext context,BaseProductInfo info){
    ListDialog.show(context,title: IntlUtil.getString(context, Ids.checkoutInventory_title_reason),data: reasonList,onSelect: (reason){
      info.reasonValue = reason.value;
      notifyListeners();
    });
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

    for(BaseProductInfo info in emptyProductList){
      if(!info.isPass()) return false;
    }
    return true;
  }

  Future saveData() async {
    await CheckInModel().saveShipmentHeader();
    CheckInModel().cacheShipmentItemList(productList, productUnitValue,emptyList: emptyProductList);
    await CheckInModel().saveShipmentItems();
  }

}