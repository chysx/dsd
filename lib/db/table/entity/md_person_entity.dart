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
  int id;
  String UserCode;
  String Password;
  String FirstName;
  String LastName;
  String Type;
  String RouteNumber;

  MD_Person_Entity(this.id, this.UserCode, this.Password, this.FirstName, this.LastName, this.Type, this.RouteNumber);

  @override
  String toString() {
    return 'MD_Person_Entity{id: $id, UserCode: $UserCode, Password: $Password, FirstName: $FirstName, LastName: $LastName, Type: $Type, RouteNumber: $RouteNumber}';
  }

  MD_Person_Entity.Empty();
}
