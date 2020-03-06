import 'package:dsd/application.dart';
import 'package:dsd/db/manager/sync_photo_upload_manager.dart';
import 'package:dsd/db/table/sync_photo_upload_entity.dart';
import 'package:dsd/synchronization/bean/sync_request_bean.dart';
import 'package:dsd/synchronization/sync/sync_constant.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_status.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/utils/file_util.dart';
import 'package:flustars/flustars.dart';
import 'package:package_info/package_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/30 19:05

class SyncUtil {
  static Future<SyncRequestBean> createSyncDataRequestBean(SyncParameter syncParameter) async {
    SyncRequestBean syncDataRequestBean = new SyncRequestBean();
    syncDataRequestBean.loginName = Application.user.userCode;
    syncDataRequestBean.password = Application.user.passWord;
    syncDataRequestBean.domainId = "1";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    syncDataRequestBean.version = packageInfo.version;
    syncDataRequestBean.isGzip = "1";
    return syncDataRequestBean;
  }

  static updateStatus(SyncParameter syncParameter, SyncType syncType, SyncStatus syncStatus){
    SyncPhotoUploadEntity syncPhotoUploadEntity = new SyncPhotoUploadEntity.Empty();
    syncPhotoUploadEntity.filePath = syncParameter.getCommon(SyncConstant.FILE_PATH);
    syncParameter.putUploadName([FileUtil.getFileNameNoExtension(syncParameter.getCommon(SyncConstant.FILE_PATH))]);
    syncPhotoUploadEntity.name = syncParameter.getUploadName();
    syncPhotoUploadEntity.status = syncStatus.toString();
    syncPhotoUploadEntity.type = syncType.toString();
    syncPhotoUploadEntity.time = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.NORMAL);
    SyncPhotoUploadManager.deleteAndInsert(syncPhotoUploadEntity);
  }
}
