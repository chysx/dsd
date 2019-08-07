import 'package:dsd/db/dao/app_log_dao.dart';
import 'package:dsd/db/table/app_log_entity.dart';
import 'package:dsd/synchronization/sync/sync_constant.dart';
import 'package:dsd/synchronization/model/sync_init_model.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/sync_manager.dart';

import 'db/database.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/31 17:30

class Test {
  static void testSyncInit() {

  }

//  static Future testFloor() async {
//    SyncDownloadLogicDao dao = DbHelper().database.syncDownloadLogicDao;
//    SyncDownloadLogicEntity item = await dao.findEntityById("MD_Person");
//    print(item);
//  }

  static Future testFloor() async {
    AppLogDao dao = DbHelper().database.appLogDao;
    List<AppLogEntity> list = await dao.findAll();
    for (var item in list) {
      print(item);
    }
  }
}
