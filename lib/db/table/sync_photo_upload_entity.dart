import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 15:26

@Entity(tableName: "sync_photo_upload")
class SyncPhotoUploadEntity {
  @primaryKey
  String id;
  String filePath;
  String name;
  String type;
  String status;
  String time;

  SyncPhotoUploadEntity(this.id, this.filePath, this.name, this.type, this.status, this.time);


}
