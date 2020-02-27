import 'package:dio/dio.dart';
import 'package:dsd/application.dart';
import 'package:dsd/net/http_service.dart';
import 'package:dsd/synchronization/bean/sync_request_bean.dart';
import 'package:dsd/ui/page/login/login_request_bean.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/30 17:38

class ApiService {
  static Future<Response<Map<String, dynamic>>> getDataByLogin(LoginRequestBean loginRequestBean) {
    String path = '/iSyncService/login.aspx';
//    String path = '/DSD_iSyncService/login.aspx';
    return Application.httpService.post(path, data: loginRequestBean.toJson());
  }

  static Future<Response<Map<String, dynamic>>> getSyncDataByDownload(SyncRequestBean syncRequestBean) {
    String path = '/iSyncService/download.aspx';
//    String path = '/DSD_iSyncService/download.aspx';
    return Application.httpService.post(path, data: syncRequestBean.toJson());
  }

  static Future<Response<Map<String, dynamic>>> getSyncDataByUpload(SyncRequestBean syncRequestBean) {
    String path = '/iSyncService/Upload.aspx';
//    String path = '/DSD_iSyncService/Upload.aspx';
    return Application.httpService.post(path, data: syncRequestBean.toJson());
  }
}
