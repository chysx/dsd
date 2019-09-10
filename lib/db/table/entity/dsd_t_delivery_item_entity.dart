import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:30

@Entity(tableName: "DSD_T_DeliveryItem")
class DSD_T_DeliveryItem_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String DeliveryNo;
  String ProductCode;
  String ProductUnit;
  String PlanQty;
  String ActualQty;
  String DifferenceQty;
  String Reason;
  String BasePrice;
  String Tax;
  String Tax2;
  String Discount;
  String NetPrice;
  String Deposit;
  String IsReturn;
  String CreateUser;
  String CreateTime;
  String LastUpdateUser;
  String LastUpdateTime;
  String IsFree;
  String ItemSequence;
  String ItemNumber;
  String ItemCategory;
  String dirty;

  DSD_T_DeliveryItem_Entity(this.id, this.DeliveryNo, this.ProductCode, this.ProductUnit, this.PlanQty, this.ActualQty,
      this.DifferenceQty, this.Reason, this.BasePrice, this.Tax, this.Tax2, this.Discount, this.NetPrice,
      this.Deposit, this.IsReturn, this.CreateUser, this.CreateTime, this.LastUpdateUser, this.LastUpdateTime,
      this.IsFree, this.ItemSequence, this.ItemNumber, this.ItemCategory, this.dirty);

  DSD_T_DeliveryItem_Entity.Empty();

}
