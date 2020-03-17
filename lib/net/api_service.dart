import 'package:dio/dio.dart';
import 'package:dsd/application.dart';
import 'package:dsd/common/sf_config.dart';
import 'package:dsd/net/http_service.dart';
import 'package:dsd/synchronization/bean/sync_request_bean.dart';
import 'package:dsd/synchronization/bean/sync_sf_request_bean.dart';
import 'package:dsd/ui/page/login/login_request_bean.dart';
import 'package:dsd/ui/page/login/sf_login_request_bean.dart';
import 'package:dsd/utils/code_util.dart';

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

  static Future<Response<Map<String, dynamic>>> getSFTokenData() {
    return Application.httpService.post(SfConfig.url, data: SfConfig.makeConfig());
  }

  static Future<Response<Map<String, dynamic>>> getSFLoginData(SFLoginRequestBean sfLoginRequestBean) {
    String path = '/services/apexrest/DMSLoginService';
    Map<String, dynamic> data = {
      "jsonData": CodeUtil.base64EncodeByMap(sfLoginRequestBean.toJson()),
    };
    print('request = $data');
    return Application.httpService.post(path, data: data);
  }

  static Future<Response<Map<String, dynamic>>> getSFDownloadData(SyncSfRequestBean syncSfRequestBean) {
    String path = '/services/apexrest/DMSDownloadService';
    Map<String, dynamic> data = {
      "jsonData": CodeUtil.base64EncodeByMap(syncSfRequestBean.toJson()),
    };
    print('request = $data');
    return Application.httpService.post(path, data: data);//need change
  }

}
