/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/23 12:33

class PhotoModelSqlUpdate {
  static const String PHOTO_CONTENT_VERSION_SQL_UPDATE =
  ''' 
		UPDATE ContentVersion SET dirty = ?
		WHERE ParentId__c IN (SELECT DISTINCT Id FROM DSD_T_DeliveryHeader WHERE VisitId UPLOAD_UNIQUE_ID_VALUES_MARK)

  ''';
}