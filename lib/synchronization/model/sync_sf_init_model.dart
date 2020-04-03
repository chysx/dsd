import 'package:dio/dio.dart';
import 'package:dsd/db/database.dart';
import 'package:dsd/synchronization/base/abstract_sync_sf_download_model.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
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

class SyncInitSfModel extends AbstractSyncSfDownloadModel {
  SyncInitSfModel(SyncType syncType, {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync})
      : super(syncType, syncParameter: syncParameter, onSuccessSync: onSuccessSync, onFailSync: onFailSync);

  @override
  Future<Observable<Response<Map<String, dynamic>>>> prepare() async {
    await clearDB();
    return super.prepare();
  }

  List<String> getTableNameClear() {
    List<String> tableList = new List();
    tableList.add('sync_download_logic');
    tableList.add('sync_photo_upload');
    tableList.add('sync_upload');

    tableList.add('DSD_T_ShipmentHeader');
    tableList.add('DSD_T_ShipmentItem');
    tableList.add('DSD_T_DeliveryHeader');
    tableList.add('DSD_T_DeliveryItem');
    tableList.add('DSD_T_Visit');
    tableList.add('DSD_T_TruckStock');
    tableList.add('DSD_T_TruckStockTracking');
    return tableList;
  }

  Future clearDB() async {
    sqflite.DatabaseExecutor sqfliteDb = DbHelper().database.database;
    sqlite_api.Database database = sqfliteDb as sqlite_api.Database;
    await database.transaction((txn) async {
      List<String> tableNameList = getTableNameClear();
      for (String table in tableNameList) {
        await txn.delete(table);
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

}
