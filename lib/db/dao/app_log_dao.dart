import 'package:dsd/db/table/app_log_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 16:25

@dao
abstract class AppLogDao {
  @Query('SELECT * FROM app_log')
  Future<List<AppLogEntity>> findAll();

  @Query('SELECT * FROM app_log WHERE id = :id')
  Future<AppLogEntity> findEntityById(String id);

  @insert
  Future<void> insertEntity(AppLogEntity entity);
}
