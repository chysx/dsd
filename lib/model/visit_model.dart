import 'package:dsd/db/manager/visit_manager.dart';
import 'package:dsd/db/table/entity/dsd_t_visit_entity.dart';
import 'package:dsd/synchronization/sync/sync_dirty_status.dart';
import 'package:flustars/flustars.dart';
import 'package:uuid/uuid.dart';

import '../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/21 17:27

class VisitModel {
  static VisitModel _instance;

  VisitModel._();

  static VisitModel _getInstance() {
    if (_instance == null) {
      _instance = new VisitModel._();
    }
    return _instance;
  }

  factory VisitModel() => _getInstance();

  DSD_T_Visit_Entity visit;

  Future initData(String shipmentNo,String accountNumber) async {
    if (await VisitManager.isVisitCompleteByCustomer(shipmentNo, accountNumber)) {
      visit = await VisitManager.getVisitLastly(shipmentNo, accountNumber);
    } else {
      visit = VisitManager.createVisit(shipmentNo, accountNumber,'');
      await Application.database.tVisitDao.insertEntity(visit);
    }
  }

  Future updateVisit(String endTime) async {
    visit.EndTime = endTime;
    await Application.database.tVisitDao.updateEntity(visit);
  }

}