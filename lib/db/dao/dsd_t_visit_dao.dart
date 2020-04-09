
import 'package:dsd/db/table/entity/dsd_t_visit_entity.dart';
import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:34

@dao
abstract class DSD_T_Visit_Dao {
  @Query('SELECT * FROM DSD_T_Visit')
  Future<List<DSD_T_Visit_Entity>> findAll();

  @Query('SELECT * FROM DSD_T_Visit WHERE Id = :Id')
  Future<DSD_T_Visit_Entity> findEntityById(String Id);

  @Query('SELECT * FROM DSD_T_Visit WHERE guid = :guid')
  Future<DSD_T_Visit_Entity> findEntityByGuid(String guid);

  @insert
  Future<void> insertEntity(DSD_T_Visit_Entity entity);

  @delete
  Future<int> deleteEntity(List<DSD_T_Visit_Entity> entityList);

  @Query('DELETE FROM DSD_T_Visit WHERE id = :id')
  Future<void> deleteById(String id);

  @Query('DELETE FROM DSD_T_Visit')
  Future<void> deleteAll();

  @update
  Future<int> updateEntity(DSD_T_Visit_Entity entity);

  @Query('SELECT * FROM DSD_T_Visit WHERE ShipmentNo = :ShipmentNo AND AccountNumber = :AccountNumber ORDER BY StartTime DESC')
  Future<List<DSD_T_Visit_Entity>> findEntityByCon(String ShipmentNo,String AccountNumber);
}
