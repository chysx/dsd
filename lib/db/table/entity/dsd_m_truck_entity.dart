import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:23

@Entity(tableName: "DSD_M_Truck")
class DSD_M_Truck_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String TruckCode;
  String Type;
  double Capacity;
  double Volume;
  String VolumeUnit;
  String CompanyCode;
  String SalesOrg;
  String SalesOff;
  String Status;

  DSD_M_Truck_Entity(this.id, this.TruckCode, this.Type, this.Capacity, this.Volume, this.VolumeUnit, this.CompanyCode,
      this.SalesOrg, this.SalesOff, this.Status);

  DSD_M_Truck_Entity.Empty();

}
