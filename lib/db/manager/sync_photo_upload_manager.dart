import 'package:dsd/db/dao/sync_photo_upload_dao.dart';
import 'package:dsd/db/database.dart';
import 'package:dsd/db/table/sync_photo_upload_entity.dart';
import 'package:uuid/uuid.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-02-27 16:33

class SyncPhotoUploadManager{

  static Future<void> deleteAndInsert(final SyncPhotoUploadEntity entity) async {
    SyncPhotoUploadDao dao = DbHelper().database.syncPhotoUploadDao;

    SyncPhotoUploadEntity result = await dao.findEntityByFilePath(entity.filePath);

    if(result == null){
      entity.id = new Uuid().v1();
      await dao.insertEntity(entity);
    }else{
      entity.id = result.id;
      await dao.deleteById(result.id);
      await dao.insertEntity(entity);
    }
  }
}