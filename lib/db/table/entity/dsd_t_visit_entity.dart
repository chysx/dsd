import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:44

@Entity(tableName: "DSD_T_Visit")
class DSD_T_Visit_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String VisitId;
  String ShipmentNo;
  String StartTime;
  String EndTime;
  String UserCode;
  String AccountNumber;
  String Longitude;
  String Latitude;
  String CancelReason;
  String NoScanReason;
  String CreateUser;
  String CreateTime;
  String LastUpdateUser;
  String LastUpdateTime;
  String dirty;
  String isCompleted;

  DSD_T_Visit_Entity(this.id, this.VisitId, this.ShipmentNo, this.StartTime, this.EndTime, this.UserCode,
      this.AccountNumber, this.Longitude, this.Latitude, this.CancelReason, this.NoScanReason, this.CreateUser,
      this.CreateTime, this.LastUpdateUser, this.LastUpdateTime, this.dirty, this.isCompleted);

  DSD_T_Visit_Entity.Empty();

}
