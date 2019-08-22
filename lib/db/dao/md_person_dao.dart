import 'package:dsd/db/table/entity/md_person_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/1 10:27

@dao
abstract class MD_Person_Dao {
  @Query('SELECT * FROM MD_Person')
  Future<List<MD_Person_Entity>> findAll();

  @Query('SELECT * FROM MD_Person WHERE UserCode = :UserCode')
  Future<MD_Person_Entity> findEntityByUserCode(String UserCode);

  @insert
  Future<void> insertEntity(MD_Person_Entity entity);

  @delete
  Future<int> deleteEntity(List<MD_Person_Entity> entityList);

  @Query('DELETE FROM MD_Person WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM DSD_M_DeliveryHeader')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(MD_Person_Entity entity);

  @Query('SELECT * FROM MD_Person WHERE id = :id')
  Future<MD_Person_Entity> findEntityById(String id);
}
