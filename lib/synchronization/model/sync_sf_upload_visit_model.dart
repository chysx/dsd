import 'package:dsd/synchronization/base/abstract_sync_sf_upload_model.dart';
import 'package:dsd/synchronization/bean/table_uploade_bean.dart';
import 'package:dsd/synchronization/sql/visit_model_sql_find.dart';
import 'package:dsd/synchronization/sql/visit_model_sql_update.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/23 12:20

class SyncSfUploadVisitModel extends AbstractSyncSfUploadModel {
  SyncSfUploadVisitModel(SyncType syncType,
      {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync})
      : super(syncType, syncParameter: syncParameter, onSuccessSync: onSuccessSync, onFailSync: onFailSync);

  @override
  List<TableUploadBean> getTableUploadList() {
    List<TableUploadBean> uploadBeanList = [];

    TableUploadBean visit = new TableUploadBean('DSD_T_Visit',
        VisitModelSqlFind.VISIT_DSD_T_Visit_Sql_Find,
        VisitModelSqlUpdate.VISIT_DSD_T_Visit_Sql_Update, getUploadUniqueIdValues());

    TableUploadBean deliveryHeader = new TableUploadBean('DSD_T_DeliveryHeader',
        VisitModelSqlFind.VISIT_DSD_T_DeliveryHeader_Sql_Find,
        VisitModelSqlUpdate.VISIT_DSD_T_DeliveryHeader_Sql_Update, getUploadUniqueIdValues());

    TableUploadBean deliveryItem = new TableUploadBean('DSD_T_DeliveryItem',
        VisitModelSqlFind.VISIT_DSD_T_DeliveryItem_Sql_Find,
        VisitModelSqlUpdate.VISIT_DSD_T_DeliveryItem_Sql_Update, getUploadUniqueIdValues());

    TableUploadBean stock = new TableUploadBean('DSD_T_TruckStock',
        VisitModelSqlFind.VISIT_DSD_T_TruckStock_Sql_Find,
        VisitModelSqlUpdate.VISIT_DSD_T_TruckStock_Sql_Update, getUploadUniqueIdValues());

    TableUploadBean stockTracking = new TableUploadBean('DSD_T_TruckStockTracking',
        VisitModelSqlFind.VISIT_DSD_T_TruckStockTracking_Sql_Find,
        VisitModelSqlUpdate.VISIT_DSD_T_TruckStockTracking_Sql_Update, getUploadUniqueIdValues());

    TableUploadBean mdAccount = new TableUploadBean('MD_Account',
        VisitModelSqlFind.VISIT_MD_Account_Sql_Find,
        VisitModelSqlUpdate.VISIT_MD_Account_Sql_Update, getUploadUniqueIdValues());


    uploadBeanList.add(visit);
    uploadBeanList.add(deliveryHeader);
    uploadBeanList.add(deliveryItem);
    uploadBeanList.add(stock);
    uploadBeanList.add(stockTracking);
//    uploadBeanList.add(mdAccount);

    return uploadBeanList;
  }
}
