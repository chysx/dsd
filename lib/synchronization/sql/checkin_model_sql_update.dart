/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/23 14:37

class CheckInModelSqlUpdate {
  static const String CHECKIN_DSD_T_ShipmentHeader_Sql_Update =
  ''' 
		UPDATE DSD_T_ShipmentHeader SET dirty = ?
		WHERE ShipmentNo UPLOAD_UNIQUE_ID_VALUES_MARK AND ActionType = 'CHKI'
	
  ''';

  static const String CHECKIN_DSD_T_ShipmentItem_Sql_Update =
  ''' 
		UPDATE DSD_T_ShipmentItem SET dirty = ?
		WHERE HeaderId IN (SELECT DISTINCT Id FROM DSD_T_ShipmentHeader WHERE ShipmentNo UPLOAD_UNIQUE_ID_VALUES_MARK AND ActionType = 'CHKI')
  
  ''';

  static const String CHECKIN_DSD_T_TruckStock_Sql_Update =
  ''' 
		UPDATE DSD_T_TruckStock SET dirty = ? WHERE ShipmentNo UPLOAD_UNIQUE_ID_VALUES_MARK   AND dirty != '1' AND dirty != '2'
  
  ''';

  static const String CHECKIN_DSD_T_TruckStockTracking_Sql_Update =
  ''' 
		UPDATE DSD_T_TruckStockTracking SET dirty = ? WHERE ShipmentNo UPLOAD_UNIQUE_ID_VALUES_MARK AND ChangeAction = 'CHKI' AND dirty != '1' AND dirty != '2'
  
  ''';
}