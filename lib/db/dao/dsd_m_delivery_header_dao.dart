import 'package:dsd/db/table/entity/app_config_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_header_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class DSD_M_DeliveryHeader_Dao {
  @Query('SELECT * FROM DSD_M_DeliveryHeader')
  Future<List<DSD_M_DeliveryHeader_Entity>> findAll();

  @Query('SELECT * FROM DSD_M_DeliveryHeader WHERE DeliveryNo = :DeliveryNo')
  Future<DSD_M_DeliveryHeader_Entity> findEntityByDeliveryNo(String DeliveryNo);

  @insert
  Future<void> insertEntity(DSD_M_DeliveryHeader_Entity entity);

  @delete
  Future<int> deleteEntity(List<DSD_M_DeliveryHeader_Entity> entityList);

  @Query('DELETE FROM DSD_M_DeliveryHeader WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM DSD_M_DeliveryHeader')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(DSD_M_DeliveryHeader_Entity entity);

  @Query('SELECT * FROM DSD_M_DeliveryHeader WHERE shipmentNo = :shipmentNo AND accountNumber = :accountNumber ORDER BY DeliverySequence ASC')
  Future<List<DSD_M_DeliveryHeader_Entity>> findEntityByCon(String shipmentNo,String accountNumber);
}
