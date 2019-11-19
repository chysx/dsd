import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/delivery_model.dart';
import 'package:dsd/ui/dialog/list_dialog.dart';
import 'package:dsd/ui/dialog/model/key_value_info.dart';
import 'package:dsd/ui/page/print/blue_manager.dart';
import 'package:dsd/utils/file_util.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blue/flutter_blue.dart';


import '../../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/30 15:33

enum PrintDeliverySlipEvent {
  InitData,
}

class PrintDeliverySlipPresenter extends EventNotifier<PrintDeliverySlipEvent> {
  List<BaseProductInfo> productList = [];
  List<BaseProductInfo> emptyProductList = [];
  String shipmentNo;
  String accountNumber;
  String customerName;
  String deliveryNo;

  String address;
  String orderNo;
  String phone;
  String data;


  @override
  Future onEvent(PrintDeliverySlipEvent event, [dynamic data]) async {
    switch (event) {
      case PrintDeliverySlipEvent.InitData:
        await initData();
        break;
    }
    super.onEvent(event, data);
  }

  void setBundle(Map<String,dynamic> bundle){
    deliveryNo = bundle[FragmentArg.DELIVERY_NO];
    shipmentNo = bundle[FragmentArg.DELIVERY_SHIPMENT_NO];
    accountNumber = bundle[FragmentArg.DELIVERY_ACCOUNT_NUMBER];
    customerName = bundle[FragmentArg.TASK_CUSTOMER_NAME];
  }

  Future initData() async {
    await DeliveryModel().initData(deliveryNo);
    await fillProductData();
    await fillEmptyProductData();
    address = DeliveryModel().mDeliveryHeader.DeliveryAddress;
    orderNo = DeliveryModel().mDeliveryHeader.OrderNo;
//    phone = DeliveryModel().mDeliveryHeader.DeliveryPhone;
    phone = '123456789';
    data = DateUtil.getDateStrByDateTime(DateTime.now());
  }

  Future fillProductData() async {
    productList.clear();

    List<DSD_T_DeliveryItem_Entity> tList = DeliveryModel().deliveryItemList;

    for (DSD_T_DeliveryItem_Entity tItem in tList) {
      if(tItem.IsReturn == IsReturn.TRUE) continue;
      if (int.tryParse(tItem.ActualQty) == 0) continue;

      BaseProductInfo info = new BaseProductInfo();
      info.code = tItem.ProductCode;
      info.name = (await Application.productMap)[tItem.ProductCode];
      if (tItem.ProductUnit == ProductUnit.CS) {
        info.plannedCs = int.tryParse(tItem.PlanQty);
        info.actualCs = int.tryParse(tItem.ActualQty);
      } else {
        info.plannedEa = int.tryParse(tItem.PlanQty);
        info.actualEa = int.tryParse(tItem.ActualQty);
      }
      info.isInMDelivery = true;
      productList.add(info);
    }
  }

  Future fillEmptyProductData() async {
    emptyProductList.clear();

    List<DSD_T_DeliveryItem_Entity> tList = DeliveryModel().deliveryItemList;

    for (DSD_T_DeliveryItem_Entity tItem in tList) {
      if(tItem.IsReturn != IsReturn.TRUE) continue;
      if (int.tryParse(tItem.ActualQty) == 0) continue;

      BaseProductInfo info = new BaseProductInfo();
      info.code = tItem.ProductCode;
      info.name = (await Application.productMap)[tItem.ProductCode];
      info.actualCs = int.tryParse(tItem.ActualQty);
      emptyProductList.add(info);
    }
  }

  Future onClickRight(BuildContext context,GlobalKey rootWidgetKey) async {
    await savePrintPng(rootWidgetKey);
    showBlueDialog(context);
  }

  void showBlueDialog(BuildContext context){
    BlueManager().scan((deviceList){
      List<KeyValueInfo> list = deviceList.map((device){
        return new KeyValueInfo()
          ..name = device.name
          ..value = device.name
          ..data = device;
      }).toList();

      //添加弹出框消失回调方法
      ListDialog.show(context,title: 'title',data: list,onSelect: (reason) async {
        BluetoothDevice device = reason.data;
        BlueManager().sendAddress(device.id.toString());
      });
    });

  }


  Future<Uint8List> savePrintPng(GlobalKey rootWidgetKey) async {
    try {
      RenderRepaintBoundary boundary =
      rootWidgetKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      await FileUtil.saveFileData(pngBytes,Constant.WORK_IMG,'print.png');
      return pngBytes;//这个对象就是图片数据
    } catch (e) {
      print(e);
    }
    return null;
  }

  Uint8List getCustomerSign() {
    return FileUtil.readFileData(Constant.WORK_IMG, 'signature.png');
  }

  Uint8List getDriverSign() {
    return FileUtil.readFileData(Constant.WORK_IMG, 'signature2.png');
  }

  @override
  void dispose() {
    BlueManager().cancel();
    DeliveryModel().clear();
    print('****************dispose:DeliveryModel().clear()**********************');
    super.dispose();
  }
}