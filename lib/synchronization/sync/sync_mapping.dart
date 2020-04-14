import 'package:uuid/uuid.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-03-10 14:10

String MARK = ':';

String createIdBySf() {
  return 'GUID' + new Uuid().v1();
}

String deliveryHeader = 'ebMobile__Delivery__c';
String deliveryItem = 'DeliveryItem__c';
String shipmentHeader = 'Shipment__c';
String shipmentItem = 'ShipmentLine__c';

String mDeliveryHeader = 'DSD_M_DeliveryHeader';
String mDeliveryItem = 'DSD_M_DeliveryItem';
String mShipmentHeader = 'DSD_M_ShipmentHeader';
String mShipmentItem = 'DSD_M_ShipmentItem';

String tDeliveryHeader = 'DSD_T_DeliveryHeader';
String tDeliveryItem = 'DSD_T_DeliveryItem';
String tShipmentHeader = 'DSD_T_ShipmentHeader';
String tShipmentItem = 'DSD_T_ShipmentItem';



List<String> mDeliveryHeaderFieldsByDownload = [
  'Id',
  'DeliveryNo',
  'ShipmentNo',
  'DeliveryType',
  'DeliveryStatus',
  'AccountNumber',
  'OrderNo',
  'InvoiceNo',
  'PONumber',
  'OrderDate',
  'PlanDeliveryDate',
  'SalesRep',
  'CompanyCode',
  'SalesOrg',
  'SalesOff',
  'PaymentType',
  'Currency',
  'PlanDeliveryQty',
  'DeliveryAddress',
  'Contact',
  'Telephone',
  'BasePrice',
  'Tax',
  'Discount',
  'NetPrice',
  'Deposit',
  'DataSource',
  'DeliveryNote',
  'Tax2',
  'MarketDeveloper',
  'DeliverySequence',
  'DeliveryTimeSlotFrom',
  'DeliveryTimeSlotTo',
  'PickupEmpties__c',
  'EmptyRefund__c',
  'ArrivalTime__c',
  'FinishTime__c',
];

List<String> tDeliveryHeaderFieldsByDownload = [
  'Id',
  'GUID',
  'DeliveryNo',
  'VisitId',
  'ShipmentNo',
  'DeliveryType',
  'DeliveryStatus',
  'AccountNumber',
  'OrderNo',
  'InvoiceNo',
  'PONumber',
  'OrderDate',
  'ActualDeliveryDate',
  'Currency',
  'CustomerSignStatus',
  'CustomerSignDate',
  'CustomerSignImg',
  'DriverSignStatus',
  'DriverSignDate',
  'DriverSignImg',
  'StartTime',
  'EndTime',
  'BasePrice',
  'Tax',
  'Discount',
  'NetPrice',
  'Deposit',
  'ActualPayment',
  'ActualDeposit',
  'CancelTime',
  'Tax2',
  'CancelReason',
  'DeliveryNote',
  'CreateUser',
  'CreateTime',
  'Rebook',
  'PickupEmpties__c',
  'EmptyRefund__c',
];

List<String> mDeliveryItemFieldsByDownload = [
  'Id',
  'DeliveryNo',
  'ProductCode',
  'ProductUnit',
  'PlanQty',
  'TotalWeight',
  'WeightUnit',
  'BasePrice',
  'Tax',
  'Discount',
  'NetPrice',
  'Deposit',
  'IsFree',
  'ItemSequence',
  'ItemNumber',
  'ItemCategory',
  'Tax2',
];

List<String> tDeliveryItemFieldsByDownload = [
  'Id',
  'GUID',
  'DeliveryNo',
  'ProductCode',
  'ProductUnit',
  'PlanQty',
  'ActualQty',
  'DifferenceQty',
  'Reason',
  'BasePrice',
  'Tax',
  'Discount',
  'NetPrice',
  'Deposit',
  'IsReturn',
  'CreateUser',
  'CreateTime',
  'IsFree',
  'ItemSequence',
  'ItemNumber',
  'ItemCategory',
  'Tax2',
];

List<String> mShipmentHeaderFieldsByDownload = [
  'Id',
  'ShipmentNo',
  'ShipmentDate',
  'ShipmentType',
  'Route',
  'Description',
  'ReleaseStatus',
  'ReleaseUser',
  'ReleaseTime',
  'CompletionStatus',
  'CompletionTime',
  'Driver1',
  'Driver2',
  'TruckCode',
  'TruckType',
  'LoadingSequence',
  'WarehouseCode',
  'OutWarehouse',
  'TotalProductQty',
  'TotalItemAmount',
  'TotalWeight',
  'WeightUnit',
  'DataSource',
  'TruckId',
  'Valid',
];


List<String> tShipmentHeaderFieldsByDownload = [
  'Id',
  'GUID',
  'ShipmentNo',
  'ShipmentDate',
  'ShipmentType',
  'ActionType',
  'StartTime',
  'EndTime',
  'Odometer',
  'Checker',
  'CheckerConfirm',
  'CheckerConfirmTime',
  'DCheckerSignImg',
  'Cashier',
  'CashierConfirm',
  'CashierConfirmTime',
  'CashierSignImg',
  'DCashierSignImg',
  'Gatekeeper',
  'GKConfirm',
  'GKConfirmTime',
  'GKSignImg',
  'DGKSignImg',
  'WarehouseCode',
  'Status',
  'Driver',
  'TruckId',
  'TotalAmount',
  'TotalWeight',
  'WeightUnit',
  'CreateUser',
  'CreateTime',
  'ScanResult',
  'Manually',
];

List<String> mShipmentItemFieldsByDownload = [
  'Id',
  'ShipmentNo',
  'ProductCode',
  'ProductUnit',
  'PlanQty',
];

List<String> tShipmentItemFieldsByDownload = [
  'Id',
  'GUID',
  'HeaderId',
  'ProductCode',
  'ProductUnit',
  'PlanQty',
  'ActualQty',
  'DifferenceQty',
  'DifferenceReason',
  'CreateUser',
  'CreateTime',
];

Map<String,String> sf2LocalMapping = {
  'Product2': 'MD_Product',
  'Driver__c': 'MD_Person',
  'Contact': 'MD_Contact',
  'Account': 'MD_Account',
  'Truck__c': 'DSD_M_Truck',
  'ebMobile__Call__c': 'DSD_T_Visit',

  'ebMobile__Configuration__c': 'DSD_M_SystemConfig',
  'TruckStock__c': 'DSD_T_TruckStock',
  'TruckStockTracking__c': 'DSD_T_TruckStockTracking',
  'Dictionary__c': 'MD_Dictionary',

};

Map<String,String> local2SfMapping = {
  'MD_Product': 'Product2',
  'MD_Dictionary': 'Dictionary__c',
  'MD_Person': 'Driver__c',
  'MD_Contact': 'Contact',
  'MD_Account': 'Account',
  'DSD_M_Truck': 'Truck__c',
  'DSD_M_SystemConfig': 'ebMobile__Configuration__c',

  'DSD_T_TruckStock': 'TruckStock__c',
  'DSD_T_TruckStockTracking': 'TruckStockTracking__c',
  'DSD_T_DeliveryHeader': 'ebMobile__Delivery__c',
  'DSD_T_DeliveryItem': 'DeliveryItem__c',
  'DSD_T_ShipmentHeader': 'Shipment__c',
  'DSD_T_ShipmentItem': 'ShipmentLine__c',
  'DSD_T_Visit': 'ebMobile__Call__c',
  'ContentVersion': 'ContentVersion',
};

String deliveryHeaderMark = 'ebMobile__Delivery__c$MARK';
String deliveryItemMark = 'DeliveryItem__c$MARK';
String shipmentHeaderMark = 'Shipment__c$MARK';
String shipmentItemMark = 'ShipmentLine__c$MARK';
String accountMark = 'Account$MARK';
String contactMark = 'Contact$MARK';
String personMark = 'Driver__c$MARK';
String truckMark = 'Truck__c$MARK';
String productMark = 'Product2$MARK';
String visitMark = 'ebMobile__Call__c$MARK';
String systemConfigMark = 'ebMobile__Configuration__c$MARK';
String dictionaryMark = 'Dictionary__c$MARK';
String truckStockMark = 'TruckStock__c$MARK';
String truckTrackMark = 'TruckStockTracking__c$MARK';
String cvMark = 'ContentVersion$MARK';


Map<String,String> fieldMapping = {

//  DSD_M_DeliveryHeader

  '${deliveryHeaderMark}Id': 'Id',
  '${deliveryHeaderMark}GUID__c': 'GUID',
  '${deliveryHeaderMark}iDelyDeliveryNo__c': 'DeliveryNo',
  '${deliveryHeaderMark}ShipmentNo__c': 'ShipmentNo',
  '${deliveryHeaderMark}ebMobile__DeliveryType__c': 'DeliveryType',
  '${deliveryHeaderMark}Status__c': 'DeliveryStatus',
  '${deliveryHeaderMark}AccountNumber__c': 'AccountNumber',
  '${deliveryHeaderMark}iDelyOrderNO__c': 'OrderNo',
  '${deliveryHeaderMark}InvoiceNo__c': 'InvoiceNo',
//  '': 'PONumber',
  '${deliveryHeaderMark}OrderDate__c': 'OrderDate',
  '${deliveryHeaderMark}ebMobile__DeliveryDate__c': 'PlanDeliveryDate',
//  '': 'SalesRep',
  '${deliveryHeaderMark}CompanyCode__c': 'CompanyCode',
  '${deliveryHeaderMark}ebMobile__SalesOrganization__c': 'SalesOrg',
//  '': 'SalesOff',
  '${deliveryHeaderMark}iDelyPaymentType__c': 'PaymentType',
  '${deliveryHeaderMark}Currency__c': 'Currency',
  '${deliveryHeaderMark}ebMobile__DeliveryQuantity__c': 'PlanDeliveryQty',
  '${deliveryHeaderMark}AccountAddress__c': 'DeliveryAddress',
//  '': 'Contact',
  '${deliveryHeaderMark}PhoneNumber__c': 'Telephone',
  '${deliveryHeaderMark}BasePrice__c': 'BasePrice',
  '${deliveryHeaderMark}TotalTaxAmount_c__c': 'Tax',
  '${deliveryHeaderMark}iDelyTotalTaxAmount2__c': 'Tax2',
  '${deliveryHeaderMark}TotalDiscount__c': 'Discount',
  '${deliveryHeaderMark}NetPrice__c': 'NetPrice',
  '${deliveryHeaderMark}Deposit__c': 'Deposit',
//  '': 'DataSource',
  '${deliveryHeaderMark}DeliveryNote__c': 'DeliveryNote',
  '${deliveryHeaderMark}DeliverySequence__c': 'DeliverySequence',
  '${deliveryHeaderMark}MarketDeveloper__c': 'MarketDeveloper',
  '${deliveryHeaderMark}DeliveryTimeSlotFrom__c': 'DeliveryTimeSlotFrom',
  '${deliveryHeaderMark}DeliveryTimeSlotTo__c': 'DeliveryTimeSlotTo',
  '${deliveryHeaderMark}PickupEmpties__c': 'PickupEmpties__c',
  '${deliveryHeaderMark}EmptyRefund__c': 'EmptyRefund__c',
  '${deliveryHeaderMark}ArrivalTime__c': 'ArrivalTime__c',
  '${deliveryHeaderMark}FinishTime__c': 'FinishTime__c',


  //  DSD_T_DeliveryHeader

  '${deliveryHeaderMark}iDelyVisitId__c': 'VisitId',
  '${deliveryHeaderMark}CustomerSignStatus__c': 'CustomerSignStatus',
  '${deliveryHeaderMark}CustomerSignDate__c': 'CustomerSignDate',
  '${deliveryHeaderMark}CustomerSignImg__c': 'CustomerSignImg',
  '${deliveryHeaderMark}DriverSignStatus__c': 'DriverSignStatus',
  '${deliveryHeaderMark}DriverSignDate__c': 'DriverSignDate',
  '${deliveryHeaderMark}DriverSignImg__c': 'DriverSignImg',
//  '': 'ActualDeliveryDate',
  /*'': 'StartTime',*/
  /*'': 'EndTime',*/
  '${deliveryHeaderMark}ActualPayment__c': 'ActualPayment',
  '${deliveryHeaderMark}ActualDeposit__c': 'ActualDeposit',
  '${deliveryHeaderMark}CancelTime__c': 'CancelTime',
  '${deliveryHeaderMark}Rebook__c': 'Rebook',
  '${deliveryHeaderMark}CancelReason__c': 'CancelReason',


  '${deliveryHeaderMark}iDelyCreateUserCode__c': 'CreateUser',
  '${deliveryHeaderMark}iDelyCreateTime__c': 'CreateTime',
  '${deliveryHeaderMark}iDelyLastUpdateUserCode__c': 'LastUpdateUser',
  '${deliveryHeaderMark}iDelyLastUpdateTime__c': 'LastUpdateTime',


  //  DSD_M_DeliveryItem

  '${deliveryItemMark}Id': 'Id',
  '${deliveryItemMark}GUID__c': 'GUID',
  '${deliveryItemMark}DeliveryID__c': 'DeliveryID',
  '${deliveryItemMark}DeliveryNo__c': 'DeliveryNo',
  '${deliveryItemMark}iDelyProductCode__c': 'ProductCode',
  '${deliveryItemMark}iDelyProductUnit__c': 'ProductUnit',
  '${deliveryItemMark}ItemSequence__c': 'ItemSequence',
//  '': 'ItemNumber',
  '${deliveryItemMark}PlannedDeliveryQty__c': 'PlanQty',
//  '': 'TotalWeight',
//  '': 'WeightUnit',
  '${deliveryItemMark}UnitPrice__c': 'BasePrice',
  '${deliveryItemMark}LineTaxAmount__c': 'Tax',
  '${deliveryItemMark}LineTaxAmount2__c': 'Tax2',
  '${deliveryItemMark}Discount__c': 'Discount',
  '${deliveryItemMark}NetPrice__c': 'NetPrice',
  '${deliveryItemMark}Deposit__c': 'Deposit',
  '${deliveryItemMark}IsFree__c': 'IsFree',
  '${deliveryItemMark}ItemCategory__c': 'ItemCategory',

  //  DSD_T_DeliveryItem


  '${deliveryItemMark}ProductID__c': 'ProductId',
  '${deliveryItemMark}ExternalId__c': 'ExternalId',
  '${deliveryItemMark}ActualDeliveryQty__c': 'ActualQty',
  '${deliveryItemMark}DifferenceQty__c': 'DifferenceQty',
  '${deliveryItemMark}Reason__c': 'Reason',
  '${deliveryItemMark}IsReturn__c': 'IsReturn',

  '${deliveryItemMark}iDelyCreateUserCode__c': 'CreateUser',
  '${deliveryItemMark}iDelyCreateTime__c': 'CreateTime',
  '${deliveryItemMark}iDelyLastUpdateUserCode__c': 'LastUpdateUser',
  '${deliveryItemMark}iDelyLastUpdateTime__c': 'LastUpdateTime',

  //  DSD_M_ShipmentHeader

  '${shipmentHeaderMark}Id': 'Id',
  '${shipmentHeaderMark}GUID__c': 'GUID',
  '${shipmentHeaderMark}ShipmentNo__c': 'ShipmentNo',
  '${shipmentHeaderMark}Plan_Shipment_Date__c': 'ShipmentDate',
  '${shipmentHeaderMark}ShipmentType__c': 'ShipmentType',
  '${shipmentHeaderMark}TruckId__c': 'TruckId',
//  '': 'Route',
//  '': 'Description',
  '${shipmentHeaderMark}ReleaseStatus__c': 'ReleaseStatus',
  '${shipmentHeaderMark}ReleaseUser__c': 'ReleaseUser',
  '${shipmentHeaderMark}ReleaseTime__c': 'ReleaseTime',
//  '': 'CompletionStatus',
//  '': 'CompletionTime',
  '${shipmentHeaderMark}DriverCode__c': 'Driver1',
  '${shipmentHeaderMark}TrunkCode__c': 'TruckCode',
  '${shipmentHeaderMark}TruckType__c': 'TruckType',
  '${shipmentHeaderMark}LoadingSequence__c': 'LoadingSequence',
//  '': 'WarehouseCode',
//  '': 'OutWarehouse',
  '${shipmentHeaderMark}TotalProductQty__c': 'TotalProductQty',
  '${shipmentHeaderMark}TotalItemAmount__c': 'TotalItemAmount',
//  '': 'TotalWeight',
//  '': 'WeightUnit',
//  '': 'DataSource',
  //  DSD_T_ShipmentHeader


  '${shipmentHeaderMark}Status__c': 'Status',
  '${shipmentHeaderMark}ActionType__c': 'ActionType',
  '${shipmentHeaderMark}CheckoutTime__c': 'StartTime',
  '${shipmentHeaderMark}CheckinTime__c': 'EndTime',
  '${shipmentHeaderMark}Odometer__c': 'Odometer',
  '${shipmentHeaderMark}Checker__c': 'Checker',
  '${shipmentHeaderMark}CheckerConfirm__c': 'CheckerConfirm',
  '${shipmentHeaderMark}CheckerConfirmTime__c': 'CheckerConfirmTime',
  '${shipmentHeaderMark}CheckerSignImg__c': 'CheckerSignImg',
  '${shipmentHeaderMark}DCheckerSignImg__c': 'DCheckerSignImg',
  '${shipmentHeaderMark}Cashier__c': 'Cashier',
  '${shipmentHeaderMark}CashierConfirm__c': 'CashierConfirm',
  '${shipmentHeaderMark}CashierConfirmTime__c': 'CashierConfirmTime',
  '${shipmentHeaderMark}CashierSignImg__c': 'CashierSignImg',
  '${shipmentHeaderMark}DCashierSignImg__c': 'DCashierSignImg',
  '${shipmentHeaderMark}Gatekeeper__c': 'Gatekeeper',
  '${shipmentHeaderMark}GKConfirm__c': 'GKConfirm',
  '${shipmentHeaderMark}GKConfirmTime__c': 'GKConfirmTime',
  '${shipmentHeaderMark}GKSignImg__c': 'GKSignImg',
  '${shipmentHeaderMark}DGKSignImg__c': 'DGKSignImg',
  '${shipmentHeaderMark}iDelyDriver__c': 'Driver',
//  '${shipmentHeaderMark}iDelyTruck__c': 'TruckId',
//  '': 'TotalAmount',
//  '': 'TotalWeight',
//  '': 'WeightUnit',
  '${shipmentHeaderMark}ScanResult__c': 'ScanResult',
  '${shipmentHeaderMark}Manually__c': 'Manually',
  '${shipmentHeaderMark}IsActive__c': 'Valid',

  '${shipmentHeaderMark}iDelyCreateUserCode__c': 'CreateUser',
  '${shipmentHeaderMark}iDelyCreateTime__c': 'CreateTime',
  '${shipmentHeaderMark}iDelyLastUpdateUserCode__c': 'LastUpdateUser',
  '${shipmentHeaderMark}iDelyLastUpdateTime__c': 'LastUpdateTime',

  //  DSD_M_ShipmentItem

  '${shipmentItemMark}Id': 'Id',
  '${shipmentItemMark}GUID__c': 'GUID',
  '${shipmentItemMark}ShipmentNo__c': 'ShipmentNo',
  '${shipmentItemMark}iDelyProductCode__c': 'ProductCode',
  '${shipmentItemMark}iDelyProductUnit__c': 'ProductUnit',
  '${shipmentItemMark}PlanQuantity__c': 'PlanQty',

  //  DSD_T_ShipmentItem

  '${shipmentItemMark}ShipmentId__c': 'HeaderId',
//  '${shipmentItemMark}ActualQty__c': 'ActualQty',
  '${shipmentItemMark}ShippedQuantity__c': 'CheckOutActualQty',
  '${shipmentItemMark}ReceiveQuantity__c': 'CheckInActualQty',
  '${shipmentItemMark}DifferenceQty__c': 'DifferenceQty',
  '${shipmentItemMark}DifferenceReason__c': 'DifferenceReason',

  '${shipmentItemMark}iDelyCreateUserCode__c': 'CreateUser',
  '${shipmentItemMark}iDelyCreateTime__c': 'CreateTime',
  '${shipmentItemMark}iDelyLastUpdateUserCode__c': 'LastUpdateUser',
  '${shipmentItemMark}iDelyLastUpdateTime__c': 'LastUpdateTime',

  //  DSD_T_TruckStock

  '${truckStockMark}Id': 'Id',
  '${truckStockMark}GUID__c': 'GUID',
  '${truckStockMark}TruckID__c': 'TruckId',
  '${truckStockMark}ShipmentNo__c': 'ShipmentNo',
  '${truckStockMark}ProductCode__c': 'ProductCode',
  '${truckStockMark}ProductUnit__c': 'ProductUnit',
  '${truckStockMark}StockQty__c': 'StockQty',
  '${truckStockMark}SaleableQty__c': 'SaleableQty',

  '${truckStockMark}iDelyCreateUserCode__c': 'CreateUser',
  '${truckStockMark}iDelyCreateTime__c': 'CreateTime',
  '${truckStockMark}iDelyLastUpdateUserCode__c': 'LastUpdateUser',
  '${truckStockMark}iDelyLastUpdateTime__c': 'LastUpdateTime',

  //  DSD_T_TruckStockTracking

  '${truckTrackMark}Id': 'Id',
  '${truckTrackMark}GUID__c': 'GUID',
  '${truckTrackMark}VisitId__c': 'VisitId',
  '${truckTrackMark}TruckID__c': 'TruckId',
  '${truckTrackMark}ShipmentNo__c': 'ShipmentNo',
  '${truckTrackMark}TrackingTime__c': 'TrackingTime',
  '${truckTrackMark}ProductCode__c': 'ProductCode',
  '${truckTrackMark}ProductUnit__c': 'ProductUnit',
  '${truckTrackMark}ChangeAction__c': 'ChangeAction',
  '${truckTrackMark}ChangeQuantity__c': 'ChangeQuantity',
  '${truckTrackMark}FromQty__c': 'FromQty',
  '${truckTrackMark}ToQty__c': 'ToQty',

  '${truckTrackMark}iDelyCreateUserCode__c': 'CreateUser',
  '${truckTrackMark}iDelyCreateTime__c': 'CreateTime',
  '${truckTrackMark}iDelyLastUpdateUserCode__c': 'LastUpdateUser',
  '${truckTrackMark}iDelyLastUpdateTime__c': 'LastUpdateTime',


  //  DSD_T_Visit

  '${visitMark}Id': 'Id',
  '${visitMark}ebMobile__GUID__c': 'GUID',
  '${visitMark}ShipmentNo__c': 'ShipmentNo',
  '${visitMark}ebMobile__TimeInOutlet__c': 'StartTime',
  '${visitMark}ebMobile__TimeOutOutlet__c': 'EndTime',
  '${visitMark}iDelyUserCode__c': 'UserCode',
  '${visitMark}iDelyAccountNumber__c': 'AccountNumber',
  '${visitMark}ebMobile__GPSInStore__Longitude__s': 'Longitude',
  '${visitMark}ebMobile__GPSInStore__Latitude__s': 'Latitude',
  '${visitMark}ebMobile__NoVisitReason__c': 'CancelReason',
  '${visitMark}ebMobile__OutbarcodeNoscanReason__c': 'NoScanReason',
  '${visitMark}ebMobile__CallType__c': 'CallType',

  '${visitMark}iDelyCreateUserCode__c': 'CreateUser',
  '${visitMark}iDelyCreateTime__c': 'CreateTime',
  '${visitMark}iDelyLastUpdateUserCode__c': 'LastUpdateUser',
  '${visitMark}iDelyLastUpdateTime__c': 'LastUpdateTime',

  //  ContentVersion

  '${cvMark}Id': 'Id',
  '${cvMark}Title': 'Title',
  '${cvMark}PathOnClient': 'PathOnClient',
  '${cvMark}ParentId__c': 'ParentId__c',
  '${cvMark}VersionData': 'VersionData',

  //  MD_Account

  '${accountMark}Id': 'Id',
  '${accountMark}RouteJumping__c': 'ebMobile__RouteJumping__c',
  '${accountMark}ebMobile__GeoCode__Longitude__s': 'Geo_Longitude',
  '${accountMark}ebMobile__GeoCode__Latitude__s': 'Geo_Latitude',

  '${accountMark}AccountNumber': 'AccountNumber',
  '${accountMark}NoteToDriver__c': 'NoteToDriver__c',
//  '${accountMark}Usercode': 'Usercode',

//  MD_Contact

  '${contactMark}Id': 'Id',
  '${contactMark}ebMobile__AccountNumber__c': 'AccountNumber__c',

  //  MD_Product

  '${productMark}Id': 'Id',
  '${productMark}ebMobile__ConversionRate__c': 'ConversionRate__c',


//  MD_Person

  '${personMark}Id': 'Id',
  '${personMark}UserCode__c': 'UserCode',
  '${personMark}FirstName__c': 'FirstName',
  '${personMark}LastName__c': 'LastName',
  '${personMark}UserType__c': 'Type',
  '${personMark}Password__c': 'Password',
//  '': 'Password',

//  DSD_M_Truck

  '${truckMark}Id': 'Id',
  '${truckMark}TruckCode__c': 'TruckCode',
  '${truckMark}TruckType__c': 'Type',
  '${truckMark}Capacity__c': 'Capacity',
  '${truckMark}Volume__c': 'Volume',
  '${truckMark}VolumeUnit__c': 'VolumeUnit',
  '${truckMark}CompanyCode__c': 'CompanyCode',
  '${truckMark}IsActive__c': 'Status',


  //  DSD_M_SystemConfig

  '${systemConfigMark}Id': 'Id',
  '${systemConfigMark}ebMobile__CodeCategory__c': 'Category',
  '${systemConfigMark}Name': 'KeyName',
  '${systemConfigMark}ebMobile__CodeDescription__c': 'Description',
  '${systemConfigMark}ebMobile__CodeValue__c': 'Value',
  '${systemConfigMark}ebMobile__IsActive__c': 'Valid',

//  MD_Dictionary

  '${dictionaryMark}Id': 'Id',
  '${dictionaryMark}Category__c': 'Category',
  '${dictionaryMark}Sequence__c': 'Sequence',
  '${dictionaryMark}Description__c': 'Description',
  '${dictionaryMark}Value__c': 'Value',
  '${dictionaryMark}IsActive__c': 'Valid',


//  '': '',
//  '': '',

};













