import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:19

@Entity(tableName: "DSD_M_ShipmentItem")
class DSD_M_ShipmentItem_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String ShipmentNo;
  String ProductCode;
  String ProductUnit;
  String PlanQty;

  DSD_M_ShipmentItem_Entity(this.id, this.ShipmentNo, this.ProductCode, this.ProductUnit, this.PlanQty);

  DSD_M_ShipmentItem_Entity.Empty();

}
