import 'dart:async';
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/dao/app_log_dao.dart';
import 'package:dsd/db/dao/dsd_m_delivery_header_dao.dart';
import 'package:dsd/db/dao/md_person_dao.dart';
import 'package:dsd/db/dao/sync_download_logic_dao.dart';
import 'package:dsd/db/dao/sync_photo_upload_dao.dart';
import 'package:dsd/db/dao/sync_upload_dao.dart';
import 'package:dsd/db/table/app_log_entity.dart';
import 'package:dsd/db/table/entity/app_config_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_item_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_shipment_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_shipment_item_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_system_config_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_truck_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_item_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_truck_stock_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_truck_stock_tracking_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_visit_entity.dart';
import 'package:dsd/db/table/entity/md_account_entity.dart';
import 'package:dsd/db/table/entity/md_contact_entity.dart';
import 'package:dsd/db/table/entity/md_dictionary_entity.dart';
import 'package:dsd/db/table/entity/md_person_entity.dart';
import 'package:dsd/db/table/entity/md_product_entity.dart';
import 'package:dsd/db/table/sync_download_logic_entity.dart';
import 'package:dsd/db/table/sync_photo_upload_entity.dart';
import 'package:dsd/db/table/sync_upload_entity.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/app_config_dao.dart';
import 'dao/dsd_m_delivery_item_dao.dart';
import 'dao/dsd_m_shipment_header_dao.dart';
import 'dao/dsd_m_shipment_item_dao.dart';
import 'dao/dsd_m_system_config_dao.dart';
import 'dao/dsd_m_truck_dao.dart';
import 'dao/dsd_t_delivery_header_dao.dart';
import 'dao/dsd_t_delivery_item_dao.dart';
import 'dao/dsd_t_shipment_header_dao.dart';
import 'dao/dsd_t_shipment_item_dao.dart';
import 'dao/dsd_t_truck_stock_dao.dart';
import 'dao/dsd_t_truck_stock_tracking_dao.dart';
import 'dao/dsd_t_visit_dao.dart';
import 'dao/md_account_dao.dart';
import 'dao/md_contact_dao.dart';
import 'dao/md_dictionary_dao.dart';
import 'dao/md_product_dao.dart';

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
  AppConfigEntity,
  DSD_M_DeliveryHeader_Entity,
  DSD_M_DeliveryItem_Entity,
  DSD_M_ShipmentHeader_Entity,
  DSD_M_ShipmentItem_Entity,
  DSD_M_SystemConfig_Entity,
  DSD_M_Truck_Entity,
  DSD_T_DeliveryHeader_Entity,
  DSD_T_DeliveryItem_Entity,
  DSD_T_ShipmentHeader_Entity,
  DSD_T_ShipmentItem_Entity,
  DSD_T_TruckStock_Entity,
  DSD_T_TruckStockTracking_Entity,
  DSD_T_Visit_Entity,
  MD_Account_Entity,
  MD_Contact_Entity,
  MD_Dictionary_Entity,
  MD_Person_Entity,
  MD_Product_Entity
])
abstract class AppDatabase extends FloorDatabase {
  AppLogDao get appLogDao;
  SyncDownloadLogicDao get syncDownloadLogicDao;
  SyncPhotoUploadDao get syncPhotoUploadDao;
  SyncUploadDao get syncUploadDao;
  AppConfigDao get appConfigDao;
  DSD_M_DeliveryHeader_Dao mDeliveryHeaderDao;
  DSD_M_DeliveryItem_Dao mDeliveryItemDao;
  DSD_M_ShipmentHeader_Dao mShipmentHeaderDao;
  DSD_M_ShipmentItem_Dao mShipmentItemDao;
  DSD_M_SystemConfig_Dao mSystemConfigDao;
  DSD_M_Truck_Dao mTruckDao;
  DSD_T_DeliveryHeader_Dao tDeliveryHeaderDao;
  DSD_T_DeliveryItem_Dao tDeliveryItemDao;
  DSD_T_ShipmentHeader_Dao tShipmentHeaderDao;
  DSD_T_ShipmentItem_Dao tShipmentItemDao;
  DSD_T_TruckStock_Dao tTruckStockDao;
  DSD_T_TruckStockTracking_Dao tTruckStockTrackingDao;
  DSD_T_Visit_Dao tVisitDao;
  MD_Account_Dao accountDao;
  MD_Contact_Dao contactDao;
  MD_Dictionary_Dao dictionaryDao;
  MD_Person_Dao personDao;
  MD_Product_Dao productDao;

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
