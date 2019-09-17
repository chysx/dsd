
import 'package:dsd/db/table/entity/dsd_t_truck_stock_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class DSD_T_TruckStock_Dao {
  @Query('SELECT * FROM DSD_T_TruckStock')
  Future<List<DSD_T_TruckStock_Entity>> findAll();

  @insert
  Future<void> insertEntity(DSD_T_TruckStock_Entity entity);

  @delete
  Future<int> deleteEntity(List<DSD_T_TruckStock_Entity> entityList);

  @Query('DELETE FROM DSD_T_TruckStock WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM DSD_T_TruckStock')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(DSD_T_TruckStock_Entity entity);

  @Query('SELECT * FROM DSD_T_TruckStock WHERE truckId = :truckId AND shipmentNo = :shipmentNo AND productCode = :productCode AND productUnit = :productUnit ')
  Future<DSD_T_TruckStock_Entity> findEntityByCon(int truckId,String shipmentNo,String productCode,String productUnit);

  @Query('SELECT * FROM DSD_T_TruckStock WHERE shipmentNo = :shipmentNo')
  Future<List<DSD_T_TruckStock_Entity>> findEntityByShipment(String shipmentNo);
}
