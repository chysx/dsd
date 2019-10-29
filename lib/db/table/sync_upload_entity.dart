import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 15:24

@Entity(tableName: "sync_upload")
class SyncUploadEntity {
  @primaryKey
  String id;
  String uniqueIdValues;
  String name;
  String type;
  String status;
  String time;

  SyncUploadEntity(this.id, this.uniqueIdValues, this.name, this.type, this.status, this.time);

  SyncUploadEntity.Empty();

}
