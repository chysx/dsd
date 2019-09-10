import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/visit_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:dsd/ui/page/route/customer_info.dart';
import 'package:dsd/ui/page/route/route_presenter.dart';
import 'package:dsd/utils/sql_util.dart';
import 'package:flustars/flustars.dart';

import '../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/3 17:39

class RouteManager {
  ///
  /// 根据ShipmentNo获取Customer列表
  ///
  /// @param shipmentNo
  /// @return
  ///
   static Future<List<CustomerInfo>> getCustomerInfoList(String shipmentNo, String shipmentType) async {
    if (shipmentType == ShipmentType.DELIVERY) {
      List<CustomerInfo> allList = [];
      allList.addAll(await getCustomerInfoListByDelivery(shipmentNo));
      //VanSales的门店可能被添加到Delivery类型的Shipment中
//      allList.addAll(getCustomerInfoListByVanSales(shipmentNo));
//      RoutePresenter.makeIndex(allList);
      return allList;
    } else if (shipmentType == ShipmentType.VANSALES) {
//      return getCustomerInfoListByVanSales(shipmentNo);
    }

    return <CustomerInfo>[];
  }

   ///
   /// 获取指定Shipment下的门店（也就是Delivery类型的门店）数据和门店状态（包括，是什么类型的门店，已做任务后的Status，是否完成拜访）
   ///
    static Future<List<CustomerInfo>> getCustomerInfoListByDelivery(String shipmentNo) async {
     List<CustomerInfo> resultList = [];
     String sql = ''' 
             SELECT
            t.accountnumber,
            t.name,
            j1.deliveryaddress,
            j2.name as name1,
            j1.Telephone,
            j2.mobilephone,
            t.Geo_Latitude,
            t.Geo_Longitude,
            t.ebMobile__OrderBlock__c,
            t.ebMobile__Barcode__c,
            j1.DeliveryTimeSlotFrom,
            j1.DeliveryTimeSlotTo 
        FROM
            md_account t          
        JOIN
            dsd_m_deliveryheader j1            
                ON t.accountnumber = j1.accountnumber          
        LEFT JOIN
            md_contact j2            
                ON t.accountnumber = j2.accountnumber__c 
        WHERE
            j1.shipmentno = ? 
        GROUP BY
            t.accountnumber 
        ORDER BY
            j1.DeliverySequence
      ''';

     SqlUtil.log(sql, [shipmentNo]);

     var db = Application.database.database;
     List<Map<String, dynamic>> list = await db.rawQuery(sql,[shipmentNo]);
     for (Map<String, dynamic> map in list) {
        CustomerInfo info = CustomerInfo();
        List<dynamic> values = map.values.toList();
        resultList.add(info);
        info
          ..accountNumber = values[0]
          ..name = values[1]
          ..address = values[2]
          ..contactName = values[3]
          ..phone = values[4]
          ..tel = values[5]
          ..latitude = double.tryParse(values[6])
          ..longitude = double.tryParse(values[7])
          ..block = values[8]
          ..barcode = values[9]
//          ..timeSlotFrom = DateUtil.getDateStrByTimeStr(values[10],format: DateFormat.HOUR_MINUTE)
//          ..timeSlotTo = DateUtil.getDateStrByTimeStr(values[11],format: DateFormat.HOUR_MINUTE)
          ..index = RoutePresenter.realMakeIndex(resultList.length)
          ..customerType = CustomerType.Delivery;
        info.isVisitComplete = await VisitManager.isVisitCompleteByCustomer(shipmentNo, info.accountNumber);

        Map<String, List<DSD_T_DeliveryHeader_Entity>> tDeliveryMap = await getCustomerDeliveryMap(shipmentNo);
        List<DSD_M_DeliveryHeader_Entity> deliveryHeaderList = await Application.database.mDeliveryHeaderDao.findEntityByCon(shipmentNo, info.accountNumber);
        info.status = getCustomerDeliveryStatus(tDeliveryMap[info.accountNumber], deliveryHeaderList,info.accountNumber,shipmentNo);

     }
     return resultList;
   }

   ///
   /// 获取Delivery类型门店的Status状态
   /// @param tDeliveryEntityList DSD_T_DeliveryHeader_Entity交易数据表构成的状态集合
   /// @param mDeliveryEntityList DSD_M_DeliveryHeader_Entity 主数据表指定客户包含的delivery数量
   /// @return
   ///
    static String getCustomerDeliveryStatus(List<DSD_T_DeliveryHeader_Entity> tDeliveryEntityList,
       List<DSD_M_DeliveryHeader_Entity> mDeliveryEntityList, String accountNumber, String shipmentNo) {

     //没有做过任何配送任务并且没有做过PreSell任务（PreSell任务数据不在DSD_T_DeliveryHeader表中，
     // 有自己单独的数据表存储）则该门店的状态为默认状态
     if ((tDeliveryEntityList == null || tDeliveryEntityList.length == 0)) {
       return DeliveryStatus.DEFALUT_DELIVERY;
     }

     if (tDeliveryEntityList == null) {
       tDeliveryEntityList = [];
     }

     //在M表中能查到的T表数据
     List<String> tDeliveryStatusInMList = [];
     for (DSD_T_DeliveryHeader_Entity tEntity in tDeliveryEntityList) {
       for (DSD_M_DeliveryHeader_Entity mEntity in mDeliveryEntityList) {
         if (mEntity.DeliveryNo == tEntity.DeliveryNo) {
           tDeliveryStatusInMList.add(tEntity.DeliveryStatus);
           break;
         }
       }
     }

     //T表所有数据
     List<String> tDeliveryStatus = [];
     for (DSD_T_DeliveryHeader_Entity tEntity in tDeliveryEntityList) {
       tDeliveryStatus.add(tEntity.DeliveryStatus);
     }

     bool isHasTradeReturn = false;
     bool isHasEmptyReturn = false;
     for (DSD_M_DeliveryHeader_Entity mEntity in mDeliveryEntityList) {
       if (mEntity.DeliveryType == TaskType.TradeReturn) {
         isHasTradeReturn = true;
       }
       if (mEntity.DeliveryType == (TaskType.EmptyReturn)) {
         isHasEmptyReturn = true;
       }
     }

     int mCount = mDeliveryEntityList.length;
     int tCountInM = tDeliveryStatusInMList.length;
     int totalCount = mCount;

     if (!isHasTradeReturn) totalCount += 1;//业务要求：如果计划内没有TradeReturn，需要自动生成一个TradeReturn
     if (!isHasEmptyReturn) totalCount += 1;//业务要求：如果计划内没有TradeReturn，需要自动生成一个EmptyReturn
     totalCount += 1;//业务要求：需要自动生成一个VanSales

     Set<String> tTreeSetInM = new Set.of(tDeliveryStatusInMList);
     Set<String> tTreeSet = new Set.of(tDeliveryStatus);

     //所有配送任务都是取消状态，则该门店的Status为CANCEL状态
     if (tCountInM == mCount && tTreeSetInM.length == 1 && tTreeSetInM.contains(DeliveryStatus.CANCEL_VALUE)) {
       return DeliveryStatus.CANCEL;
     }
//        if (tTreeSetInM.contains(DictionaryConfig.DeliveryStatus.REBOOK_VALUE)) {
//            return DictionaryConfig.DeliveryStatus.REBOOK;
//        }


     //所有配送任务中，只要有一个状态是PARTIAL_DELIVERED状态，则该门店的Status为PARTIAL_DELIVERED状态
     if (tTreeSetInM.contains(DeliveryStatus.PARTIAL_DELIVERED_VALUE)) {
       return DeliveryStatus.PARTIAL_DELIVERED;
     }
     //所有配送任务中，只要有一个状态是PARTIAL_DELIVERED状态，则该门店的Status为PARTIAL_DELIVERED状态
     if (tCountInM == mCount && tTreeSetInM.length == 1 && tTreeSet.contains(DeliveryStatus.TOTAL_DELIVERED_VALUE)) {
       return DeliveryStatus.TOTAL_DELIVERED;
     }
     //如果只有一个配送任务并且是REBOOK_VALUE状态，则该门店的Status为TOTAL_DELIVERED状态
     if (tCountInM == mCount && tTreeSetInM.length == 1 && tTreeSet.contains(DeliveryStatus.REBOOK_VALUE)) {
       return DeliveryStatus.TOTAL_DELIVERED;
     }
     //如果所有配送任务的状态是TOTAL_DELIVERED_VALUE或REBOOK_VALUE，则该门店的Status为TOTAL_DELIVERED状态
     if (tCountInM == mCount && tTreeSetInM.length == 2 && tTreeSet.contains(DeliveryStatus.TOTAL_DELIVERED_VALUE) &&
         tTreeSet.contains(DeliveryStatus.REBOOK_VALUE)) {
       return DeliveryStatus.TOTAL_DELIVERED;
     }
     //如果以上都不满足，且有一个任务的状态是TOTAL_DELIVERED_VALUE的，则该门店的Status为PARTIAL_DELIVERED状态
     if (tTreeSet.contains(DeliveryStatus.TOTAL_DELIVERED_VALUE)) {
       return DeliveryStatus.PARTIAL_DELIVERED;
     }
     return DeliveryStatus.DEFALUT_DELIVERY;

   }

   ///
   /// 每个门店包含的已经做过的配送任务（比如Delivery,TradeReturn,EmptyReturn,Vansales等等任务）;
   /// key:门店编号(accountNumber)
   /// value:DSD_T_DeliveryHeader_Entity列表(deliveryEntityList)
   ///
   /// @param shipmentNo
   /// @return
   ///
     static Future<Map<String, List<DSD_T_DeliveryHeader_Entity>>> getCustomerDeliveryMap(String shipmentNo) async {
     List<DSD_T_DeliveryHeader_Entity> tDeliveryEntityList = await Application.database.tDeliveryHeaderDao.findEntityByShipmentNo(shipmentNo);

     //将tDeliveryEntityList转化成HashMap，key：门店编号(accountNumber),value：delivery状态列表(DeliveryStatusList)
     //一个门店对应多个送货单delivery
     Map<String, List<DSD_T_DeliveryHeader_Entity>> tDeliveryMap = {};
     for (DSD_T_DeliveryHeader_Entity entity in tDeliveryEntityList) {
       String accountNumber = entity.AccountNumber;
       if (tDeliveryMap[accountNumber] == null) {
         List<DSD_T_DeliveryHeader_Entity> deliveryEntityList = [];
         deliveryEntityList.add(entity);
         tDeliveryMap[accountNumber] = deliveryEntityList;
       } else {
         List<DSD_T_DeliveryHeader_Entity> deliveryEntityList = tDeliveryMap[accountNumber];
         deliveryEntityList.add(entity);
       }
     }
     return tDeliveryMap;
   }

}