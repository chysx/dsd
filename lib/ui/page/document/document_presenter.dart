import 'package:dsd/application.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/route/page_builder.dart';
import 'package:dsd/ui/page/document/document_info.dart';
import 'package:dsd/ui/page/print/print_module_type.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/30 14:57

enum DocumentEvent {
  InitData,
}

class DocumentPresenter extends EventNotifier<DocumentEvent> {
  List<DocumentInfo> documentList = [];
  String shipmentNo;
  String accountNumber;
  String customerName;


  @override
  Future onEvent(DocumentEvent event, [dynamic data]) async {
    switch (event) {
      case DocumentEvent.InitData:
        await initData();
        break;
    }
    super.onEvent(event, data);
  }


  void setBundle(Map<String,dynamic> bundle){
    shipmentNo = bundle[FragmentArg.DELIVERY_SHIPMENT_NO];
  accountNumber = bundle[FragmentArg.DELIVERY_ACCOUNT_NUMBER];
  customerName = bundle[FragmentArg.TASK_CUSTOMER_NAME];
  }

  Future initData() async {
    await fillDocumentData();
  }

  Future fillDocumentData() async {
    documentList.clear();
    List<DSD_T_DeliveryHeader_Entity> deliveryList = await Application.database.tDeliveryHeaderDao.findEntityByCon(shipmentNo, accountNumber);
    for(DSD_T_DeliveryHeader_Entity entity in deliveryList) {
      DocumentInfo info = new DocumentInfo();
      info.name = 'Delivery Slip';
      info.deliveryNo = entity.DeliveryNo;
      info.printType = PrintModuleType.DELIVERY_SLIP;
      documentList.add(info);
    }
  }

  void onItemClick(BuildContext context, DocumentInfo info) {
    Map<String,dynamic> bundle = {
      FragmentArg.DELIVERY_NO: info.deliveryNo,
      FragmentArg.DELIVERY_SHIPMENT_NO: shipmentNo,
      FragmentArg.DELIVERY_ACCOUNT_NUMBER: accountNumber,
      FragmentArg.TASK_CUSTOMER_NAME: customerName,
    };
    Navigator.pushNamed(context, PageName.print_delivery_slip.toString(),arguments: bundle);

  }

}