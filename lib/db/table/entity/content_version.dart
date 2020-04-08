import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:29

@Entity(tableName: "ContentVersion")
class ContentVersionEntity {
  @PrimaryKey(autoGenerate: true)
  int pid;
  String Id;
  String Title;
  String PathOnClient;
  String ParentId__c;
  String VersionData;
  String dirty;


  ContentVersionEntity(this.pid, this.Id, this.Title,
      this.PathOnClient, this.ParentId__c, this.VersionData, this.dirty);

  ContentVersionEntity.Empty();


}
