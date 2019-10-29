import 'package:dsd/synchronization/base/abstract_sync_upload_model.dart';
import 'package:dsd/synchronization/bean/table_uploade_bean.dart';
import 'package:dsd/synchronization/sql/checkout_model_sql_find.dart';
import 'package:dsd/synchronization/sql/checkout_model_sql_update.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/23 15:20

class SyncUploadCheckOutModel extends AbstractSyncUploadModel {
  SyncUploadCheckOutModel(SyncType syncType,
      {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync})
      : super(syncType, syncParameter: syncParameter, onSuccessSync: onSuccessSync, onFailSync: onFailSync);

  @override
  List<TableUploadBean> getTableUploadList() {
    List<TableUploadBean> uploadBeanList = [];

    TableUploadBean shipmentHeader = new TableUploadBean('DSD_T_ShipmentHeader',
        CheckOutModelSqlFind.CHECKOUT_DSD_T_ShipmentHeader_Sql_Find,
        CheckOutModelSqlUpdate.CHECKOUT_DSD_T_ShipmentHeader_Sql_Update, getUploadUniqueIdValues());

    TableUploadBean shipmentItem = new TableUploadBean('DSD_T_ShipmentItem',
        CheckOutModelSqlFind.CHECKOUT_DSD_T_ShipmentItem_Sql_Find,
        CheckOutModelSqlUpdate.CHECKOUT_DSD_T_ShipmentItem_Sql_Update, getUploadUniqueIdValues());

    TableUploadBean stock = new TableUploadBean('DSD_T_TruckStock',
        CheckOutModelSqlFind.CHECKOUT_DSD_T_TruckStock_Sql_Find,
        CheckOutModelSqlUpdate.CHECKOUT_DSD_T_TruckStock_Sql_Update, getUploadUniqueIdValues());

    TableUploadBean stockTracking = new TableUploadBean('DSD_T_TruckStockTracking',
        CheckOutModelSqlFind.CHECKOUT_DSD_T_TruckStockTracking_Sql_Find,
        CheckOutModelSqlUpdate.CHECKOUT_DSD_T_TruckStockTracking_Sql_Update, getUploadUniqueIdValues());


    uploadBeanList.add(shipmentHeader);
    uploadBeanList.add(shipmentItem);
    uploadBeanList.add(stock);
    uploadBeanList.add(stockTracking);

    return uploadBeanList;
  }
}