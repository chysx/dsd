import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:33

@Entity(tableName: "DSD_T_ShipmentHeader")
class DSD_T_ShipmentHeader_Entity {
  @PrimaryKey(autoGenerate: true)
  int pid;
  String Id;
  String ShipmentNo;
  String ShipmentDate;
  String ShipmentType;
  String ActionType;
  String StartTime;
  String EndTime;
  int Odometer;
  String Checker;
  int CheckerConfirm;
  String CheckerConfirmTime;
  String CheckerSignImg;
  String DCheckerSignImg;
  String Cashier;
  int CashierConfirm;
  String CashierConfirmTime;
  String CashierSignImg;
  String DCashierSignImg;
  String Gatekeeper;
  int GKConfirm;
  String GKConfirmTime;
  String GKSignImg;
  String DGKSignImg;
  String WarehouseCode;
  String Status;
  String Driver;
  int TruckId;
  String TotalAmount;
  String TotalWeight;
  String WeightUnit;
  String CreateUser;
  String CreateTime;
  String LastUpdateUser;
  String LastUpdateTime;
  String ScanResult;
  String Manually;
  String dirty;

  DSD_T_ShipmentHeader_Entity(this.pid, this.Id, this.ShipmentNo, this.ShipmentDate, this.ShipmentType, this.ActionType,
      this.StartTime, this.EndTime, this.Odometer, this.Checker, this.CheckerConfirm, this.CheckerConfirmTime,
      this.CheckerSignImg, this.DCheckerSignImg, this.Cashier, this.CashierConfirm, this.CashierConfirmTime,
      this.CashierSignImg, this.DCashierSignImg, this.Gatekeeper, this.GKConfirm, this.GKConfirmTime, this.GKSignImg,
      this.DGKSignImg, this.WarehouseCode, this.Status, this.Driver, this.TruckId, this.TotalAmount, this.TotalWeight,
      this.WeightUnit, this.CreateUser, this.CreateTime, this.LastUpdateUser, this.LastUpdateTime, this.ScanResult,
      this.Manually, this.dirty);

  DSD_T_ShipmentHeader_Entity.Empty();

}
