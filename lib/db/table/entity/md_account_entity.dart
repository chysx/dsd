import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:55

@Entity(tableName: "MD_Account")
class MD_Account_Entity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String Name;
  String AccountNumber;
  String Owner;
  String RecordType;
  String Site;
  String AccountSource;
  String AnnualRevenue;
  String BillingAddress;
  String CreatedBy;
  String Jigsaw;
  String Description;
  String NumberOfEmployees;
  String Fax;
  String Industry;
  String LastModifiedBy;
  String Ownership;
  String Parent;
  String Phone;
  String Rating;
  String ShippingAddress;
  String Sic;
  String SicDesc;
  String TickerSymbol;
  String Type;
  String Website;
  String ebMobile__AccountGroup__c;
  String ebMobile__AccountName1__c;
  String ebMobile__AccountName2__c;
  String ebMobile__AccountPartner__c;
  String ebMobile__AccountPhotoId__c;
  String ebMobile__ActivationDate__c;
  String ebMobile__IsActive__c;
  String ebMobile__Address__c;
  String ebMobile__ApprovalStepsDate__c;
  String ebMobile__BillTo__c;
  String ebMobile__BlockByCredit__c;
  String ebMobile__DeliveryType__c;
  String ebMobile__BusinessTypeExtension__c;
  String ebMobile__CallFrequency__c;
  String CallFrequencyCode__c;
  String ebMobile__Category__c;
  String ebMobile__IsChangeByInterface__c;
  String ebMobile__CityCode__c;
  String ebMobile__Segment__c;
  String ebMobile__CloseDay__c;
  String ebMobile__ClosingTime__c;
  String ebMobile__Company__c;
  String ebMobile__CompanyCode__c;
  String ebMobile__CompanyDeleteFlag__c;
  String ebMobile__ContactEmail__c;
  String ebMobile__ContactMobile__c;
  String ebMobile__ContactPersonFunction__c;
  String ebMobile__ContactPersonName__c;
  String ebMobile__ContactPhone__c;
  String ebMobile__Country__c;
  String ebMobile__CountryCode__c;
  String ebMobile__CountryKey__c;
  String ebMobile__CreditDays__c;
  String ebMobile__AvailableBalance__c;
  String ebMobile__CreditLimit__c;
  String ebMobile__Currency__c;
  String ebMobile__CustomerConditionGroup__c;
  String ebMobile__DeliveringPlant__c;
  String ebMobile__DeliveryDate__c;
  String ebMobile__DeliveryDays__c;
  String ebMobile__DiscountIndicator__c;
  String ebMobile__DistributionChannel__c;
  String ebMobile__Distributor__c;
  String ebMobile__District__c;
  String ebMobile__Division__c;
  String ebMobile__ERPAccountNumber__c;
  String ExecuteBatchFlag__c;
  String ebMobile__GeoCode__c;
  String ebMobile__GUID__c;
  String HasUpdatedAR__c;
  String ebMobile__HouseNumber__c;
  String ebMobile__InvestmentValue__c;
  String ebMobile__InvoiceCalendar__c;
  String IsPush__c;
  String ebMobile__KeyAccount__c;
  String KeyAccount__c;
  String Last3MonthsVolume__c;
  String ebMobile__Last3MonthsVolume__c;
  String ebMobile__LastCallDate__c;
  String ebMobile__LastOrderDate__c;
  String ebMobile__LastOrderTotalPrice__c;
  String ebMobile__LastOrderTotalQuantity__c;
  String ebMobile__MEPCustomerNumber__c;
  String ebMobile__OpeningTime__c;
  String ebMobile__OpenItemsAgingStart__c;
  String ebMobile__OperationalMarketType__c;
  String ebMobile__OperationalTradeChannel__c;
  String ebMobile__OrderBlock__c;
  String ebMobile__Owner_Role__c;
  String ebMobile__P3MAVGSales__c;
  String ebMobile__PartnerFunction__c;
  String ebMobile__Payer__c;
  String ebMobile__PaymentTerms__c;
  String ebMobile__PONumber__c;
  String ebMobile__Postal__c;
  String ebMobile__PriceAttribute__c;
  String ebMobile__PriceClassID__c;
  String ebMobile__PriceGroup__c;
  String ebMobile__PriceListType__c;
  String ebMobile__PricingProcedure__c;
  String ebMobile__RecordAction__c;
  String ebMobile__RecordTypeName__c;
  String RedIndecator__c;
  String ebMobile__Region__c;
  String ebMobile__RegistrationNumber__c;
  String ebMobile__SalesDistrict__c;
  String ebMobile__SaleGroup__c;
  String ebMobile__SalesOffice__c;
  String ebMobile__SalesOrg__c;
  String ebMobile__SalesOrgCode__c;
  String ebMobile__User__c;
  String ebMobile__SalesRoute__c;
  String ebMobile__ShippingCondition__c;
  String ShippingConditionCode__c;
  String ebMobile__ShipTo__c;
  String ebMobile__State__c;
  String ebMobile__Street__c;
  String ebMobile__Street4__c;
  String ebMobile__Street5__c;
  String ebMobile__StreetNumber__c;
  String ebMobile__SubTradeChannel__c;
  String ebMobile__SuppressionReason__c;
  String ebMobile__SuspressionCode__c;
  String ebMobile__SuspressionDate__c;
  String ebMobile__TargetGroup__c;
  String ebMobile__TaxCode__c;
  String ebMobile__TaxNumber__c;
  String ebMobile__TotalOpenAmount__c;
  String ebMobile__TradeChannel__c;
  String ebMobile__TradeGroup__c;
  String ebMobile__TradeName__c;
  String TransportationZone__c;
  String ebMobile__UniqueKey__c;
  String ebMobile__VATNumber__c;
  String ebMobile__Vendor__c;
  String CCSM_VendorNo__c;
  String ebMobile__VisitStartDate__c;
  String ebMobile__ZAPartner__c;
  String ebMobile__ZBPartner__c;
  String ebMobile__ZGPartner__c;
  String ebMobile__ZHPartner__c;
  String ebMobile__ZIPartner__c;
  String ebMobile__ZNPartner__c;
  String ebMobile__ZQPartner__c;
  String ebMobile__ZRPartner__c;
  String ebMobile__ZTPartner__c;
  String ebMobile__ZXCrossDock__c;
  String Geo_Longitude;
  String Geo_Latitude;
  String ProductList;
  String ebMobile__Barcode__c;
  String RouteNumber;
  String ebMobile__ScanStoreMandatory__c;
  String ebMobile__RouteJumping__c;
  String ShippingCity;
  String ShippingPostalCode;
  String Route;
  String ArabicName__c;
  String ArabicStreet__c;
  String ArabicCity__c;
  String ArabicCountry__c;
  String VATRegistrationNo;
  String NoteToDriver__c;
  String Usercode;
  String LastTime;
  String dirty;

  MD_Account_Entity(this.id, this.Name, this.AccountNumber, this.Owner, this.RecordType, this.Site, this.AccountSource,
      this.AnnualRevenue, this.BillingAddress, this.CreatedBy, this.Jigsaw, this.Description, this.NumberOfEmployees,
      this.Fax, this.Industry, this.LastModifiedBy, this.Ownership, this.Parent, this.Phone, this.Rating,
      this.ShippingAddress, this.Sic, this.SicDesc, this.TickerSymbol, this.Type, this.Website,
      this.ebMobile__AccountGroup__c, this.ebMobile__AccountName1__c, this.ebMobile__AccountName2__c,
      this.ebMobile__AccountPartner__c, this.ebMobile__AccountPhotoId__c, this.ebMobile__ActivationDate__c,
      this.ebMobile__IsActive__c, this.ebMobile__Address__c, this.ebMobile__ApprovalStepsDate__c,
      this.ebMobile__BillTo__c, this.ebMobile__BlockByCredit__c, this.ebMobile__DeliveryType__c,
      this.ebMobile__BusinessTypeExtension__c, this.ebMobile__CallFrequency__c, this.CallFrequencyCode__c,
      this.ebMobile__Category__c, this.ebMobile__IsChangeByInterface__c, this.ebMobile__CityCode__c,
      this.ebMobile__Segment__c, this.ebMobile__CloseDay__c, this.ebMobile__ClosingTime__c, this.ebMobile__Company__c,
      this.ebMobile__CompanyCode__c, this.ebMobile__CompanyDeleteFlag__c, this.ebMobile__ContactEmail__c,
      this.ebMobile__ContactMobile__c, this.ebMobile__ContactPersonFunction__c, this.ebMobile__ContactPersonName__c,
      this.ebMobile__ContactPhone__c, this.ebMobile__Country__c, this.ebMobile__CountryCode__c,
      this.ebMobile__CountryKey__c, this.ebMobile__CreditDays__c, this.ebMobile__AvailableBalance__c,
      this.ebMobile__CreditLimit__c, this.ebMobile__Currency__c, this.ebMobile__CustomerConditionGroup__c,
      this.ebMobile__DeliveringPlant__c, this.ebMobile__DeliveryDate__c, this.ebMobile__DeliveryDays__c,
      this.ebMobile__DiscountIndicator__c, this.ebMobile__DistributionChannel__c, this.ebMobile__Distributor__c,
      this.ebMobile__District__c, this.ebMobile__Division__c, this.ebMobile__ERPAccountNumber__c,
      this.ExecuteBatchFlag__c, this.ebMobile__GeoCode__c, this.ebMobile__GUID__c, this.HasUpdatedAR__c,
      this.ebMobile__HouseNumber__c, this.ebMobile__InvestmentValue__c, this.ebMobile__InvoiceCalendar__c,
      this.IsPush__c, this.ebMobile__KeyAccount__c, this.KeyAccount__c, this.Last3MonthsVolume__c,
      this.ebMobile__Last3MonthsVolume__c, this.ebMobile__LastCallDate__c, this.ebMobile__LastOrderDate__c,
      this.ebMobile__LastOrderTotalPrice__c, this.ebMobile__LastOrderTotalQuantity__c,
      this.ebMobile__MEPCustomerNumber__c, this.ebMobile__OpeningTime__c, this.ebMobile__OpenItemsAgingStart__c,
      this.ebMobile__OperationalMarketType__c, this.ebMobile__OperationalTradeChannel__c, this.ebMobile__OrderBlock__c,
      this.ebMobile__Owner_Role__c, this.ebMobile__P3MAVGSales__c, this.ebMobile__PartnerFunction__c,
      this.ebMobile__Payer__c, this.ebMobile__PaymentTerms__c, this.ebMobile__PONumber__c, this.ebMobile__Postal__c,
      this.ebMobile__PriceAttribute__c, this.ebMobile__PriceClassID__c, this.ebMobile__PriceGroup__c,
      this.ebMobile__PriceListType__c, this.ebMobile__PricingProcedure__c, this.ebMobile__RecordAction__c,
      this.ebMobile__RecordTypeName__c, this.RedIndecator__c, this.ebMobile__Region__c,
      this.ebMobile__RegistrationNumber__c, this.ebMobile__SalesDistrict__c, this.ebMobile__SaleGroup__c,
      this.ebMobile__SalesOffice__c, this.ebMobile__SalesOrg__c, this.ebMobile__SalesOrgCode__c, this.ebMobile__User__c,
      this.ebMobile__SalesRoute__c, this.ebMobile__ShippingCondition__c, this.ShippingConditionCode__c,
      this.ebMobile__ShipTo__c, this.ebMobile__State__c, this.ebMobile__Street__c, this.ebMobile__Street4__c,
      this.ebMobile__Street5__c, this.ebMobile__StreetNumber__c, this.ebMobile__SubTradeChannel__c,
      this.ebMobile__SuppressionReason__c, this.ebMobile__SuspressionCode__c, this.ebMobile__SuspressionDate__c,
      this.ebMobile__TargetGroup__c, this.ebMobile__TaxCode__c, this.ebMobile__TaxNumber__c,
      this.ebMobile__TotalOpenAmount__c, this.ebMobile__TradeChannel__c, this.ebMobile__TradeGroup__c,
      this.ebMobile__TradeName__c, this.TransportationZone__c, this.ebMobile__UniqueKey__c, this.ebMobile__VATNumber__c,
      this.ebMobile__Vendor__c, this.CCSM_VendorNo__c, this.ebMobile__VisitStartDate__c, this.ebMobile__ZAPartner__c,
      this.ebMobile__ZBPartner__c, this.ebMobile__ZGPartner__c, this.ebMobile__ZHPartner__c,
      this.ebMobile__ZIPartner__c, this.ebMobile__ZNPartner__c, this.ebMobile__ZQPartner__c,
      this.ebMobile__ZRPartner__c, this.ebMobile__ZTPartner__c, this.ebMobile__ZXCrossDock__c, this.Geo_Longitude,
      this.Geo_Latitude, this.ProductList, this.ebMobile__Barcode__c, this.RouteNumber,
      this.ebMobile__ScanStoreMandatory__c, this.ebMobile__RouteJumping__c, this.ShippingCity, this.ShippingPostalCode,
      this.Route, this.ArabicName__c, this.ArabicStreet__c, this.ArabicCity__c, this.ArabicCountry__c,
      this.VATRegistrationNo, this.NoteToDriver__c,this.Usercode,this.LastTime,this.dirty);

  static Map<String, dynamic> toJson(
      MD_Account_Entity instance) =>
      <String, dynamic>{
        'id': instance.id,
        'Name': instance.Name,
        'AccountNumber': instance.AccountNumber,
        'Owner': instance.Owner,
        'RecordType': instance.RecordType,
        'Site': instance.Site,
        'AccountSource': instance.AccountSource,
        'AnnualRevenue': instance.AnnualRevenue,
        'BillingAddress': instance.BillingAddress,
        'CreatedBy': instance.CreatedBy,
        'Jigsaw': instance.Jigsaw,
        'Description': instance.Description,
        'NumberOfEmployees': instance.NumberOfEmployees,
        'Fax': instance.Fax,
        'Industry': instance.Industry,
        'LastModifiedBy': instance.LastModifiedBy,
        'Ownership': instance.Ownership,
        'Parent': instance.Parent,
        'Phone': instance.Phone,
        'Rating': instance.Rating,
        'ShippingAddress': instance.ShippingAddress,
        'Sic': instance.Sic,
        'SicDesc': instance.SicDesc,
        'TickerSymbol': instance.TickerSymbol,
        'Type': instance.Type,
        'Website': instance.Website,
        'ebMobile__AccountGroup__c': instance.ebMobile__AccountGroup__c,
        'ebMobile__AccountName1__c': instance.ebMobile__AccountName1__c,
        'ebMobile__AccountName2__c': instance.ebMobile__AccountName2__c,
        'ebMobile__AccountPartner__c': instance.ebMobile__AccountPartner__c,
        'ebMobile__AccountPhotoId__c': instance.ebMobile__AccountPhotoId__c,
        'ebMobile__ActivationDate__c': instance.ebMobile__ActivationDate__c,
        'ebMobile__IsActive__c': instance.ebMobile__IsActive__c,
        'ebMobile__Address__c': instance.ebMobile__Address__c,
        'ebMobile__ApprovalStepsDate__c': instance.ebMobile__ApprovalStepsDate__c,
        'ebMobile__BillTo__c': instance.ebMobile__BillTo__c,
        'ebMobile__BlockByCredit__c': instance.ebMobile__BlockByCredit__c,
        'ebMobile__DeliveryType__c': instance.ebMobile__DeliveryType__c,
        'ebMobile__BusinessTypeExtension__c':
        instance.ebMobile__BusinessTypeExtension__c,
        'ebMobile__CallFrequency__c': instance.ebMobile__CallFrequency__c,
        'CallFrequencyCode__c': instance.CallFrequencyCode__c,
        'ebMobile__Category__c': instance.ebMobile__Category__c,
        'ebMobile__IsChangeByInterface__c':
        instance.ebMobile__IsChangeByInterface__c,
        'ebMobile__CityCode__c': instance.ebMobile__CityCode__c,
        'ebMobile__Segment__c': instance.ebMobile__Segment__c,
        'ebMobile__CloseDay__c': instance.ebMobile__CloseDay__c,
        'ebMobile__ClosingTime__c': instance.ebMobile__ClosingTime__c,
        'ebMobile__Company__c': instance.ebMobile__Company__c,
        'ebMobile__CompanyCode__c': instance.ebMobile__CompanyCode__c,
        'ebMobile__CompanyDeleteFlag__c': instance.ebMobile__CompanyDeleteFlag__c,
        'ebMobile__ContactEmail__c': instance.ebMobile__ContactEmail__c,
        'ebMobile__ContactMobile__c': instance.ebMobile__ContactMobile__c,
        'ebMobile__ContactPersonFunction__c':
        instance.ebMobile__ContactPersonFunction__c,
        'ebMobile__ContactPersonName__c': instance.ebMobile__ContactPersonName__c,
        'ebMobile__ContactPhone__c': instance.ebMobile__ContactPhone__c,
        'ebMobile__Country__c': instance.ebMobile__Country__c,
        'ebMobile__CountryCode__c': instance.ebMobile__CountryCode__c,
        'ebMobile__CountryKey__c': instance.ebMobile__CountryKey__c,
        'ebMobile__CreditDays__c': instance.ebMobile__CreditDays__c,
        'ebMobile__AvailableBalance__c': instance.ebMobile__AvailableBalance__c,
        'ebMobile__CreditLimit__c': instance.ebMobile__CreditLimit__c,
        'ebMobile__Currency__c': instance.ebMobile__Currency__c,
        'ebMobile__CustomerConditionGroup__c':
        instance.ebMobile__CustomerConditionGroup__c,
        'ebMobile__DeliveringPlant__c': instance.ebMobile__DeliveringPlant__c,
        'ebMobile__DeliveryDate__c': instance.ebMobile__DeliveryDate__c,
        'ebMobile__DeliveryDays__c': instance.ebMobile__DeliveryDays__c,
        'ebMobile__DiscountIndicator__c': instance.ebMobile__DiscountIndicator__c,
        'ebMobile__DistributionChannel__c':
        instance.ebMobile__DistributionChannel__c,
        'ebMobile__Distributor__c': instance.ebMobile__Distributor__c,
        'ebMobile__District__c': instance.ebMobile__District__c,
        'ebMobile__Division__c': instance.ebMobile__Division__c,
        'ebMobile__ERPAccountNumber__c': instance.ebMobile__ERPAccountNumber__c,
        'ExecuteBatchFlag__c': instance.ExecuteBatchFlag__c,
        'ebMobile__GeoCode__c': instance.ebMobile__GeoCode__c,
        'ebMobile__GUID__c': instance.ebMobile__GUID__c,
        'HasUpdatedAR__c': instance.HasUpdatedAR__c,
        'ebMobile__HouseNumber__c': instance.ebMobile__HouseNumber__c,
        'ebMobile__InvestmentValue__c': instance.ebMobile__InvestmentValue__c,
        'ebMobile__InvoiceCalendar__c': instance.ebMobile__InvoiceCalendar__c,
        'IsPush__c': instance.IsPush__c,
        'ebMobile__KeyAccount__c': instance.ebMobile__KeyAccount__c,
        'KeyAccount__c': instance.KeyAccount__c,
        'Last3MonthsVolume__c': instance.Last3MonthsVolume__c,
        'ebMobile__Last3MonthsVolume__c': instance.ebMobile__Last3MonthsVolume__c,
        'ebMobile__LastCallDate__c': instance.ebMobile__LastCallDate__c,
        'ebMobile__LastOrderDate__c': instance.ebMobile__LastOrderDate__c,
        'ebMobile__LastOrderTotalPrice__c':
        instance.ebMobile__LastOrderTotalPrice__c,
        'ebMobile__LastOrderTotalQuantity__c':
        instance.ebMobile__LastOrderTotalQuantity__c,
        'ebMobile__MEPCustomerNumber__c': instance.ebMobile__MEPCustomerNumber__c,
        'ebMobile__OpeningTime__c': instance.ebMobile__OpeningTime__c,
        'ebMobile__OpenItemsAgingStart__c':
        instance.ebMobile__OpenItemsAgingStart__c,
        'ebMobile__OperationalMarketType__c':
        instance.ebMobile__OperationalMarketType__c,
        'ebMobile__OperationalTradeChannel__c':
        instance.ebMobile__OperationalTradeChannel__c,
        'ebMobile__OrderBlock__c': instance.ebMobile__OrderBlock__c,
        'ebMobile__Owner_Role__c': instance.ebMobile__Owner_Role__c,
        'ebMobile__P3MAVGSales__c': instance.ebMobile__P3MAVGSales__c,
        'ebMobile__PartnerFunction__c': instance.ebMobile__PartnerFunction__c,
        'ebMobile__Payer__c': instance.ebMobile__Payer__c,
        'ebMobile__PaymentTerms__c': instance.ebMobile__PaymentTerms__c,
        'ebMobile__PONumber__c': instance.ebMobile__PONumber__c,
        'ebMobile__Postal__c': instance.ebMobile__Postal__c,
        'ebMobile__PriceAttribute__c': instance.ebMobile__PriceAttribute__c,
        'ebMobile__PriceClassID__c': instance.ebMobile__PriceClassID__c,
        'ebMobile__PriceGroup__c': instance.ebMobile__PriceGroup__c,
        'ebMobile__PriceListType__c': instance.ebMobile__PriceListType__c,
        'ebMobile__PricingProcedure__c': instance.ebMobile__PricingProcedure__c,
        'ebMobile__RecordAction__c': instance.ebMobile__RecordAction__c,
        'ebMobile__RecordTypeName__c': instance.ebMobile__RecordTypeName__c,
        'RedIndecator__c': instance.RedIndecator__c,
        'ebMobile__Region__c': instance.ebMobile__Region__c,
        'ebMobile__RegistrationNumber__c':
        instance.ebMobile__RegistrationNumber__c,
        'ebMobile__SalesDistrict__c': instance.ebMobile__SalesDistrict__c,
        'ebMobile__SaleGroup__c': instance.ebMobile__SaleGroup__c,
        'ebMobile__SalesOffice__c': instance.ebMobile__SalesOffice__c,
        'ebMobile__SalesOrg__c': instance.ebMobile__SalesOrg__c,
        'ebMobile__SalesOrgCode__c': instance.ebMobile__SalesOrgCode__c,
        'ebMobile__User__c': instance.ebMobile__User__c,
        'ebMobile__SalesRoute__c': instance.ebMobile__SalesRoute__c,
        'ebMobile__ShippingCondition__c': instance.ebMobile__ShippingCondition__c,
        'ShippingConditionCode__c': instance.ShippingConditionCode__c,
        'ebMobile__ShipTo__c': instance.ebMobile__ShipTo__c,
        'ebMobile__State__c': instance.ebMobile__State__c,
        'ebMobile__Street__c': instance.ebMobile__Street__c,
        'ebMobile__Street4__c': instance.ebMobile__Street4__c,
        'ebMobile__Street5__c': instance.ebMobile__Street5__c,
        'ebMobile__StreetNumber__c': instance.ebMobile__StreetNumber__c,
        'ebMobile__SubTradeChannel__c': instance.ebMobile__SubTradeChannel__c,
        'ebMobile__SuppressionReason__c': instance.ebMobile__SuppressionReason__c,
        'ebMobile__SuspressionCode__c': instance.ebMobile__SuspressionCode__c,
        'ebMobile__SuspressionDate__c': instance.ebMobile__SuspressionDate__c,
        'ebMobile__TargetGroup__c': instance.ebMobile__TargetGroup__c,
        'ebMobile__TaxCode__c': instance.ebMobile__TaxCode__c,
        'ebMobile__TaxNumber__c': instance.ebMobile__TaxNumber__c,
        'ebMobile__TotalOpenAmount__c': instance.ebMobile__TotalOpenAmount__c,
        'ebMobile__TradeChannel__c': instance.ebMobile__TradeChannel__c,
        'ebMobile__TradeGroup__c': instance.ebMobile__TradeGroup__c,
        'ebMobile__TradeName__c': instance.ebMobile__TradeName__c,
        'TransportationZone__c': instance.TransportationZone__c,
        'ebMobile__UniqueKey__c': instance.ebMobile__UniqueKey__c,
        'ebMobile__VATNumber__c': instance.ebMobile__VATNumber__c,
        'ebMobile__Vendor__c': instance.ebMobile__Vendor__c,
        'CCSM_VendorNo__c': instance.CCSM_VendorNo__c,
        'ebMobile__VisitStartDate__c': instance.ebMobile__VisitStartDate__c,
        'ebMobile__ZAPartner__c': instance.ebMobile__ZAPartner__c,
        'ebMobile__ZBPartner__c': instance.ebMobile__ZBPartner__c,
        'ebMobile__ZGPartner__c': instance.ebMobile__ZGPartner__c,
        'ebMobile__ZHPartner__c': instance.ebMobile__ZHPartner__c,
        'ebMobile__ZIPartner__c': instance.ebMobile__ZIPartner__c,
        'ebMobile__ZNPartner__c': instance.ebMobile__ZNPartner__c,
        'ebMobile__ZQPartner__c': instance.ebMobile__ZQPartner__c,
        'ebMobile__ZRPartner__c': instance.ebMobile__ZRPartner__c,
        'ebMobile__ZTPartner__c': instance.ebMobile__ZTPartner__c,
        'ebMobile__ZXCrossDock__c': instance.ebMobile__ZXCrossDock__c,
        'Geo_Longitude': instance.Geo_Longitude,
        'Geo_Latitude': instance.Geo_Latitude,
        'ProductList': instance.ProductList,
        'ebMobile__Barcode__c': instance.ebMobile__Barcode__c,
        'RouteNumber': instance.RouteNumber,
        'ebMobile__ScanStoreMandatory__c':
        instance.ebMobile__ScanStoreMandatory__c,
        'ebMobile__RouteJumping__c': instance.ebMobile__RouteJumping__c,
        'ShippingCity': instance.ShippingCity,
        'ShippingPostalCode': instance.ShippingPostalCode,
        'Route': instance.Route,
        'ArabicName__c': instance.ArabicName__c,
        'ArabicStreet__c': instance.ArabicStreet__c,
        'ArabicCity__c': instance.ArabicCity__c,
        'ArabicCountry__c': instance.ArabicCountry__c,
        'VATRegistrationNo': instance.VATRegistrationNo,
        'NoteToDriver__c': instance.NoteToDriver__c,
        'Usercode': instance.Usercode,
        'LastTime': instance.LastTime,
        'dirty': instance.dirty,
      };

  MD_Account_Entity.Empty();

}
