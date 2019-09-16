import 'package:dsd/common/business_const.dart';
import 'package:dsd/db/table/entity/md_dictionary_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class MD_Dictionary_Dao {
  @Query('SELECT * FROM MD_Dictionary')
  Future<List<MD_Dictionary_Entity>> findAll();

  @Query('SELECT * FROM MD_Dictionary WHERE Category = :Category AND Value = :Value AND Valid = :Valid')
  Future<MD_Dictionary_Entity> findEntityByCon(String Category,String Value,String Valid);

  @insert
  Future<void> insertEntity(MD_Dictionary_Entity entity);

  @delete
  Future<int> deleteEntity(List<MD_Dictionary_Entity> entityList);

  @Query('DELETE FROM MD_Dictionary WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM MD_Dictionary')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(MD_Dictionary_Entity entity);

  @Query('SELECT * FROM MD_Dictionary WHERE Category = :Category AND valid = :valid ORDER BY Sequence ASC')
  Future<List<MD_Dictionary_Entity>> findEntityByCategory(String category,String valid);
}
