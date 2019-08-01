import 'package:dsd/db/dao/sync_upload_dao.dart';
import 'package:dsd/db/database.dart';
import 'package:dsd/db/table/sync_upload_entity.dart';
import 'package:dsd/synchronization/sync/sync_status.dart';
import 'package:uuid/uuid.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 17:36

class SyncUploadManager {

  static Future inset(SyncUploadEntity entity) async {
    SyncUploadDao dao = DbHelper().database.syncUploadDao;
    await dao.insertEntity(entity);
  }

    static Future deleteAndInsert(SyncUploadEntity entity) async {
    final SyncUploadDao dao = DbHelper().database.syncUploadDao;

    if(entity.uniqueIdValues == null || entity.uniqueIdValues.length == 0){
      if(entity.status == SyncStatus.SYNC_LOAD.toString()) return;//如果没有关键字UniqueIdValues，load状态不用保存到数据，不然就会有两条数据
      entity.id = new Uuid().v1();                          //（如果有关键字UniqueIdValues，可以根据关键字来跟新状态，不会存在多条）
      entity.uniqueIdValues = new Uuid().v1();
      await dao.insertEntity(entity);
    }else{
      SyncUploadEntity result = await dao.findEntityByUniqueIdAndType(entity.uniqueIdValues, entity.type);
      if(result == null){
        entity.id = new Uuid().v1();
        await dao.insertEntity(entity);
      }else{
        entity.id = result.id;
        await dao.deleteEntity([result]);
        await dao.insertEntity(entity);
      }
    }
  }
}