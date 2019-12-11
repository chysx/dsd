import 'package:dsd/common/business_const.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_item_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/model/base_product_info.dart';
import '../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019-12-04 14:37

class ProductUtil {
  static Future<List<BaseProductInfo>> mergeTProduct(
      List<DSD_T_DeliveryItem_Entity> tList,
      bool isInM) async {
    Map<String, BaseProductInfo> hashMap = {};
    for (DSD_T_DeliveryItem_Entity tItem in tList) {
      if(tItem.IsReturn == IsReturn.TRUE) continue;
      if (int.tryParse(tItem.ActualQty) == 0) continue;

      String code = tItem.ProductCode;
      BaseProductInfo info = hashMap[code];
      if (info == null) {
        info = new BaseProductInfo();
        hashMap[code] = info;
        info.code = code;
        info.name = (await Application.productMap)[code];
        info.isInMDelivery = isInM;
        info.reasonValue = tItem.Reason;
      }

      if (tItem.ProductCode == info.code) {
        if (tItem.ProductUnit == ProductUnit.CS) {
          info.plannedCs = int.tryParse(tItem.PlanQty);
          info.actualCs = int.tryParse(tItem.ActualQty);
        } else if (tItem.ProductUnit == ProductUnit.EA) {
          info.plannedEa = int.tryParse(tItem.PlanQty);
          info.actualEa = int.tryParse(tItem.ActualQty);
        }
      }
    }


    List<BaseProductInfo> result = [];
    for(BaseProductInfo info in hashMap.values){
      result.add(info);
    }

    return result;
  }

   static Future<List<BaseProductInfo>> mergeMProduct(List<DSD_M_DeliveryItem_Entity> mList,bool isInM) async {
    Map<String,BaseProductInfo> hashMap = {};
    for(DSD_M_DeliveryItem_Entity mItem in mList){
      String code = mItem.ProductCode;
      BaseProductInfo info = hashMap[code];
      if (info == null) {
        info = new BaseProductInfo();
        hashMap[code] = info;
        info.code = code;
        info.name = (await Application.productMap)[code];
        info.isInMDelivery = isInM;
      }

      if (mItem.ProductCode == info.code) {
        if (mItem.ProductUnit == ProductUnit.CS) {
          info.plannedCs = int.tryParse(mItem.PlanQty);
        } else if (mItem.ProductUnit == ProductUnit.EA) {
          info.plannedEa = int.tryParse(mItem.PlanQty);
        }
      }

    }

    List<BaseProductInfo> result = [];
    for(BaseProductInfo info in hashMap.values){
      result.add(info);
    }

    return result;
  }

}
