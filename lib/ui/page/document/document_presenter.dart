import 'package:dsd/application.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/ui/page/document/document_info.dart';
import 'package:dsd/ui/page/print/print_module_type.dart';
import 'package:fluro/fluro.dart';
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

  void setPageParams(Map<String, List<String>> params) {
    shipmentNo = params[FragmentArg.DELIVERY_SHIPMENT_NO].first;
    accountNumber = params[FragmentArg.DELIVERY_ACCOUNT_NUMBER].first;
    customerName = params[FragmentArg.TASK_CUSTOMER_NAME].first;
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
    String path =
    '''${Routers.print_delivery_slip}?${FragmentArg.DELIVERY_NO}=${info.deliveryNo}&${FragmentArg.DELIVERY_SHIPMENT_NO}=$shipmentNo&${FragmentArg.DELIVERY_ACCOUNT_NUMBER}=$accountNumber&${FragmentArg.TASK_CUSTOMER_NAME}=$customerName''';

    Application.router.navigateTo(context, path, transition: TransitionType.inFromLeft);
  }

}