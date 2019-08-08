import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 14:41

@Entity(tableName: "sync_download_logic")
class SyncDownloadLogicEntity {
  @primaryKey
  String tableName;
  String tableOrder;
  String timeStamp;
  String version;
  String isActive;
  String transferred;
  String keys;

  SyncDownloadLogicEntity(
      [this.tableName, this.tableOrder, this.timeStamp, this.version, this.isActive, this.transferred, this.keys]);

  @override
  String toString() {
    return 'SyncDownloadLogicEntity{tableName: $tableName, tableOrder: $tableOrder, timeStamp: $timeStamp, version: $version, isActive: $isActive, transferred: $transferred, keys: $keys}';
  }
}
