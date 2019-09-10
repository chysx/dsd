import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:10

@Entity(tableName: "DSD_M_DeliveryItem")
class DSD_M_DeliveryItem_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String DeliveryNo;
  String ProductCode;
  String ProductUnit;
  String PlanQty;
  String TotalWeight;
  String WeightUnit;
  String BasePrice;
  String Tax;
  String Tax2;
  String NetPrice;
  String Deposit;
  String Discount;
  String IsFree;
  String ItemSequence;
  String ItemNumber;
  String ItemCategory;

  DSD_M_DeliveryItem_Entity(this.id, this.DeliveryNo, this.ProductCode, this.ProductUnit, this.PlanQty,
      this.TotalWeight, this.WeightUnit, this.BasePrice, this.Tax, this.Tax2, this.NetPrice, this.Deposit,
      this.Discount, this.IsFree, this.ItemSequence, this.ItemNumber, this.ItemCategory);

  DSD_M_DeliveryItem_Entity.Empty();

}
