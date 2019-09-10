import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:42

@Entity(tableName: "DSD_T_TruckStockTracking")
class DSD_T_TruckStockTracking_Entity {
  @PrimaryKey(autoGenerate: true)
  int pid;
  String Id;
  String VisitId;
  int TruckId;
  String ShipmentNo;
  String TrackingTime;
  String ProductCode;
  String ProductUnit;
  String ChangeAction;
  int ChangeQuantity;
  int FromQty;
  int ToQty;
  String CreateUser;
  String CreateTime;
  String LastUpdateUser;
  String LastUpdateTime;
  String dirty;

  DSD_T_TruckStockTracking_Entity(this.pid, this.Id, this.VisitId, this.TruckId, this.ShipmentNo, this.TrackingTime,
      this.ProductCode, this.ProductUnit, this.ChangeAction, this.ChangeQuantity, this.FromQty, this.ToQty,
      this.CreateUser, this.CreateTime, this.LastUpdateUser, this.LastUpdateTime, this.dirty);

  DSD_T_TruckStockTracking_Entity.Empty();

}
