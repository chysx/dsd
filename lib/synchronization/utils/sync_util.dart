import 'package:dsd/application.dart';
import 'package:dsd/synchronization/bean/sync_request_bean.dart';
import 'package:dsd/synchronization/sync/sync_constant.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
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
    syncDataRequestBean.version = '0.1.0.92';
    syncDataRequestBean.isGzip = "1";
    return syncDataRequestBean;
  }
}
