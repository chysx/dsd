import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/model/base_product_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019-12-11 11:41

class DeliveryUtil {
  static Future<List<BaseProductInfo>> createEmptyProductList(List<DSD_T_DeliveryItem_Entity> tList) async {
    List<BaseProductInfo> result = [];
    for (DSD_T_DeliveryItem_Entity tItem in tList) {
      if(tItem.IsReturn != IsReturn.TRUE) continue;
      if (int.tryParse(tItem.ActualQty) == 0) continue;

      BaseProductInfo info = new BaseProductInfo();
      info.code = tItem.ProductCode;
      info.name = (await Application.productMap)[tItem.ProductCode];
      info.actualCs = int.tryParse(tItem.ActualQty);
      result.add(info);
    }
    return result;
  }
}