import 'package:dsd/application.dart';
import 'package:dsd/db/database.dart';
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

  static Future<AppConfigEntity> queryByUserCode(String userCode) async {
    return await Application.database.appConfigDao.findEntityByUserCode(userCode);
  }

  static Future<List<AppConfigEntity>> queryAll() async {
    return await Application.database.appConfigDao.findAll();
  }

  static deleteById(String id) async {
    await Application.database.appConfigDao.deleteById(id);
  }

  static update(AppConfigEntity entity) async {
    await Application.database.appConfigDao.updateEntity(entity);
  }
}
