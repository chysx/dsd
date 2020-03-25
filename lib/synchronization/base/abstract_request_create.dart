import 'package:dsd/synchronization/base/abstract_sync_sf_upload_model.dart';

import 'abstract_sync_download_model.dart';
import 'abstract_sync_sf_download_model.dart';
import 'abstract_sync_upload_model.dart';
import 'i_create_flow.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 11:52

abstract class AbstractRequestCreate<T> implements ICreateFlow<T> {
  AbstractSyncDownloadModel syncDownloadModel;
  AbstractSyncUploadModel syncUploadModel;

  AbstractSyncSfDownloadModel syncSfDownloadModel;
  AbstractSyncSfUploadModel syncSfUploadModel;


  AbstractRequestCreate(this.syncDownloadModel, this.syncUploadModel);

  AbstractRequestCreate.bySf(this.syncSfDownloadModel,this.syncSfUploadModel);
}
