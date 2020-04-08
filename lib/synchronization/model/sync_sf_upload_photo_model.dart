import 'package:dsd/synchronization/base/abstract_sync_sf_upload_model.dart';
import 'package:dsd/synchronization/bean/table_uploade_bean.dart';
import 'package:dsd/synchronization/sql/photo_model_sql_find.dart';
import 'package:dsd/synchronization/sql/photo_model_sql_update.dart';
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

class SyncSfUploadPhotoModel extends AbstractSyncSfUploadModel {
  SyncSfUploadPhotoModel(SyncType syncType,
      {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync})
      : super(syncType, syncParameter: syncParameter, onSuccessSync: onSuccessSync, onFailSync: onFailSync);

  @override
  List<TableUploadBean> getTableUploadList() {
    List<TableUploadBean> uploadBeanList = [];

    TableUploadBean visit = new TableUploadBean('ContentVersion',
        PhotoModelSqlFind.PHOTO_CONTENT_VERSION_SQL_FIND,
        PhotoModelSqlUpdate.PHOTO_CONTENT_VERSION_SQL_UPDATE,
        getUploadUniqueIdValues());

    uploadBeanList.add(visit);

    return uploadBeanList;
  }
}
