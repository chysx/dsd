import 'package:dsd/db/table/sync_upload_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 17:00

@dao
abstract class SyncUploadDao {
  @Query('SELECT * FROM sync_upload')
  Future<List<SyncUploadEntity>> findAll();

  @Query('SELECT * FROM sync_upload WHERE id = :id')
  Future<SyncUploadEntity> findEntityById(String id);

  @Query('SELECT * FROM sync_upload WHERE uniqueIdValues = :unique and type = :type')
  Future<SyncUploadEntity> findEntityByUniqueIdAndType(String unique, String type);

  @Query('SELECT * FROM sync_upload WHERE type = :type')
  Future<List<SyncUploadEntity>> findEntityByType(String type);

  @Query('SELECT * FROM sync_upload WHERE time > :time')
  Future<List<SyncUploadEntity>> findEntityByTime(String time);

  @Query('SELECT * FROM sync_upload WHERE status = :status')
  Future<List<SyncUploadEntity>> findEntityByStatus(String status);

  @insert
  Future<void> insertEntity(SyncUploadEntity entity);

  @insert
  Future<List<int>> insertEntityList(List<SyncUploadEntity> entityList);

  @delete
  Future<int> deleteEntity(List<SyncUploadEntity> entityList);
}
