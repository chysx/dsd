import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class DSD_T_DeliveryHeader_Dao {
  @Query('SELECT * FROM DSD_T_DeliveryHeader')
  Future<List<DSD_T_DeliveryHeader_Entity>> findAll();

  @Query('SELECT * FROM DSD_T_DeliveryHeader WHERE DeliveryNo = :DeliveryNo')
  Future<DSD_T_DeliveryHeader_Entity> findEntityByDeliveryNo(String DeliveryNo);

  @insert
  Future<void> insertEntity(DSD_T_DeliveryHeader_Entity entity);

  @delete
  Future<int> deleteEntity(List<DSD_T_DeliveryHeader_Entity> entityList);

  @Query('DELETE FROM DSD_T_DeliveryHeader WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM DSD_T_DeliveryHeader')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(DSD_T_DeliveryHeader_Entity entity);

  @Query('SELECT * FROM DSD_T_DeliveryHeader WHERE ShipmentNo = :ShipmentNo')
  Future<List<DSD_T_DeliveryHeader_Entity>> findEntityByShipmentNo(String ShipmentNo);

  @Query('SELECT * FROM DSD_T_DeliveryHeader WHERE shipmentNo = :shipmentNo AND accountNumber = :accountNumber')
  Future<List<DSD_T_DeliveryHeader_Entity>> findEntityByCon(String shipmentNo,String accountNumber);
}
