import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:14

@Entity(tableName: "DSD_M_ShipmentHeader")
class DSD_M_ShipmentHeader_Entity {
  @PrimaryKey(autoGenerate: true)
  int pid;
  String Id;
  String ShipmentNo;
  String ShipmentDate;
  String ShipmentType;
  String Route;
  String Description;
  String ReleaseStatus;
  String ReleaseUser;
  String ReleaseTime;
  String CompletionStatus;
  String CompletionTime;
  String Driver1;
  String Driver2;
  String TruckId;
  String TruckCode;
  String TruckType;
  String LoadingSequence;
  String WarehouseCode;
  String OutWarehouse;
  int TotalProductQty;
  String TotalItemAmount;
  String TotalWeight;
  String WeightUnit;
  String DataSource;
  String Valid;

  DSD_M_ShipmentHeader_Entity(this.pid,this.Id, this.ShipmentNo, this.ShipmentDate, this.ShipmentType, this.Route,
      this.Description, this.ReleaseStatus, this.ReleaseUser, this.ReleaseTime, this.CompletionStatus,
      this.CompletionTime, this.Driver1, this.Driver2, this.TruckId, this.TruckCode, this.TruckType,
      this.LoadingSequence, this.WarehouseCode, this.OutWarehouse, this.TotalProductQty, this.TotalItemAmount,
      this.TotalWeight, this.WeightUnit, this.DataSource, this.Valid);

  DSD_M_ShipmentHeader_Entity.Empty();

}
