/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/23 14:36

class CheckInModelSqlFind {
  static const String CHECKIN_DSD_T_ShipmentHeader_Sql_Find =
  ''' 
SELECT Id,
		   ShipmentNo,
		   ShipmentDate,
		   ActionType,
		   StartTime,
		   EndTime,
		   Odometer,
		   Checker,
		   CheckerConfirm,
       CheckerConfirmTime,
		   CheckerSignImg,
       DCheckerSignImg,
		   Cashier,
       CashierConfirm,
		   CashierConfirmTime,
       CashierSignImg,
		   DCashierSignImg,
       Gatekeeper,
		   GKConfirm,
       GKConfirmTime,
		   GKSignImg,
       DGKSignImg,
		   WarehouseCode,
       Status,
		   Driver,
       TruckId,
		   TotalAmount,
       TotalWeight,
		   WeightUnit,
		   CreateTime,
		   ScanResult,
		   Manually
		FROM DSD_T_ShipmentHeader
		WHERE ShipmentNo UPLOAD_UNIQUE_ID_VALUES_MARK AND ActionType = 'CHKI' AND dirty != '1' AND dirty != '2'
	
  ''';

  static const String CHECKIN_DSD_T_ShipmentItem_Sql_Find =
  ''' 
		SELECT T1.HeaderId,
		   T1.ProductCode,
		   T1.ProductUnit,
		   T1.PlanQty,
		   T1.ActualQty,
		   T1.DifferenceQty,
		   T1.DifferenceReason,
		   T1.CreateTime
		FROM DSD_T_ShipmentItem AS T1
		INNER JOIN DSD_T_ShipmentHeader AS T2 ON T1.HeaderId = T2.Id
		WHERE T2.ShipmentNo UPLOAD_UNIQUE_ID_VALUES_MARK AND T2.ActionType = 'CHKI' AND T1.dirty != '1' AND T1.dirty != '2'
  
  ''';

  static const String CHECKIN_DSD_T_TruckStock_Sql_Find =
  ''' 
		SELECT TruckId,
		   ShipmentNo,
		   ProductCode,
		   ProductUnit,
		   StockQty,
		   SaleableQty,
		   CreateTime
		FROM DSD_T_TruckStock
		WHERE ShipmentNo UPLOAD_UNIQUE_ID_VALUES_MARK AND dirty != '1' AND dirty != '2'
  
  ''';

  static const String CHECKIN_DSD_T_TruckStockTracking_Sql_Find =
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
		WHERE ShipmentNo UPLOAD_UNIQUE_ID_VALUES_MARK AND ChangeAction = 'CHKI' AND dirty != '1' AND dirty != '2'
  
  ''';
}