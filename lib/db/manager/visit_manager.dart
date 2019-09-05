import 'package:dsd/application.dart';
import 'package:dsd/db/table/entity/dsd_t_visit_entity.dart';
import 'package:dsd/synchronization/sync/sync_dirty_status.dart';
import 'package:dsd/utils/string_util.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/4 11:46

class VisitManager {
  ///
  /// 根据门店编号AccountNumber获取最近一次的拜访
  ///
  static Future<DSD_T_Visit_Entity> getVisitLastly(String shipmentNo, String accountNumber) async {
    List<DSD_T_Visit_Entity> list = await Application.database.tVisitDao.findEntityByCon(shipmentNo, accountNumber);
    return list != null && list.length > 0 ? list[0] : null;
  }

  ///
  /// 指定门店是否已经完成拜访（这里的完成拜访表示，有上传数据的动作，不论有没有上传成功）
  ///
  static Future<bool> isVisitCompleteByCustomer(String shipmentNo, String accountNumber) async {
    DSD_T_Visit_Entity visitEntity = await getVisitLastly(shipmentNo, accountNumber);
    if (visitEntity == null) return false;
    if (StringUtil.isEmpty(visitEntity.dirty) ||
        StringUtil.equalsIgnoreCase(visitEntity.dirty, SyncDirtyStatus.DEFAULT)) return false;
    return true;
  }
}
