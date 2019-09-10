import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:38

@Entity(tableName: "DSD_T_ShipmentItem")
class DSD_T_ShipmentItem_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String HeaderId;
  String ProductCode;
  String ProductUnit;
  int PlanQty;
  int ActualQty;
  int DifferenceQty;
  String DifferenceReason;
  String CreateUser;
  String CreateTime;
  String LastUpdateUser;
  String LastUpdateTime;
  String dirty;

  DSD_T_ShipmentItem_Entity(this.id, this.HeaderId, this.ProductCode, this.ProductUnit, this.PlanQty, this.ActualQty,
      this.DifferenceQty, this.DifferenceReason, this.CreateUser, this.CreateTime, this.LastUpdateUser,
      this.LastUpdateTime, this.dirty);

  DSD_T_ShipmentItem_Entity.Empty();

}
