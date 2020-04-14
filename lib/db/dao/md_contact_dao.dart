
import 'package:dsd/db/table/entity/md_contact_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class MD_Contact_Dao {
  @Query('SELECT * FROM MD_Contact')
  Future<List<MD_Contact_Entity>> findAll();

  @Query('SELECT * FROM MD_Contact WHERE accountnumber__c = :accountNumber')
  Future<MD_Contact_Entity> findEntityByAccountNumber(String accountNumber);

  @insert
  Future<void> insertEntity(MD_Contact_Entity entity);

  @delete
  Future<int> deleteEntity(List<MD_Contact_Entity> entityList);

  @Query('DELETE FROM MD_Contact WHERE pid = :pid')
  Future<void> deleteById(String pid);

  @Query('DELETE FROM MD_Contact')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(MD_Contact_Entity entity);
}
