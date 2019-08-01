import 'package:dsd/db/table/sync_download_logic_entity.dart';
import 'package:floor/floor.dart';
/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 16:57

@dao
abstract class SyncDownloadLogicDao {
  @Query('SELECT * FROM sync_download_logic')
  Future<List<SyncDownloadLogicEntity>> findAll();

  @Query('SELECT * FROM sync_download_logic WHERE tableName = :tableName')
  Future<SyncDownloadLogicEntity> findEntityById(String tableName);

  @insert
  Future<void> insertEntity(SyncDownloadLogicEntity entity);

  @Query('SELECT * FROM sync_download_logic WHERE version = :version AND isActive = :isActive ')
  Future<List<SyncDownloadLogicEntity>> findEntityByVersion(String version,String isActive);

}