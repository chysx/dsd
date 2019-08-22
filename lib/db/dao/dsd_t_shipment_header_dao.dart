
import 'package:dsd/db/table/entity/dsd_m_shipment_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_header_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class DSD_T_ShipmentHeader_Dao {
  @Query('SELECT * FROM DSD_T_ShipmentHeader')
  Future<List<DSD_T_ShipmentHeader_Entity>> findAll();

  @Query('SELECT * FROM DSD_T_ShipmentHeader WHERE ShipmentNo = :ShipmentNo')
  Future<DSD_T_ShipmentHeader_Entity> findEntityByShipmentNo(String ShipmentNo);

  @insert
  Future<void> insertEntity(DSD_T_ShipmentHeader_Entity entity);

  @delete
  Future<int> deleteEntity(List<DSD_T_ShipmentHeader_Entity> entityList);

  @Query('DELETE FROM DSD_T_ShipmentHeader WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM DSD_T_ShipmentHeader')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(DSD_T_ShipmentHeader_Entity entity);
}
