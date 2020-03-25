import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/1 10:12

@Entity(tableName: "MD_Person")
class MD_Person_Entity {
  @PrimaryKey(autoGenerate: true)
  int pid;
  String Id;
  String UserCode;
  String Password;
  String FirstName;
  String LastName;
  String Type;
  String RouteNumber;

  MD_Person_Entity(this.pid,this.Id, this.UserCode, this.Password, this.FirstName, this.LastName, this.Type, this.RouteNumber);

  @override
  String toString() {
    return 'MD_Person_Entity{pid: $pid,Id: $Id, UserCode: $UserCode, Password: $Password, FirstName: $FirstName, LastName: $LastName, Type: $Type, RouteNumber: $RouteNumber}';
  }

  MD_Person_Entity.Empty();
}
