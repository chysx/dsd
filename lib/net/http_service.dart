import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dsd/common/sf_config.dart';
import 'package:dsd/net/http_config.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/30 17:12

class HttpService {
  static HttpService _instance;
  Dio dio;
  String token;
  String url;

  HttpService._();

  static HttpService _getInstance() {
    if (_instance == null) {
      _instance = new HttpService._();
//      _instance.dio = new Dio(configDio());
      _instance.dio = new Dio();
    }
    return _instance;
  }

  factory HttpService() => _getInstance();

  void resetConfigDio(){
    dio.options = new BaseOptions(
        baseUrl: url,
        connectTimeout: TimeOut.CONNECT_TIMEOUT,
        receiveTimeout: TimeOut.READ_TIMEOUT,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + token
        }
    );
  }

  void restConfigDioByToken() {
    dio.options = new BaseOptions(
        baseUrl: SfConfig.url,
        connectTimeout: TimeOut.CONNECT_TIMEOUT,
        receiveTimeout: TimeOut.READ_TIMEOUT,
    );
    dio.options.contentType = Headers.formUrlEncodedContentType;
  }

  Future<void> test() async {
    String path = 'https://cch-valser--devcch.my.salesforce.com/services/apexrest/DMSDownloadService';
    Map<String, dynamic> data = {
      "jsonData": "eyJzeW5jVHlwZSI6ICIwIiwiZGV2aWNlSWQiOiAiIn0="
    };
    var response = await dio.post(path, data: data);
    print('');
  }

  Future<void> testLogin() async {
    restConfigDioByToken();
    String clientId = '3MVG9lcxCTdG2VbvVIU4x0gAacuOdRIjZlxol_fARoYQscWCRfeaCWkBCFVtHB3Gi_HFIXUR.NBVAcAgiV_yN';
    String clientSecret = 'DBC6ED3FD0845C4065ADAC14CF05C8BF4C544023330319783A7B005A00A02952';
    String userName = 'bruce.yue@cchellenic.com.devcch';
    String password = 'ebest#2020';
    String body = "grant_type=password";
    body += "&client_id=$clientId&client_secret=$clientSecret";
    body += "&username=$userName&password=$password";
    String endpoint ='https://test.salesforce.com/services/oauth2/token';
    print(endpoint);
    print(body);

    var response = await dio.post(endpoint, data: body);
    print('');

  }
}
