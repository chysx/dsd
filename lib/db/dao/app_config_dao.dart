import 'package:dsd/db/table/entity/app_config_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class AppConfigDao {
  @Query('SELECT * FROM app_config')
  Future<List<AppConfigEntity>> findAll();

  @Query('SELECT * FROM app_config WHERE userCode = :userCode')
  Future<AppConfigEntity> findEntityByUserCode(String userCode);

  @insert
  Future<void> insertEntity(AppConfigEntity entity);

  @delete
  Future<int> deleteEntity(List<AppConfigEntity> entityList);

  @Query('DELETE FROM app_config WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM app_config')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(AppConfigEntity entity);
}
