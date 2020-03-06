import 'package:dsd/db/table/sync_photo_upload_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 17:01

@dao
abstract class SyncPhotoUploadDao {
  @Query('SELECT * FROM sync_photo_upload')
  Future<List<SyncPhotoUploadEntity>> findAll();

  @Query('SELECT * FROM sync_photo_upload WHERE id = :id')
  Future<SyncPhotoUploadEntity> findEntityById(String id);

  @Query('SELECT * FROM sync_photo_upload WHERE filePath = :filePath')
  Future<SyncPhotoUploadEntity> findEntityByFilePath(String filePath);

  @Query('SELECT * FROM sync_photo_upload WHERE time > :time')
  Future<List<SyncPhotoUploadEntity>> findEntityByTime(String time);

  @Query('SELECT * FROM sync_photo_upload WHERE status = :status')
  Future<List<SyncPhotoUploadEntity>> findEntityByStatus(String status);


  @insert
  Future<void> insertEntity(SyncPhotoUploadEntity entity);

  @insert
  Future<List<int>> insertEntityList(List<SyncPhotoUploadEntity> entityList);


  @Query('DELETE FROM sync_photo_upload WHERE id = :id')
  Future<void> deleteById(String id);
}
