import 'package:dsd/application.dart';
import 'package:dsd/db/table/entity/dsd_t_visit_entity.dart';
import 'package:dsd/db/table/sync_upload_entity.dart';
import 'package:dsd/synchronization/base/abstract_sync_sf_download_model.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/19 10:48

class SyncSfUpdateModel extends AbstractSyncSfDownloadModel {
  SyncSfUpdateModel(SyncType syncType, {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync})
      : super(syncType, syncParameter: syncParameter, onSuccessSync: onSuccessSync, onFailSync: onFailSync);

  @override
  List<String> getTableDownloadList() {
    return null;
  }

  @override
  bool isAllDataAndAllInsert(String tableName) {
    if(tableName.toLowerCase() == 'MD_Account'.toLowerCase() ||
        tableName.toLowerCase() == 'MD_Contact'.toLowerCase()){
      return true;
    }
    return false;
  }

  @override
  Future onSuccess() async {
    super.onSuccess();
    List<SyncUploadEntity> syncUploadEntityList = await Application.database.syncUploadDao.findEntityByType(SyncType.SYNC_UPLOAD_VISIT_SF.toString());
    List<SyncUploadEntity> resultList = [];
    for(SyncUploadEntity entity in syncUploadEntityList){
      DSD_T_Visit_Entity visit = await Application.database.tVisitDao.findEntityByGuid(entity.uniqueIdValues);
      if(visit != null){
        entity.uniqueIdValues = visit.Id;
        resultList.add(entity);
      }
    }
    await Application.database.syncUploadDao.deleteEntity(resultList);
    await Application.database.syncUploadDao.insertEntityList(resultList);
  }

//  static Map<String,List<String>> updateMap = {
//    "DSD_M_ShipmentHeader": ["ShipmentNo"],
//    "DSD_M_ShipmentItem": ["ShipmentNo", "ProductCode", "ProductUnit"],
//    "DSD_T_ShipmentHeader": ["id"],
//    "DSD_T_ShipmentItem": ["HeaderId", "ProductCode", "ProductUnit"],
//    "DSD_M_DeliveryHeader": ["DeliveryNo"],
//    "DSD_M_DeliveryItem": ["DeliveryNo", "ProductCode", "ProductUnit","ItemSequence"],
//    "DSD_T_DeliveryHeader": ["DeliveryNo"],
//    "DSD_T_DeliveryItem": ["DeliveryNo", "ProductCode", "ProductUnit","ItemSequence"],
//    "DSD_T_Visit": ["VisitId"],
//    "DSD_T_TruckStock": ["TruckId", "ShipmentNo", "ProductCode", "ProductUnit"],
//    "DSD_T_TruckStockTracking": ["id"]
//  };

  static Map<String,List<String>> updateMap = {
    "DSD_M_ShipmentHeader": ["Id"],
    "DSD_M_ShipmentItem": ["Id"],
    "DSD_M_DeliveryHeader": ["Id"],
    "DSD_M_DeliveryItem": ["Id"],
    "DSD_T_ShipmentHeader": ["GUID"],
    "DSD_T_ShipmentItem": ["GUID"],
    "DSD_T_DeliveryHeader": ["GUID"],
    "DSD_T_DeliveryItem": ["GUID"],
    "DSD_T_Visit": ["GUID"],
    "DSD_T_TruckStock": ["GUID"],
    "DSD_T_TruckStockTracking": ["GUID"]
  };


}