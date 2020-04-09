/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/23 12:27

class PhotoModelSqlFind {
  static const String PHOTO_CONTENT_VERSION_SQL_FIND =
  ''' 
  		SELECT T1.Id,
  		 T1.Title,
		   T1.PathOnClient,
		   T1.ParentId__c,
		   T1.VersionData 
		FROM ContentVersion T1 
		INNER JOIN DSD_T_DeliveryHeader AS T2 ON T1.ParentId__c = T2.Id
		WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK AND T1.dirty != '1' AND T1.dirty != '2'
	
  ''';
}