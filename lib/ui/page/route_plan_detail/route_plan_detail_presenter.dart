import 'package:dsd/application.dart';
import 'package:dsd/business/product_util.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-01-03 09:57

enum RoutePlanDetailEvent {
  InitData,
}

class RoutePlanDetailPresenter extends EventNotifier<RoutePlanDetailEvent>{
  List<BaseProductInfo> productList = [];
  String orderNo;
  String deliveryNo;

  @override
  Future onEvent(RoutePlanDetailEvent event, [dynamic data]) async {
    switch (event) {
      case RoutePlanDetailEvent.InitData:
        await initData();
        break;
    }
    super.onEvent(event, data);
  }

  void setBundle(Map<String, dynamic> bundle) {
    orderNo = bundle[FragmentArg.ROUTE_ORDER_NO];
    deliveryNo = bundle[FragmentArg.DELIVERY_NO];
  }

  Future initData() async {
    await fillProductData();
  }

  Future<void> fillProductData() async {
    List<DSD_M_DeliveryItem_Entity> mList = await Application.database.mDeliveryItemDao.findEntityByDeliveryNo(deliveryNo);
    productList = await ProductUtil.mergeMProduct(mList, true);
  }
}