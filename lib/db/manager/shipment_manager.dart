import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/dictionary_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_shipment_header_entity.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/shipment_info.dart';
import 'package:dsd/synchronization/sync/sync_dirty_status.dart';
import 'package:dsd/utils/sql_util.dart';
import 'package:flustars/flustars.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/29 10:32

class ShipmentManager {
  ///
  /// 获取该用户所有已经checkout了的Shipment数据（包括历史数据，可查看dsd_t_shipmentheader表，由于
  /// 没有判断dirty值，所以过去checkout了但没有上传过留在本地的数据也会查出来，这里值的讨论（因为
  /// 在同步界面只会显示当天的失败或是成功记录，不会显示过去的，因此就没有机会上传之前失败的记录了））
  ///
  static Future<List<ShipmentInfo>> getShipmentHeaderByCheckOut() async {
    String sql = ''' 
            SELECT
            t1.shipmentno,
            t1.shipmenttype,
            t2.status,
            t3.description,
            t1.ShipmentDate,
            t1.LoadingSequence 
        FROM
            dsd_m_shipmentheader AS t1        
        INNER JOIN
            dsd_t_shipmentheader AS t2          
                ON t1.shipmentno = t2.shipmentno             
                AND t2.actiontype = 'CHKO'             
                AND t2.status = 'CHKO'        
        LEFT JOIN
            md_dictionary AS t3          
                ON t2.status = t3.VALUE             
                AND t3.category = 'ShipmentStatus'
        WHERE
            t1.Valid = 'True'
     ''';
    SqlUtil.log(sql);
    List<ShipmentInfo> result = [];
    var db = Application.database.database;
    List<Map<String, dynamic>> list = await db.rawQuery(sql);
    for (Map<String, dynamic> map in list) {
      ShipmentInfo info = new ShipmentInfo();
      List values = map.values.toList();
      info
        ..no = values[0]
        ..type = values[1]
        ..status = values[2]
        ..description = values[3]
        ..shipmentDate = values[4]
        ..sequence = values[5];
      result.add(info);
    }
    return result;
  }

  ///
  /// 获取今天以前未做checkout和checkIn的Shipment数据（即MShipmentHeader表）
  /// 主要包含两部分:
  /// 1.没有做任何东西（inventory和finance），此时dsd_t_shipmentheader表没有记录;
  /// 2.做了inventory或是finance，但是没有下一步，即没有完全做完checkout，此时dsd_t_shipmentheader有记录，其中status是null的
  ///
  ///
  static Future<List<ShipmentInfo>> getMShipmentHeaderByLastDay() async {
    String sql = ''' 
            SELECT
            m.shipmentno,
            m.shipmenttype,
            m.ShipmentDate,
            m.LoadingSequence          
        FROM
            dsd_m_shipmentheader m          
        LEFT JOIN
            dsd_t_shipmentheader t                   
                on m.shipmentno = t.shipmentno          
        WHERE
            m.shipmentdate < ? 
            and t.status is null 
            and m.Valid = 'True'
     ''';
    String date = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.YEAR_MONTH_DAY);
    SqlUtil.log(sql, [date]);
    List<ShipmentInfo> result = [];
    var db = Application.database.database;
    List<Map<String, dynamic>> list = await db.rawQuery(sql, [date]);
    for (Map<String, dynamic> map in list) {
      ShipmentInfo info = new ShipmentInfo();
      List values = map.values.toList();
      info
        ..no = values[0]
        ..type = values[1]
        ..shipmentDate = values[2]
        ..sequence = values[3]
        ..status = ShipmentStatus.RELE;
      result.add(info);
    }
    return result;
  }

  ///
  /// 获取所有未做checkout和checkIn的Shipment数据（即MShipmentHeader表）
  /// 主要包含两部分:
  /// 1.没有做任何东西（inventory和finance），此时dsd_t_shipmentheader表没有记录;
  /// 2.做了inventory或是finance，但是没有下一步，即没有完全做完checkout，此时dsd_t_shipmentheader有记录，其中status是null的
  ///
  ///
  static Future<List<ShipmentInfo>> getMShipmentHeaderByAll() async {
    String sql = ''' 
        SELECT m.shipmentno,
               m.shipmenttype
        FROM   dsd_m_shipmentheader m
        LEFT JOIN dsd_t_shipmentheader t
                 ON m.shipmentno = t.shipmentno
        WHERE  t.status IS NULL 
               and m.Valid = 'True'
     ''';
    SqlUtil.log(sql);
    List<ShipmentInfo> result = [];
    var db = Application.database.database;
    List<Map<String, dynamic>> list = await db.rawQuery(sql);
    for (Map<String, dynamic> map in list) {
      ShipmentInfo info = new ShipmentInfo();
      List values = map.values.toList();
      info
        ..no = values[0]
        ..type = values[1];
      info.status = ShipmentStatus.RELE;
      info.description = await DictionaryManager.getDictionaryDescription(ShipmentStatus.CATEGORY,ShipmentStatus.RELE);
      result.add(info);
    }
    return result;
  }

  ///
  /// 获取该用户今天已经CheckIn的Shipment列表数据（不管有没有上传过）
  ///
  static Future<List<ShipmentInfo>> getShipmentHeaderByCheckInByToday() async {
    String sql = ''' 
          SELECT
            t1.shipmentno,
            t1.shipmenttype,
            t2.status,
            t3.description,
            t2.dirty,
            t1.ShipmentDate,
            t1.LoadingSequence 
        FROM
            dsd_m_shipmentheader AS t1        
        INNER JOIN
            dsd_t_shipmentheader AS t2          
                ON t1.shipmentno = t2.shipmentno             
                AND t2.actiontype = 'CHKI'             
                AND t2.status = 'CHKI'        
        LEFT JOIN
            md_dictionary AS t3          
                ON t2.status = t3.VALUE             
                AND t3.category = 'ShipmentStatus' 
        WHERE
            t2.EndTime > ?
            AND t1.Valid = 'True'
     ''';
    String date = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.YEAR_MONTH_DAY);
    SqlUtil.log(sql, [date]);
    List<ShipmentInfo> result = [];
    var db = Application.database.database;
    List<Map<String, dynamic>> list = await db.rawQuery(sql, [date]);
    for (Map<String, dynamic> map in list) {
      ShipmentInfo info = new ShipmentInfo();
      List values = map.values.toList();
      String dirty = values[4] ?? "";
      if (dirty == SyncDirtyStatus.SUCCESS || dirty == SyncDirtyStatus.FAIL || dirty == SyncDirtyStatus.EXIST) {
        info.isComplete = true;
      }
      info
        ..no = values[0]
        ..type = values[1]
        ..status = values[2]
        ..description = values[3]
        ..shipmentDate = values[5]
        ..sequence = values[6];
      result.add(info);
    }
    return result;
  }

  ///
  /// 获取该用户今天以前已经CheckIn的Shipment列表数据（不管有没有上传过）
  ///
  static Future<List<ShipmentInfo>> getShipmentHeaderByCheckInByLast() async {
    String sql = ''' 
          SELECT
            t1.shipmentno,
            t1.shipmenttype,
            t2.status,
            t3.description,
            t2.dirty,
            t1.ShipmentDate,
            t1.LoadingSequence 
        FROM
            dsd_m_shipmentheader AS t1        
        INNER JOIN
            dsd_t_shipmentheader AS t2          
                ON t1.shipmentno = t2.shipmentno             
                AND t2.actiontype = 'CHKI'             
                AND t2.status = 'CHKI'        
        LEFT JOIN
            md_dictionary AS t3          
                ON t2.status = t3.VALUE             
                AND t3.category = 'ShipmentStatus' 
        WHERE
            t2.EndTime < ? 
            AND t1.Valid = 'True'
     ''';
    String date = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.YEAR_MONTH_DAY);
    SqlUtil.log(sql, [date]);
    List<ShipmentInfo> result = [];
    var db = Application.database.database;
    List<Map<String, dynamic>> list = await db.rawQuery(sql, [date]);
    for (Map<String, dynamic> map in list) {
      ShipmentInfo info = new ShipmentInfo();
      List values = map.values.toList();
      String dirty = values[4] ?? "";
      if (dirty == SyncDirtyStatus.SUCCESS || dirty == SyncDirtyStatus.FAIL || dirty == SyncDirtyStatus.EXIST) {
        info.isComplete = true;
      }
      info
        ..no = values[0]
        ..type = values[1]
        ..status = values[2]
        ..description = values[3]
        ..shipmentDate = values[5]
        ..sequence = values[6];
      result.add(info);
    }
    return result;
  }

  ///
  /// 获取今天计划内的shipment数据，和过去已经CheckOut了但是没有CheckIn的shipment数据
  ///
  static Future<List<ShipmentInfo>> getShipmentListByToday() async {
    List<ShipmentInfo> resultList = [];

    List<ShipmentInfo> releaseByTodayList = [];
    List<ShipmentInfo> checkOutByAllList = await getShipmentHeaderByCheckOut();
    List<ShipmentInfo> checkInByTodayList = await getShipmentHeaderByCheckInByToday();
    List<ShipmentInfo> checkInByLastList = await getShipmentHeaderByCheckInByLast();

    String date = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.YEAR_MONTH_DAY);
    List<DSD_M_ShipmentHeader_Entity> defaultList =
        await Application.database.mShipmentHeaderDao.findByByToday(date, Valid.EXIST);

    for (DSD_M_ShipmentHeader_Entity entity in defaultList) {
      ShipmentInfo info = new ShipmentInfo();
      info.no = entity.ShipmentNo;
      info.type = entity.ShipmentType;
      info.status = ShipmentStatus.RELE;
      info.description = await DictionaryManager.getDictionaryDescription(ShipmentStatus.CATEGORY, ShipmentStatus.RELE);
      info.shipmentDate = entity.ShipmentDate;
      info.sequence = entity.LoadingSequence;
      releaseByTodayList.add(info);
    }

    //将当天以前已经CheckIn的shipment过滤掉
    checkOutByAllList.removeWhere((item) {
      for (ShipmentInfo info in checkInByLastList) {
        return item.no == info.no;
      }
      return false;
    });

    //同时做了checkout和checkIn的shipment的状态改为checkIn的状态
    for (ShipmentInfo checkOutItem in checkOutByAllList) {
      for (ShipmentInfo checkInItem in checkInByTodayList) {
        if (checkOutItem.no == checkInItem.no) {
          if (checkInItem.status.isNotEmpty) {
            checkOutItem.status = checkInItem.status;
            checkOutItem.description = checkInItem.description;
          }
        }
      }
    }
    resultList.addAll(checkOutByAllList);

    //添加当天默认release状态的shipment
    for (ShipmentInfo releaseInfo in releaseByTodayList) {
      bool isFind = false;
      for (ShipmentInfo checkOutInfo in checkOutByAllList) {
        if (checkOutInfo.no == releaseInfo.no) {
          isFind = true;
          break;
        }
      }
      if (!isFind) {
        resultList.add(releaseInfo);
      }
    }

    return resultList;
  }

  static Future<List<ShipmentInfo>> getShipmentList() async {
    List<ShipmentInfo> resultList = [];
    List<ShipmentInfo> releaseByTodayList = await getShipmentListByToday();
    List<ShipmentInfo> releaseByLastList = await getMShipmentHeaderByLastDay();
    resultList.addAll(releaseByTodayList);
    //为什么事过滤而不是直接addAll,是因为存在这样一种情况（之前测出来的一个bug）:
    //比如：过去lastDay,M表有shipmentNo = 123,T表有对应有两条数据（shipmentNO也是123）,一条是
    //已经做完checkout，status为CHKO，另一条是checkin，但是没有做完，只是actionType为CHKI，status
    //为null,此时会将这条数据查出来，但是之前查询过去checkou的数据时已经存在该shipment了，所以要将
    //这条shipment过滤掉，而不是一股脑的直接添加
    for (ShipmentInfo info in releaseByLastList) {
      bool isFind = false;
      for (ShipmentInfo item in resultList) {
        if (info.no == item.no) {
          isFind = true;
        }
      }
      if (!isFind) {
        resultList.add(info);
      }
    }

    for(var info in resultList){
      print(info);
    }
    return resultList;
  }

  ///
  /// 获取今天计划内的shipment数据，和过去已经CheckOut了但是没有CheckIn的shipment数据
  ///
  static Future<List<ShipmentInfo>> getShipmentNoListByCheckOut() async {
    String sql = ''' 
          SELECT
            t1.shipmentno,
            t1.shipmenttype,
            t2.status,
            t2.dirty,
            t1.ShipmentDate,
            t1.LoadingSequence 
        FROM
            dsd_m_shipmentheader AS t1        
        INNER JOIN
            dsd_t_shipmentheader AS t2          
                ON t1.shipmentno = t2.shipmentno                    
                AND t2.status = 'CHKO'        
        WHERE
            t1.Valid = 'True'
     ''';
    String date = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.YEAR_MONTH_DAY);
    SqlUtil.log(sql);
    List<ShipmentInfo> result = [];
    var db = Application.database.database;
    List<Map<String, dynamic>> list = await db.rawQuery(sql);
    for (Map<String, dynamic> map in list) {
      ShipmentInfo info = new ShipmentInfo();
      List values = map.values.toList();
      String dirty = values[3] ?? "";
      if (dirty == SyncDirtyStatus.SUCCESS || dirty == SyncDirtyStatus.FAIL || dirty == SyncDirtyStatus.EXIST) {
        info.isComplete = true;
      }
      info
        ..no = values[0]
        ..type = values[1]
        ..status = values[2]
        ..shipmentDate = values[4]
        ..sequence = values[5];
      result.add(info);
    }

    //将当天以前已经CheckIn的shipment过滤掉
    List<ShipmentInfo> checkInByLastList = await ShipmentManager.getShipmentHeaderByCheckInByLast();
    result.removeWhere((item){
      for(ShipmentInfo info in checkInByLastList){
        if(item.no == info.no){
          return true;
        }
      }
      return false;
    });
    return result;
  }

  static Future<List<BaseProductInfo>> getShipmentItemProductByNo(String shipmentNo) async {
    String sql = ''' 
            SELECT
            T1.ShipmentNo,
            T1.ProductCode,
            T1.ProductUnit,
            T1.PlanQty, 
            T2.Name,
            T3.Description,
            T2.ebMobile__Pack__c        
        FROM
            DSD_M_ShipmentItem AS T1    
        INNER JOIN 
            MD_Product AS T2 
              ON T1.ProductCode = T2.ProductCode     
        LEFT JOIN 
            MD_Dictionary AS T3 
              ON T3.Value = T2.ebMobile__Pack__c  
              and T3.Category = 'Pack'    
        WHERE
            T1.ShipmentNo = ?
        ORDER BY T2.ebMobile__Pack__c ASC,T1.ProductCode ASC 
     ''';

    SqlUtil.log(sql, [shipmentNo]);
    Map<String,BaseProductInfo> mapData = {};
    var db = Application.database.database;
    List<Map<String, dynamic>> list = await db.rawQuery(sql, [shipmentNo]);
    for (Map<String, dynamic> map in list) {
      List values = map.values.toList();
      String code = values[1];
      String unit = values[2];
      BaseProductInfo info = mapData[code];
      if(info == null) {
        info = new BaseProductInfo();
        mapData[code] = info;
        info.code = code;
        info.name = values[4];
        info.desc = values[5];
      }
      if(ProductUnit.CS == unit){
        info.plannedCs = int.tryParse(values[3]);
      }else if(ProductUnit.EA == unit){
        info.plannedEa = int.tryParse(values[3]);
      }
    }
    List<BaseProductInfo> result = [];
    result.addAll(mapData.values);
    return result;
  }


}
