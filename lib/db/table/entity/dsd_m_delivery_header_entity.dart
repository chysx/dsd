import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/1 10:12

//@Entity(tableName: "DSD_M_DeliveryHeader")
class DSD_M_DeliveryHeader_Entity {
//  @PrimaryKey(autoGenerate: true)
  int id;
  String DeliveryNo;
  String ShipmentNo;
  String DeliveryType;
  String DeliveryStatus;
  String AccountNumber;
  String OrderNo;
  String InvoiceNo;
  String PONumber;
  String OrderDate;
  String PlanDeliveryDate;
  String SalesRep;
  String CompanyCode;
  String SalesOrg;
  String SalesOff;
  String PaymentType;
  String Currency;
  String PlanDeliveryQty;
  String DeliveryAddress;
  String Contact;
  String Telephone;
  String BasePrice;
  String Tax;
  String Tax2;
  String NetPrice;
  String Deposit;
  String DataSource;
  String DeliveryNote;
  String Discount;
  String MarketDeveloper;
  String DeliverySequence;
  String DeliveryTimeSlotFrom;
  String DeliveryTimeSlotTo;
  String OnlineDiscount;
  String OtherDiscount;
  String APDiscount;

  DSD_M_DeliveryHeader_Entity(this.id, this.DeliveryNo, this.ShipmentNo, this.DeliveryType, this.DeliveryStatus,
      this.AccountNumber, this.OrderNo, this.InvoiceNo, this.PONumber, this.OrderDate, this.PlanDeliveryDate,
      this.SalesRep, this.CompanyCode, this.SalesOrg, this.SalesOff, this.PaymentType, this.Currency,
      this.PlanDeliveryQty, this.DeliveryAddress, this.Contact, this.Telephone, this.BasePrice, this.Tax, this.Tax2,
      this.NetPrice, this.Deposit, this.DataSource, this.DeliveryNote, this.Discount, this.MarketDeveloper,
      this.DeliverySequence, this.DeliveryTimeSlotFrom, this.DeliveryTimeSlotTo, this.OnlineDiscount,
      this.OtherDiscount, this.APDiscount);

  DSD_M_DeliveryHeader_Entity.Empty();

}
