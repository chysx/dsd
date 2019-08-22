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
  static Map<String, String> createContentValue(String tableName, bool isAddId) {
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
    tableMap["DSD_T_ShipmentHelper"] = getFieldMapByDirty();
    tableMap["DSD_T_ShipmentItem"] = getFieldMapByDirty();
    tableMap["DSD_T_ShipmentFinance"] = getFieldMapByDirty();

    tableMap["DSD_T_TruckStock"] = getFieldMapByDirty();
    tableMap["DSD_T_TruckStockTracking"] = getFieldMapByDirty();

    tableMap["DSD_T_Visit"] = getFieldMapByDirty();
    tableMap["DSD_T_DeliveryHeader"] = getFieldMapByDirty();
    tableMap["DSD_T_DeliveryItem"] = getFieldMapByDirty();

    tableMap["DSD_T_Order"] = getFieldMapByDirty();
    tableMap["DSD_T_OrderItem"] = getFieldMapByDirty();

    return tableMap;
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
