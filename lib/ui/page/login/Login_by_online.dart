import 'package:dio/dio.dart';
import 'package:dsd/application.dart';
import 'package:dsd/net/api_service.dart';
import 'package:dsd/net/http_service.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/dialog/loading_dialog.dart';
import 'package:dsd/ui/page/login/sf_login_request_bean.dart';
import 'package:dsd/ui/page/login/sf_login_response_bean.dart';
import 'package:dsd/ui/page/login/sf_token_response_bean.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'login_input_info.dart';
import 'login_status.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-03-16 15:57

class LoginByOnline {
  static void start(BuildContext context,
      LoginType loginType,void Function(dynamic response) loginCallBack,[LoginInputInfo loginInputInfo]) {

    LoadingDialog.show(context, msg: 'Login...');

    Future<Response<Map<String, dynamic>>> api;
    if(loginType == LoginType.Login){
      SFLoginRequestBean sfLoginRequestBean = new SFLoginRequestBean();
      sfLoginRequestBean.loginName = loginInputInfo.userCode;
      sfLoginRequestBean.password = loginInputInfo.password;

      HttpService().resetConfigDio();
      api = ApiService.getSFLoginData(sfLoginRequestBean);
    }else if(loginType == LoginType.Token){
      HttpService().restConfigDioByToken();
      api = ApiService.getSFTokenData();
    }else if(loginType == LoginType.UpdateTime){
      api = ApiService.updateTime();
    }

    Observable.fromFuture(api).listen((response) {
      LoadingDialog.dismiss(context);

      Application.logger.i('''
        url = ${response.request.baseUrl + response.request.path}
        response = ${response.data}''');
      if(loginType == LoginType.Login){
        SFLoginResponseBean responseBean = SFLoginResponseBean.fromJson(response.data);
        loginCallBack(responseBean);
      }else if(loginType == LoginType.Token){
        SFTokenResponseBean responseBean = SFTokenResponseBean.fromJson(response.data);
        loginCallBack(responseBean);
      }else if(loginType == LoginType.UpdateTime){
        loginCallBack(response.data['Result']);
      }

    }, onError: (e) {
      LoadingDialog.dismiss(context);
      Application.logger.e(e.toString());
      CustomerDialog.show(context, msg: 'Login failed. Please check your network and try again.');
    });
  }
}