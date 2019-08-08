import 'package:dsd/application.dart';
import 'package:dsd/db/table/entity/app_config_entity.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 11:23

class AppConfigManager {
  static Future insert(AppConfigEntity entity) async {
    await Application.database.appConfigDao.insertEntity(entity);
  }

  static deleteAll() async {
    await Application.database.appConfigDao.deleteAll();
  }

  static queryByUserCode(String userCode) async {
    await Application.database.appConfigDao.findEntityById(userCode);
  }

  static deleteByUserCode(String userCode) async {
    await Application.database.appConfigDao.deleteById(userCode);
  }

  static updateByUserCode(AppConfigEntity entity) async {
    await Application.database.appConfigDao.updateEntity(entity);
  }
}
