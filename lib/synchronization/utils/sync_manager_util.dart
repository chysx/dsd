import 'package:dsd/application.dart';
import 'package:dsd/db/table/sync_photo_upload_entity.dart';
import 'package:dsd/db/table/sync_upload_entity.dart';
import 'package:dsd/model/visit_model.dart';
import 'package:dsd/net/http_config.dart';
import 'package:dsd/synchronization/sync/sync_constant.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_status.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/utils/sync_sql_util.dart';
import 'package:dsd/ui/page/sync/sync_info.dart';
import 'package:flustars/flustars.dart';

import '../sync_factory.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/28 16:57

class SyncManagerUtil{

   static Future<List<SyncInfo>> getSyncInfoList(SyncType syncType) async {
    List<SyncInfo> syncInfoList = [];
    List<SyncUploadEntity> syncUploadEntityList = await Application.database.syncUploadDao.findEntityByType(syncType.toString());
    for(SyncUploadEntity entity in syncUploadEntityList){
      SyncInfo syncInfo = new SyncInfo();
      syncInfo.name = entity.name;
      syncInfo.status = entity.status;
      if(entity.time != null){
        String hour = entity.time.split(" ")[1];
        syncInfo.time = hour;
      }
      syncInfo.syncMode = SyncFactory.createSyncModel(syncType);
      SyncParameter parameter = new SyncParameter();
      parameter.putUploadName([entity.name]);
      parameter.putUploadUniqueIdValues(SyncSqlUtil.getUniqueIdValuesByString(entity.uniqueIdValues));
      syncInfo.syncMode.syncParameter = parameter;
      syncInfoList.add(syncInfo);
    }
    return syncInfoList;
  }

   static Future<List<SyncInfo>> getSyncInfoListByPhoto(SyncType syncType) async {
     List<SyncInfo> syncInfoList = [];

     String date = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.YEAR_MONTH_DAY);

     List<SyncPhotoUploadEntity> syncUploadEntityList = await Application.database.syncPhotoUploadDao.findEntityByTime(date);
     for(SyncPhotoUploadEntity entity in syncUploadEntityList){
       SyncInfo syncInfo = new SyncInfo();
       syncInfo.name = entity.name;
       syncInfo.status = entity.status;
       if(entity.time != null){
         String hour = entity.time.split(" ")[1];
         syncInfo.time = hour;
       }
       syncInfo.syncMode = SyncFactory.createSyncModel(SyncType.SYNC_UPLOAD_PHOTO);
       SyncParameter parameter = new SyncParameter();
       parameter.putUploadName([entity.name]);
       parameter.putCommon(SyncConstant.FILE_PATH,entity.filePath);
       syncInfo.syncMode.syncParameter = parameter;
       syncInfoList.add(syncInfo);
     }
     return syncInfoList;
   }


   static Future<void> refreshStatus() async {
     await refreshStatusByData();
     await refreshStatusByPhoto();
   }

   static Future<void> refreshStatusByData() async {
     String nowDate = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.NORMAL);

     List<SyncUploadEntity> list = await Application.database.syncUploadDao.findEntityByStatus(SyncStatus.SYNC_LOAD.toString());

     List<SyncUploadEntity> resultList = [];
     for(SyncUploadEntity entity in list){
       int offsetTime = DateUtil.getDateMsByTimeStr(nowDate) - DateUtil.getDateMsByTimeStr(entity.time);
       print('offsetTime = $offsetTime}');
       int timeOut = TimeOut.CONNECT_TIMEOUT + TimeOut.READ_TIMEOUT + TimeOut.READ_TIMEOUT;
       if(offsetTime > timeOut){
         entity.status = SyncStatus.SYNC_FAIL.toString();
         resultList.add(entity);
       }
     }

     await Application.database.syncUploadDao.insertEntityList(resultList);
   }

   static Future<void> refreshStatusByPhoto() async {
     String nowDate = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.NORMAL);

     List<SyncPhotoUploadEntity> list = await Application.database.syncPhotoUploadDao.findEntityByStatus(SyncStatus.SYNC_LOAD.toString());

     List<SyncPhotoUploadEntity> resultList = [];
     for(SyncPhotoUploadEntity entity in list){
       int offsetTime = DateUtil.getDateMsByTimeStr(nowDate) - DateUtil.getDateMsByTimeStr(entity.time);
       print('offsetTime = $offsetTime}');
       int timeOut = TimeOut.CONNECT_TIMEOUT + TimeOut.READ_TIMEOUT + TimeOut.READ_TIMEOUT;
       if(offsetTime > timeOut){
         entity.status = SyncStatus.SYNC_FAIL.toString();
         resultList.add(entity);
       }
     }

     await Application.database.syncPhotoUploadDao.insertEntityList(resultList);
   }
}