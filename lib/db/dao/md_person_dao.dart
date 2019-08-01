import 'package:dsd/db/table/entity/md_person_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/1 10:27

@dao
abstract class MdPersonDao {
  @Query('SELECT * FROM MD_Person')
  Future<List<MD_Person_Entity>> findAll();

  @Query('SELECT * FROM MD_Person WHERE id = :id')
  Future<MD_Person_Entity> findEntityById(String id);

}