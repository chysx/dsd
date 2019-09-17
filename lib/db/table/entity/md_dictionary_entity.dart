import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:46

@Entity(tableName: "MD_Dictionary")
class MD_Dictionary_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String Category;
  String Value;
  String Description;
  String Valid;
  int Sequence;

  MD_Dictionary_Entity(this.id, this.Category, this.Value, this.Description, this.Valid, this.Sequence);

  MD_Dictionary_Entity.Empty();

}
