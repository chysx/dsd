import 'package:dsd/db/manager/visit_manager.dart';
import 'package:dsd/db/table/entity/dsd_t_visit_entity.dart';
import 'package:dsd/synchronization/sync/sync_dirty_status.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/11 14:11

class TaskVisitUtil {
  static Future<bool> isNeedCreateVisit(String shipmentNo, String accountNumber) async {
    DSD_T_Visit_Entity visitEntity = await VisitManager.getVisitLastly(shipmentNo,accountNumber);
    if (visitEntity != null
        && visitEntity.dirty != SyncDirtyStatus.FAIL
        && visitEntity.dirty != SyncDirtyStatus.SUCCESS
        && visitEntity.dirty != SyncDirtyStatus.EXIST){
      return false;
    }
    return true;
  }
}