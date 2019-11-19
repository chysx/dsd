/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/23 12:27

class VisitModelSqlFind {
  static const String VISIT_DSD_T_Visit_Sql_Find =
  ''' 
  		SELECT VisitId,
		   ShipmentNo,
		   StartTime,
		   EndTime,
		   UserCode,
		   AccountNumber,
		   Longitude,
		   Latitude,
		   NoScanReason,
		   CreateTime
		FROM DSD_T_Visit
		WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK AND dirty != '1' AND dirty != '2'
	
  ''';

  static const String VISIT_DSD_T_DeliveryHeader_Sql_Find =
  ''' 
  SELECT
		   DeliveryNo,
		   VisitId,
		   ShipmentNo,
		   DeliveryType,
		   DeliveryStatus,
		   AccountNumber,
		   OrderNo,
		   InvoiceNo,
		   PONumber,
		   OrderDate,
		   ActualDeliveryDate,
		   Currency,
		   CustomerSignStatus,
		   CustomerSignDate,
		   CustomerSignImg,
		   DriverSignStatus,
		   DriverSignDate,
		   DriverSignImg,
		   StartTime,
		   EndTime,
		   BasePrice,
		   Tax,
		   Discount,
		   NetPrice,
		   Deposit,
		   ActualPayment,
		   ActualDeposit,
		   CancelTime,
		   CancelReason,
		   DeliveryNote,
		   CreateTime,
		   Rebook,
		   Tax2,
		   PickupEmpties__c,
		   EmptyRefund__c
		FROM DSD_T_DeliveryHeader
		WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK AND dirty != '1' AND dirty != '2'
  
  ''';

  static const String VISIT_DSD_T_DeliveryItem_Sql_Find =
  ''' 
  SELECT T1.DeliveryNo,
		   T1.ProductCode,
		   T1.ProductUnit,
		   T1.PlanQty,
		   T1.ActualQty,
		   T1.DifferenceQty,
		   T1.Reason,
		   T1.BasePrice,
		   T1.Tax,
		   T1.Discount,
		   T1.NetPrice,
		   T1.Deposit,
		   T1.IsReturn,
		   T1.CreateTime,
		   T1.IsFree,
		   T1.ItemSequence,
		   T1.ItemNumber,
		   T1.ItemCategory,
		   T1.Tax2
		FROM DSD_T_DeliveryItem AS T1
		INNER JOIN DSD_T_DeliveryHeader AS T2 ON T1.DeliveryNo = T2.DeliveryNo
		WHERE T2.VisitId UPLOAD_UNIQUE_ID_VALUES_MARK AND T1.dirty != '1' AND T1.dirty != '2'
  
  ''';

  static const String VISIT_DSD_T_TruckStock_Sql_Find =
  ''' 
  		SELECT TruckId,
		   ShipmentNo,
		   ProductCode,
		   ProductUnit,
		   StockQty,
		   SaleableQty,
		   CreateTime
		FROM DSD_T_TruckStock
		WHERE dirty != '1' AND dirty != '2'
  
  ''';

  static const String VISIT_DSD_T_TruckStockTracking_Sql_Find =
  ''' 
		SELECT Id,
		   TruckId,
		   ShipmentNo,
		   TrackingTime,
		   ProductCode,
		   ProductUnit,
		   ChangeAction,
		   ChangeQuantity,
		   FromQty,
		   ToQty,
		   CreateTime
		FROM DSD_T_TruckStockTracking
		WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK AND dirty != '1' AND dirty != '2'
  
  ''';

  static const String VISIT_MD_Account_Sql_Find =
  ''' 
		SELECT
		   T1.AccountNumber,
		   T1.NoteToDriver__c,
		   Geo_Longitude,
		   Geo_Latitude,
		   T1.Usercode
		FROM MD_Account AS T1
		INNER JOIN DSD_T_Visit AS T2 ON T1.AccountNumber = T2.AccountNumber
		WHERE T2.VisitId UPLOAD_UNIQUE_ID_VALUES_MARK AND T1.dirty != '1' AND T1.dirty != '2'
	
  ''';
}