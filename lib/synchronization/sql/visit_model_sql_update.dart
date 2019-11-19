/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/23 12:33

class VisitModelSqlUpdate {
  static const String VISIT_DSD_T_Visit_Sql_Update =
  ''' 
		UPDATE DSD_T_Visit SET dirty = ?
		WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK
	
  ''';

  static const String VISIT_DSD_T_DeliveryHeader_Sql_Update =
  ''' 
		UPDATE DSD_T_DeliveryHeader SET dirty = ?
		WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK
  
  ''';

  static const String VISIT_DSD_T_DeliveryItem_Sql_Update =
  ''' 
		UPDATE DSD_T_DeliveryItem SET dirty = ?
		WHERE DeliveryNo IN (SELECT DISTINCT DeliveryNo FROM DSD_T_DeliveryHeader WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK)
  
  ''';

  static const String VISIT_DSD_T_TruckStock_Sql_Update =
  ''' 
		UPDATE DSD_T_TruckStock SET dirty = ?
		WHERE dirty != '1' AND dirty != '2'
  
  ''';

  static const String VISIT_DSD_T_TruckStockTracking_Sql_Update =
  ''' 
		UPDATE DSD_T_TruckStockTracking SET dirty = ?
		WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK AND dirty != '1' AND dirty != '2'
  
  ''';

  static const String VISIT_MD_Account_Sql_Update =
  ''' 
    UPDATE MD_Account SET dirty = ?
		WHERE AccountNumber IN (SELECT DISTINCT AccountNumber FROM DSD_T_Visit WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK)
  ''';
}