import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:21

@Entity(tableName: "DSD_M_SystemConfig")
class DSD_M_SystemConfig_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String Category;
  String KeyName;
  String Description;
  String Value;
  String Valid;

  DSD_M_SystemConfig_Entity(this.id, this.Category, this.KeyName, this.Description, this.Value, this.Valid);

  DSD_M_SystemConfig_Entity.Empty();

}
