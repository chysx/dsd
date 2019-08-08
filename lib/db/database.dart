import 'dart:async';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/dao/app_log_dao.dart';
import 'package:dsd/db/dao/md_person_dao.dart';
import 'package:dsd/db/dao/sync_download_logic_dao.dart';
import 'package:dsd/db/dao/sync_photo_upload_dao.dart';
import 'package:dsd/db/dao/sync_upload_dao.dart';
import 'package:dsd/db/table/app_log_entity.dart';
import 'package:dsd/db/table/entity/app_config_entity.dart';
import 'package:dsd/db/table/entity/md_person_entity.dart';
import 'package:dsd/db/table/sync_download_logic_entity.dart';
import 'package:dsd/db/table/sync_photo_upload_entity.dart';
import 'package:dsd/db/table/sync_upload_entity.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/app_config_dao.dart';

part 'database.g.dart'; // the generated code will be there

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 16:20

@Database(version: 1, entities: [
  AppLogEntity,
  SyncDownloadLogicEntity,
  SyncUploadEntity,
  SyncPhotoUploadEntity,
  MD_Person_Entity,
  AppConfigEntity
])
abstract class AppDatabase extends FloorDatabase {
  AppLogDao get appLogDao;

  SyncDownloadLogicDao get syncDownloadLogicDao;

  SyncPhotoUploadDao get syncPhotoUploadDao;

  SyncUploadDao get syncUploadDao;

  MdPersonDao get mdPersonDao;

  AppConfigDao get appConfigDao;
}

class DbHelper {
  static DbHelper _instance;
  AppDatabase database;

  DbHelper._();

  static DbHelper _getInstance() {
    if (_instance == null) {
      _instance = new DbHelper._();
      _initDatabase(_instance);
    }
    return _instance;
  }

  static _initDatabase(DbHelper dbHelper) async {
    dbHelper.database =
        await $FloorAppDatabase.databaseBuilder(Constant.DB_NAME).build();
  }

  factory DbHelper() => _getInstance();
}
