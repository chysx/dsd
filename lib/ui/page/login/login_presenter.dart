import 'package:dsd/application.dart';
import 'package:dsd/db/manager/app_config_manager.dart';
import 'package:dsd/db/manager/app_log_manager.dart';
import 'package:dsd/db/table/entity/app_config_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/exception/exception_type.dart';
import 'package:dsd/net/api_service.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/sync_manager.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/dialog/loading_dialog.dart';
import 'package:dsd/ui/page/login/login_input_info.dart';
import 'package:dsd/ui/page/login/login_request_bean.dart';
import 'package:dsd/ui/page/login/login_status.dart';
import 'package:dsd/ui/page/settings/setting_info.dart';
import 'package:dsd/ui/page/settings/settings_presenter.dart';
import 'package:dsd/utils/string_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import 'login_response_bean.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 11:00

class LoginPresenter  extends EventNotifier<SettingEvent> {
  LoginInputInfo inputInfo = new LoginInputInfo();
  AppConfigEntity appConfigEntity;
  String version = "";

  void initData() {
    inputInfo.userCode = Application.user.userCode;
    print('userCode = ${inputInfo.userCode}');
    version = Application.deviceInfo.versionName;
  }

  Future login(BuildContext context, LoginInputInfo loginInputInfo) async {
    await initAppConfigEntity();
    print(loginInputInfo.toString());
    LoginStatus loginStatus = checkLoginInput(loginInputInfo);
    print('*******************status = ${loginStatus.toString()}');
    switch (loginStatus) {
      case LoginStatus.CheckUserCodeIsNull:
        CustomerDialog.showCustomerDialog(context,msg: 'Please input your account.');
        break;
      case LoginStatus.CheckPasswordIsNull:
        CustomerDialog.showCustomerDialog(context,msg: 'Please input your password!');
        break;
      case LoginStatus.SyncUpdate:
        loginByOnline(context,SyncType.SYNC_UPDATE,loginInputInfo);
        break;
      case LoginStatus.SyncInit:
        loginByOnline(context,SyncType.SYNC_INIT,loginInputInfo);
        break;
      case LoginStatus.OffLine:
        startNavigate(context);
        break;
      default:
    }
  }

  void startNavigate(BuildContext context){
    Application.router
        .navigateTo(context, Routers.check_out_shipment, transition: TransitionType.inFromLeft);
  }

  Future initAppConfigEntity() async {
    print('22222222222222222');
    List<AppConfigEntity> list = await Application.database.appConfigDao.findAll();
    if (!ObjectUtil.isEmptyList(list)) {
      appConfigEntity = list[0];
      Application.logger.i('appConfigEntity = ${appConfigEntity.toString()}');
    }
  }

  LoginStatus checkLoginInput(LoginInputInfo loginInputInfo) {
    if (StringUtil.isEmpty(loginInputInfo.userCode)) return LoginStatus.CheckUserCodeIsNull;

    if (StringUtil.isEmpty(loginInputInfo.password)) return LoginStatus.CheckPasswordIsNull;

    if (appConfigEntity == null ||
        StringUtil.isEmpty(appConfigEntity.userCode) ||
        StringUtil.isEmpty(appConfigEntity.password) ||
        !StringUtil.equalsIgnoreCase(loginInputInfo.userCode, appConfigEntity.userCode) ||
        !StringUtil.equalsIgnoreCase(loginInputInfo.password, appConfigEntity.password)) {
      return LoginStatus.SyncInit;
    }

    if (StringUtil.isEmpty(appConfigEntity.syncInitFlag)) return LoginStatus.SyncInit;

    int lastDay = DateUtil.getDateTime(appConfigEntity.lastUpdateTime).day;
    int nowDay = new DateTime.now().day;

    if (lastDay != nowDay) return LoginStatus.SyncUpdate;

    return LoginStatus.OffLine;
  }

  void loginByOnline(BuildContext context,SyncType syncType,LoginInputInfo loginInputInfo) {
    LoadingDialog.showLoadingDialog(context,msg: 'Login...');
    try{
      LoginRequestBean loginRequestBean = new LoginRequestBean();
      loginRequestBean
        ..userName = loginInputInfo.userCode
        ..password = loginInputInfo.password
        ..versionNum = '0.1.0.89'
        ..isChangePwd = false
        ..newPassword = ""
        ..platForm = "Android";

      Application.logger.i('request = ${loginRequestBean.toJson()}');

      LoginResponseStatus responseStatus;
      Observable.fromFuture(ApiService.getDataByLogin(loginRequestBean)).listen((response) {
        LoadingDialog.dismiss(context);
        Application.logger.i('''
        url = ${response.request.baseUrl + response.request.path}
        response = ${response.data}''');
        LoginResponseBean responseBean = LoginResponseBean.fromJson(response.data);
        if (responseBean.status == 1) {
          DateTime serviceTime = DateUtil.getDateTime(responseBean.result.serverTime);
          DateTime localTime = DateTime.now();
          Duration diff = localTime.difference(serviceTime);
          if (diff.inMinutes.abs() > 15) {
            responseStatus = LoginResponseStatus.LocalServeTimeDifference;
            CustomerDialog.showCustomerDialog(context,
                msg:'Your phone time is incorrect.\n'
                    'Phone time ${new DateTime.now().toString()}\n'
                    'Server time ${responseBean.result.serverTime}');
            return;
          }
          loginSuccess(context,syncType,responseBean, loginInputInfo);
        } else {
          AppLogManager.insert(ExceptionType.WARN.toString(), msg: response.toString());
          responseStatus = LoginResponseStatus.OnLineError;
          int exceptionCode = responseBean.exceptionCode;


          if (exceptionCode == 1) {
            responseStatus = LoginResponseStatus.ErrorUserMsg;
            CustomerDialog.showCustomerDialog(context,
                msg:'Your account or password is incorrect. Please check it and try again.');
            return;
          }

          if (exceptionCode == 2) {
            responseStatus = LoginResponseStatus.ErrorPasswordExpired;
            CustomerDialog.showCustomerDialog(context,
                msg:'Incorrect username or password expired!');
            return;
          }

          if (exceptionCode == 3) {
            responseStatus = LoginResponseStatus.AccountLock;
            CustomerDialog.showCustomerDialog(context,
                msg:'The account had been locked. Please contact your manager.');
            return;
          }

          if (exceptionCode == 4) {
            responseStatus = LoginResponseStatus.AccountInvalid;
            CustomerDialog.showCustomerDialog(context,
                msg:'The account is invalid. Please contact your manager.');
            return;
          }

          if (exceptionCode == 7) {
            responseStatus = LoginResponseStatus.NoShipment;
            CustomerDialog.showCustomerDialog(context,
                msg:'You had not been assigned shipments, please contact your manager.');
            return;
          }

          if (exceptionCode == 9) {
            responseStatus = LoginResponseStatus.ImeiNotMatch;
            CustomerDialog.showCustomerDialog(context,
                msg:'The IMEI is incorrect. Please contact your manager.');
            return;
          }

          CustomerDialog.showCustomerDialog(context,
              msg:'Login failed. Please check your network and try again.');
        }
      },
      onError: (e){
        LoadingDialog.dismiss(context);
        Application.logger.e(e.toString());
        CustomerDialog.showCustomerDialog(context,
            msg:'Login failed. Please check your network and try again.');
      });
    }catch(e){

    }

  }

  void loginSuccess(BuildContext context,SyncType syncType,LoginResponseBean responseBean, LoginInputInfo inputInfo) {
    saveUserToApp(responseBean, inputInfo);
    saveUserToDb(responseBean, syncType,inputInfo);

    syncData(context, syncType);
  }

  void syncData(BuildContext context, SyncType syncType) {
    LoadingDialog.showLoadingDialog(context);
    SyncManager.start(syncType, context: context, onSuccessSync: () {
      LoadingDialog.dismiss(context);
      startNavigate(context);
    }, onFailSync: (e) {
      LoadingDialog.dismiss(context);
      clearUserToDb();
      appConfigEntity.syncInitFlag = null;
      CustomerDialog.showCustomerDialog(context, msg:'Sync fail');
    });
  }

  void clearUserToDb() {
    AppConfigManager.deleteAll();
  }

  Future saveUserToDb(LoginResponseBean responseBean, SyncType syncType,LoginInputInfo inputInfo) async {
    AppConfigEntity entity = await AppConfigManager.queryByUserCode(inputInfo.userCode);
    SettingInfo settingInfo = await SettingPresenter.getCurSettingInfo();
    if(entity == null){
      entity = AppConfigEntity();
      entity
        ..userCode = responseBean.loginName
        ..userName = responseBean.result.userName
        ..password = inputInfo.password
        ..syncInitFlag = syncType.toString()
        ..version = Application.deviceInfo.versionName
        ..lastUpdateTime = DateUtil.getNowDateStr()
        ..host = settingInfo.host
        ..port = settingInfo.port
        ..isSsl = SettingInfo.boolToStr(settingInfo.isSsl)
        ..env = settingInfo.env;
      await AppConfigManager.insert(entity);
    }else{
      entity
        ..userCode = responseBean.loginName
        ..userName = responseBean.result.userName
        ..password = inputInfo.password
        ..syncInitFlag = syncType.toString()
        ..version = Application.deviceInfo.versionName
        ..lastUpdateTime = DateUtil.getNowDateStr();
      await AppConfigManager.update(entity);
    }

    initAppConfigEntity();

  }

  void saveUserToApp(LoginResponseBean responseBean, LoginInputInfo inputInfo) {
    Application.user
      ..userCode = responseBean.loginName
      ..userName = responseBean.result.userName
      ..passWord = inputInfo.password;
  }

}
