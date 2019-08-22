import 'package:dsd/db/table/entity/app_config_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_item_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class DSD_M_DeliveryItem_Dao {
  @Query('SELECT * FROM DSD_M_DeliveryItem')
  Future<List<DSD_M_DeliveryItem_Entity>> findAll();

  @Query('SELECT * FROM DSD_M_DeliveryItem WHERE DeliveryNo = :DeliveryNo')
  Future<List<DSD_M_DeliveryItem_Entity>> findEntityByDeliveryNo(String DeliveryNo);

  @insert
  Future<void> insertEntity(DSD_M_DeliveryItem_Entity entity);

  @delete
  Future<int> deleteEntity(List<DSD_M_DeliveryItem_Entity> entityList);

  @Query('DELETE FROM DSD_M_DeliveryItem WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM DSD_M_DeliveryItem')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(DSD_M_DeliveryItem_Entity entity);
}
