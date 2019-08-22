
import 'package:dsd/db/table/entity/dsd_t_truck_stock_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_truck_stock_tracking_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class DSD_T_TruckStockTracking_Dao {
  @Query('SELECT * FROM DSD_T_TruckStockTracking')
  Future<List<DSD_T_TruckStockTracking_Entity>> findAll();

  @insert
  Future<void> insertEntity(DSD_T_TruckStockTracking_Entity entity);

  @delete
  Future<int> deleteEntity(List<DSD_T_TruckStockTracking_Entity> entityList);

  @Query('DELETE FROM DSD_T_TruckStockTracking WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM DSD_T_TruckStockTracking')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(DSD_T_TruckStockTracking_Entity entity);
}
