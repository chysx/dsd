import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 15:19

@Entity(tableName: "app_log")
class AppLogEntity {
  @primaryKey
  String id;
  String versionName;
  String device;
  String type;
  String content;
  String stackTrace;
  String time;
  String note;
  String dirty;

  AppLogEntity(
      [this.id,
      this.versionName,
      this.device,
      this.type,
      this.content,
      this.stackTrace,
      this.time,
      this.note,
      this.dirty]);

  @override
  String toString() {
    return 'AppLogEntity{id: $id, versionName: $versionName, device: $device, type: $type, content: $content, stackTrace: $stackTrace, time: $time, note: $note, dirty: $dirty}';
  }
}
