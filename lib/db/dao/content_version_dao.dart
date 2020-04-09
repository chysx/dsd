import 'package:dsd/db/table/entity/content_version.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class ContentVersionDao {
  @Query('SELECT * FROM ContentVersion')
  Future<List<ContentVersionEntity>> findAll();

  @Query('SELECT * FROM ContentVersion WHERE ParentId__c = :deliveryId')
  Future<ContentVersionEntity> findEntityByDeliveryId(String deliveryId);

  @insert
  Future<void> insertEntity(ContentVersionEntity entity);

  @delete
  Future<int> deleteEntity(List<ContentVersionEntity> entityList);

  @Query('DELETE FROM ContentVersion WHERE ParentId__c = :deliveryId')
  Future<void> deleteById(String deliveryId);

  @Query('DELETE FROM ContentVersion')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(ContentVersionEntity entity);
}
