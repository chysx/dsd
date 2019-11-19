import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';

import '../../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/22 15:54

enum VisitSummaryDetailEvent {
  InitData,
}

class VisitSummaryDetailPresenter extends EventNotifier<VisitSummaryDetailEvent> {
  List<BaseProductInfo> productList = [];
  String deliveryNo;

  @override
  void onEvent(VisitSummaryDetailEvent event, [dynamic data]) async {
    switch (event) {
      case VisitSummaryDetailEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  void setBundle(Map<String,dynamic> bundle){
    deliveryNo = bundle[FragmentArg.DELIVERY_NO];

  }

  Future initData() async {
    await fillProductData();
  }

  Future fillProductData() async {
    List<DSD_T_DeliveryItem_Entity> list = await Application.database.tDeliveryItemDao.findEntityByDeliveryNo(deliveryNo);
    for(DSD_T_DeliveryItem_Entity entity in list){
      BaseProductInfo info = new BaseProductInfo();
      info.code = entity.ProductCode;
      info.name = (await Application.productMap)[info.code];
      if(entity.ProductUnit == ProductUnit.CS){
        info.plannedCs = int.tryParse(entity.PlanQty);
        info.actualCs = int.tryParse(entity.ActualQty);
      }
      if(entity.ProductUnit == ProductUnit.EA){
        info.plannedEa = int.tryParse(entity.PlanQty);
        info.actualEa = int.tryParse(entity.ActualQty);
      }
      productList.add(info);
    }
  }

}