import 'package:dsd/common/business_const.dart';
import 'package:dsd/db/table/entity/app_config_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_shipment_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_shipment_item_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_system_config_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_truck_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class DSD_M_Truck_Dao {
  @Query('SELECT * FROM DSD_M_Truck')
  Future<List<DSD_M_Truck_Entity>> findAll();

  @insert
  Future<void> insertEntity(DSD_M_Truck_Entity entity);

  @delete
  Future<int> deleteEntity(List<DSD_M_Truck_Entity> entityList);

  @Query('DELETE FROM DSD_M_Truck WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM DSD_M_Truck')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(DSD_M_Truck_Entity entity);
}
