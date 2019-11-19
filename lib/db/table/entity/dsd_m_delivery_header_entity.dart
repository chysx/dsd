import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/1 10:12

@Entity(tableName: "DSD_M_DeliveryHeader")
class DSD_M_DeliveryHeader_Entity {
  @PrimaryKey(autoGenerate: true)
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
  String PickupEmpties__c;
  String EmptyRefund__c;
  String ArrivalTime__c;
  String FinishTime__c;


  DSD_M_DeliveryHeader_Entity(this.id, this.DeliveryNo, this.ShipmentNo, this.DeliveryType, this.DeliveryStatus,
      this.AccountNumber, this.OrderNo, this.InvoiceNo, this.PONumber, this.OrderDate, this.PlanDeliveryDate,
      this.SalesRep, this.CompanyCode, this.SalesOrg, this.SalesOff, this.PaymentType, this.Currency,
      this.PlanDeliveryQty, this.DeliveryAddress, this.Contact, this.Telephone, this.BasePrice, this.Tax, this.Tax2,
      this.NetPrice, this.Deposit, this.DataSource, this.DeliveryNote, this.Discount, this.MarketDeveloper,
      this.DeliverySequence, this.DeliveryTimeSlotFrom, this.DeliveryTimeSlotTo, this.OnlineDiscount,
      this.OtherDiscount, this.APDiscount,this.PickupEmpties__c,this.EmptyRefund__c,this.ArrivalTime__c,this.FinishTime__c);


  static Map<String, dynamic> toJson(
      DSD_M_DeliveryHeader_Entity instance) =>
      <String, dynamic>{
        'id': instance.id,
        'DeliveryNo': instance.DeliveryNo,
        'ShipmentNo': instance.ShipmentNo,
        'DeliveryType': instance.DeliveryType,
        'DeliveryStatus': instance.DeliveryStatus,
        'AccountNumber': instance.AccountNumber,
        'OrderNo': instance.OrderNo,
        'InvoiceNo': instance.InvoiceNo,
        'PONumber': instance.PONumber,
        'OrderDate': instance.OrderDate,
        'PlanDeliveryDate': instance.PlanDeliveryDate,
        'SalesRep': instance.SalesRep,
        'CompanyCode': instance.CompanyCode,
        'SalesOrg': instance.SalesOrg,
        'SalesOff': instance.SalesOff,
        'PaymentType': instance.PaymentType,
        'Currency': instance.Currency,
        'PlanDeliveryQty': instance.PlanDeliveryQty,
        'DeliveryAddress': instance.DeliveryAddress,
        'Contact': instance.Contact,
        'Telephone': instance.Telephone,
        'BasePrice': instance.BasePrice,
        'Tax': instance.Tax,
        'Tax2': instance.Tax2,
        'NetPrice': instance.NetPrice,
        'DataSource': instance.DataSource,
        'DeliveryNote': instance.DeliveryNote,
        'MarketDeveloper': instance.MarketDeveloper,
        'DeliverySequence': instance.DeliverySequence,
        'DeliveryTimeSlotFrom': instance.DeliveryTimeSlotFrom,
        'DeliveryTimeSlotTo': instance.DeliveryTimeSlotTo,
        'OnlineDiscount': instance.OnlineDiscount,
        'OtherDiscount': instance.OtherDiscount,
        'APDiscount': instance.APDiscount,
        'PickupEmpties__c': instance.PickupEmpties__c,
        'EmptyRefund__c': instance.EmptyRefund__c,
        'ArrivalTime__c': instance.ArrivalTime__c,
        'FinishTime__c': instance.FinishTime__c,
      };

  DSD_M_DeliveryHeader_Entity.Empty();

}
