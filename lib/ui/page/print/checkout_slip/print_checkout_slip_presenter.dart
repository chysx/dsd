import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dsd/application.dart';
import 'package:dsd/business/signature/signature_logic.dart';
import 'package:dsd/business/signature/signature_util.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/check_out_and_in_model.dart';
import 'package:dsd/ui/dialog/list_blue_dialog.dart';
import 'package:dsd/ui/dialog/list_dialog.dart';
import 'package:dsd/ui/dialog/loading_dialog.dart';
import 'package:dsd/ui/dialog/model/key_value_info.dart';
import 'package:dsd/utils/file_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../blue_manager.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019-12-31 16:16

enum PrintCheckoutSlipEvent {
  InitData,
}

class PrintCheckoutSlipPresenter extends EventNotifier<PrintCheckoutSlipEvent> {
  List<BaseProductInfo> productList = [];
  List<BaseProductInfo> emptyProductList = [];
  String shipmentNo;
  String shipmentTime;
  String driverCode;
  String driverName;
  String checkerCode;
  String checkerName;


  @override
  Future onEvent(PrintCheckoutSlipEvent event, [dynamic data]) async {
    switch (event) {
      case PrintCheckoutSlipEvent.InitData:
        await initData();
        break;
    }
    super.onEvent(event, data);
  }

  void setBundle(Map<String, dynamic> bundle) {
    shipmentNo = bundle[FragmentArg.ROUTE_SHIPMENT_NO];
  }

  Future initData() async {
    await CheckOutModel().initData(shipmentNo);
    fillHeaderContent();
    await fillProductData();
  }

  Future<void> fillHeaderContent() async {
    shipmentTime = CheckOutModel().shipmentHeader.StartTime;
    driverCode = Application.user.userCode;
    driverName = Application.user.userName;

    Role role = await SignatureUtil.getRole(UserType.CHECKER, null);
    checkerCode = role.code;
    checkerName = CheckOutModel().shipmentHeader.Checker;
  }

  Future<void> fillProductData() async {
    Map<String, BaseProductInfo> hashMap = {};
    for (DSD_T_ShipmentItem_Entity tItem in CheckOutModel().shipmentItemList) {
//      if(tItem.IsReturn == Equpmen.TRUE) continue;
      if (tItem.CheckOutActualQty == 0) continue;

      String code = tItem.ProductCode;
      BaseProductInfo info = hashMap[code];
      if (info == null) {
        info = new BaseProductInfo();
        hashMap[code] = info;
        info.code = code;
        info.name = (await Application.productMap)[code];
      }

      if (tItem.ProductCode == info.code) {
        if (tItem.ProductUnit == ProductUnit.CS) {
          info.actualCs = tItem.CheckOutActualQty;
        } else if (tItem.ProductUnit == ProductUnit.EA) {
          info.actualEa = tItem.CheckOutActualQty;
        }
      }

    }

    print('length = ${CheckOutModel().shipmentItemList.length} ');
    productList.clear();
    for (BaseProductInfo info in hashMap.values) {
      productList.add(info);
    }
  }


  Future onClickRight(BuildContext context,GlobalKey rootWidgetKey) async {
    await savePrintPng(rootWidgetKey);
    showBlueDialog(context);
  }

  void showBlueDialog(BuildContext context){
//    LoadingDialog.show(context,msg: 'loading...');
    BlueManager().scan(context,(deviceList){
//      LoadingDialog.dismiss(context);
      List<KeyValueInfo> list = deviceList.map((device){
        return new KeyValueInfo()
          ..name = device.name
          ..value = device.name
          ..data = device;
      }).toList();

      //添加弹出框消失回调方法
      ListBlueDialog.show(context,title: 'title',data: list,onSelect: (reason) async {
        BluetoothDevice device = reason.data;
        if(Platform.isAndroid){
          BlueManager().sendAddress(device.id.toString());
        }else if(Platform.isIOS){
          BlueManager().sendAddress(device.name);
        }
      },onClose: (){
        BlueManager().cancel();
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
//    return FileUtil.readFileData(Constant.WORK_IMG, 'signature.png');
    return null;
  }

  Uint8List getDriverSign() {
//    return FileUtil.readFileData(Constant.WORK_IMG, 'signature2.png');
    return null;
  }

}