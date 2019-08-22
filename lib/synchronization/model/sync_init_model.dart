import 'package:dio/dio.dart';
import 'package:dsd/db/database.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/utils/device_info.dart';
import 'package:dsd/synchronization/base/abstract_sync_download_model.dart';
import 'package:dsd/synchronization/bean/table_key_bean.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite/sqlite_api.dart' as sqlite_api;

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/31 17:32

class SyncInitModel extends AbstractSyncDownloadModel {
  SyncInitModel(SyncType syncType, {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync})
      : super(syncType, syncParameter: syncParameter, onSuccessSync: onSuccessSync, onFailSync: onFailSync);

  @override
  Future<Observable<Response<Map<String, dynamic>>>> prepare() async {
    await clearDB();
    await initDownloadLogic();
    return super.prepare();
  }

  List<String> getTableNameNotClear() {
    List<String> tableList = new List();
    tableList.add('app_config');
    tableList.add('app_log');
    return tableList;
  }

  Future clearDB() async {
    sqflite.DatabaseExecutor sqfliteDb = DbHelper().database.database;
    sqlite_api.Database database = sqfliteDb as sqlite_api.Database;
    List<Map<String, dynamic>> list =
        await database.rawQuery("select name from sqlite_master where type = 'table' and name not like '%metadata%'");
    await database.transaction((txn) async {
      List<String> tableNameNotClear = getTableNameNotClear();
      for (Map<String, dynamic> map in list) {
        if (!tableNameNotClear.contains(map["name"])) {
          await txn.delete(map["name"]);
        }
      }
    });
  }

  Future initDownloadLogic() async {
    sqflite.DatabaseExecutor sqfliteDb = DbHelper().database.database;
    sqlite_api.Database database = sqfliteDb as sqlite_api.Database;
    await database.transaction((txn) async {
      int index = 0;
      for (TableKeyBean tableKeyBean in _getTableKeyList()) {
        Map<String, String> values = new Map();
        values["tableName"] = tableKeyBean.name;
        values["tableOrder"] = (++index).toString();
        values["timeStamp"] = null;
        values["version"] = DeviceInfo().versionName;
        values["isActive"] = "1";
        values["transferred"] = "1";
        values["keys"] = tableKeyBean.getKeysStr();
        await txn.insert("sync_download_logic", values);
      }
    });
  }

  @override
  List<String> getTableDownloadList() {
    return null;
  }

  @override
  bool isAllDataAndAllInsert(String tableName) {
    return true;
  }

  List<TableKeyBean> _getTableKeyList() {
    List<TableKeyBean> tableKeyBeanList = new List();
    tableKeyBeanList.add(new TableKeyBean("MD_Product", ["ProductCode"]));
    tableKeyBeanList.add(new TableKeyBean("MD_Dictionary", ["id"]));
    tableKeyBeanList.add(new TableKeyBean("MD_Person", ["UserCode"]));
    tableKeyBeanList.add(new TableKeyBean("MD_Contact", ["AccountNumber__c"]));
    tableKeyBeanList.add(new TableKeyBean("MD_Account", ["AccountNumber"]));

    tableKeyBeanList.add(new TableKeyBean("DSD_M_SystemConfig", ["Category", "KeyName"]));

    tableKeyBeanList.add(new TableKeyBean("DSD_M_ShipmentHeader", ["ShipmentNo"]));
    tableKeyBeanList.add(new TableKeyBean("DSD_M_ShipmentItem", ["ShipmentNo", "ProductCode", "ProductUnit"]));

    tableKeyBeanList.add(new TableKeyBean("DSD_T_ShipmentHeader", ["id"]));
    tableKeyBeanList.add(new TableKeyBean("DSD_T_ShipmentItem", ["HeaderId", "ProductCode", "ProductUnit"]));

    tableKeyBeanList.add(new TableKeyBean("DSD_T_TruckStock", ["TruckId", "ShipmentNo", "ProductCode", "ProductUnit"]));
    tableKeyBeanList.add(new TableKeyBean("DSD_T_TruckStockTracking", ["id"]));

    tableKeyBeanList.add(new TableKeyBean("DSD_M_Truck", ["id"]));
    tableKeyBeanList.add(new TableKeyBean("DSD_M_DeliveryHeader", ["DeliveryNo"]));
    tableKeyBeanList.add(new TableKeyBean("DSD_M_DeliveryItem", ["DeliveryNo", "ProductCode", "ProductUnit","ItemSequence"]));

    tableKeyBeanList.add(new TableKeyBean("DSD_T_Visit", ["VisitId"]));
    tableKeyBeanList.add(new TableKeyBean("DSD_T_DeliveryHeader", ["DeliveryNo"]));
    tableKeyBeanList.add(new TableKeyBean("DSD_T_DeliveryItem", ["DeliveryNo", "ProductCode", "ProductUnit","ItemSequence"]));
    return tableKeyBeanList;
  }
}
