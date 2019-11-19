import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:26

@Entity(tableName: "DSD_T_DeliveryHeader")
class DSD_T_DeliveryHeader_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String DeliveryNo;
  String VisitId;
  String ShipmentNo;
  String DeliveryType;
  String DeliveryStatus;
  String AccountNumber;
  String OrderNo;
  String InvoiceNo;
  String PONumber;
  String OrderDate;
  String ActualDeliveryDate;
  String Currency;
  String CustomerSignStatus;
  String CustomerSignDate;
  String CustomerSignImg;
  String DriverSignStatus;
  String DriverSignDate;
  String DriverSignImg;
  String StartTime;
  String EndTime;
  String BasePrice;
  String Tax;
  String Tax2;
  String Discount;
  String NetPrice;
  String Deposit;
  String ActualPayment;
  String ActualDeposit;
  String CancelTime;
  String CancelReason;
  String Rebook;
  String DeliveryNote;
  String CreateUser;
  String CreateTime;
  String LastUpdateUser;
  String LastUpdateTime;
  String MarketDeveloper;
  String CustomerNot;
  String PickupEmpties__c;
  String EmptyRefund__c;
  String dirty;


  DSD_T_DeliveryHeader_Entity(this.id, this.DeliveryNo, this.VisitId, this.ShipmentNo, this.DeliveryType,
      this.DeliveryStatus, this.AccountNumber, this.OrderNo, this.InvoiceNo, this.PONumber, this.OrderDate,
      this.ActualDeliveryDate, this.Currency, this.CustomerSignStatus, this.CustomerSignDate, this.CustomerSignImg,
      this.DriverSignStatus, this.DriverSignDate, this.DriverSignImg, this.StartTime, this.EndTime, this.BasePrice,
      this.Tax, this.Tax2, this.Discount, this.NetPrice, this.Deposit, this.ActualPayment, this.ActualDeposit,
      this.CancelTime, this.CancelReason, this.Rebook, this.DeliveryNote, this.CreateUser, this.CreateTime,
      this.LastUpdateUser, this.LastUpdateTime, this.MarketDeveloper, this.CustomerNot,this.PickupEmpties__c,
      this.EmptyRefund__c, this.dirty);

  DSD_T_DeliveryHeader_Entity.Empty();

}
