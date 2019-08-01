import 'package:dsd/synchronization/sync/sync_dirty_status.dart';
import 'package:dsd/synchronization/sync/sync_file_status.dart';
import 'package:uuid/uuid.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/31 15:56

class SyncDownloadUtil {
  ///
  /// 数据下载时，为某些指定字段插入默认值
  ///
  /// @param tableName
  /// @return
  ///
  static Map<String, String> createContentValue(
      String tableName, bool isAddId) {
    Map<String, String> contentValues;
    Map<String, Map<String, String>> tableMap = getTableMap(isAddId);
    if (tableMap.containsKey(tableName)) {
      contentValues = new Map();
      Map<String, String> fieldMap = tableMap[tableName];
      for (MapEntry<String, String> entry in fieldMap.entries) {
        contentValues[entry.key] = entry.value;
      }
    }
    return contentValues;
  }

  static Map<String, Map<String, String>> getTableMap(bool isAddId) {
    Map<String, Map<String, String>> tableMap = new Map();

    tableMap["DSD_T_ShipmentHeader"] = getFieldMapByDirty();
    tableMap["DSD_T_ShipmentHelper"] = getFieldMapByIdOrDirty(isAddId);
    tableMap["DSD_T_ShipmentItem"] = getFieldMapByIdOrDirty(isAddId);
    tableMap["DSD_T_ShipmentFinance"] = getFieldMapByIdOrDirty(isAddId);

    tableMap["DSD_T_TruckStock"] = getFieldMapByIdOrDirty(isAddId);
    tableMap["DSD_T_TruckStockTracking"] = getFieldMapByDirty();

    tableMap["DSD_T_Visit"] = getFieldMapByIdOrDirty(isAddId);
    tableMap["DSD_T_DeliveryHeader"] = getFieldMapByIdOrDirty(isAddId);
    tableMap["DSD_T_DeliveryItem"] = getFieldMapByIdOrDirty(isAddId);
    tableMap["DSD_T_DeliveryBilling"] = getFieldMapByIdOrDirty(isAddId);

    tableMap["DSD_T_DayTimeTracking"] = getFieldMapByDirtyAndFileUploadFlag();

    tableMap["DSD_T_TruckCheckResult"] = getFieldMapByDirty();
    tableMap["DSD_T_ARCollection"] = getFieldMapByDirty();
    tableMap["DSD_M_ShipmentVanSalesRoute"] = getFieldMapByIdOrDirty(isAddId);

    tableMap["DSD_T_Order"] = getFieldMapByDirty();
    tableMap["DSD_T_OrderItem"] = getFieldMapByDirty();

    tableMap["MD_Person"] = getFieldMapById(isAddId);

    return tableMap;
  }

  static Map<String, String> getFieldMapById(bool isAddId) {
    Map<String, String> fieldMap = new Map();
    if (isAddId) {
      fieldMap["Id"] = new Uuid().v1();
    }
    return fieldMap;
  }

  static Map<String, String> getFieldMapByIdOrDirty(bool isAddId) {
    Map<String, String> fieldMap = new Map();
    if (isAddId) {
      fieldMap["Id"] = new Uuid().v1();
    }
    fieldMap["dirty"] = SyncDirtyStatus.EXIST;
    return fieldMap;
  }

  static Map<String, String> getFieldMapByDirtyAndFileUploadFlag() {
    Map<String, String> fieldMap = new Map();
    fieldMap["dirty"] = SyncDirtyStatus.EXIST;
    fieldMap["file_upload_flag"] = SyncFileStatus.EXIST;
    return fieldMap;
  }

  static Map<String, String> getFieldMapByDirty() {
    Map<String, String> fieldMap = new Map();
    fieldMap["dirty"] = SyncDirtyStatus.EXIST;
    return fieldMap;
  }
}
