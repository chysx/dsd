import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:40

@Entity(tableName: "DSD_T_TruckStock")
class DSD_T_TruckStock_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  int TruckId;
  String ShipmentNo;
  String ProductCode;
  String ProductUnit;
  int StockQty;
  int SaleableQty;
  String CreateUser;
  String CreateTime;
  String LastUpdateUser;
  String LastUpdateTime;
  String dirty;

  DSD_T_TruckStock_Entity(this.id, this.TruckId, this.ShipmentNo, this.ProductCode, this.ProductUnit, this.StockQty,
      this.SaleableQty, this.CreateUser, this.CreateTime, this.LastUpdateUser, this.LastUpdateTime, this.dirty);

  DSD_T_TruckStock_Entity.Empty();

}
