import 'package:dsd/application.dart';
import 'package:dsd/db/manager/app_config_manager.dart';
import 'package:dsd/db/manager/app_log_manager.dart';
import 'package:dsd/db/table/entity/app_config_entity.dart';
import 'package:dsd/exception/exception_type.dart';
import 'package:dsd/net/api_service.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/sync_manager.dart';
import 'package:dsd/ui/page/login/login_input_info.dart';
import 'package:dsd/ui/page/login/login_request_bean.dart';
import 'package:dsd/ui/page/login/login_status.dart';
import 'package:dsd/utils/string_util.dart';
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

class LoginPresenter {
  LoginInputInfo inputInfo = new LoginInputInfo();
  AppConfigEntity appConfigEntity;

  void initData() {

  }

  void login(BuildContext context, LoginInputInfo loginInputInfo) {
    initAppConfigEntity();
    LoginStatus loginStatus = checkLoginInput(loginInputInfo);
    switch (loginStatus) {
      case LoginStatus.CheckUserCodeIsNull:
        break;
      case LoginStatus.CheckPasswordIsNull:
        break;
      case LoginStatus.SyncUpdate:
        syncData(context, SyncType.SYNC_UPDATE);
        break;
      case LoginStatus.SyncInit:
        syncData(context, SyncType.SYNC_INIT);
        break;
      case LoginStatus.OffLine:
        break;
      default:
    }
  }

  void initAppConfigEntity() {
    Future.delayed(new Duration(seconds: 2),() async {
      List<AppConfigEntity> list = await Application.database.appConfigDao.findAll();
      if (!ObjectUtil.isEmptyList(list)) {
        appConfigEntity = list[0];
      }
    });
  }

  LoginStatus checkLoginInput(LoginInputInfo loginInputInfo) {
    if (StringUtil.isEmpty(loginInputInfo.userCode)) return LoginStatus.CheckUserCodeIsNull;

    if (StringUtil.isEmpty(loginInputInfo.password)) return LoginStatus.CheckPasswordIsNull;

    if (StringUtil.isEmpty(appConfigEntity.userCode) ||
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

  void loginByOnline(LoginInputInfo loginInputInfo) {
    LoginRequestBean loginRequestBean = new LoginRequestBean();
    loginRequestBean
      ..userName = loginInputInfo.userCode
      ..password = loginInputInfo.password
      ..isChangePwd = false
      ..newPassword = ""
      ..platForm = "Android";

    LoginResponseStatus responseStatus;
    Observable.fromFuture(ApiService.getDataByLogin(loginRequestBean)).listen((response) {
      LoginResponseBean responseBean = LoginResponseBean.fromJson(response.data);
      if (responseBean.status == 1) {
        DateTime serviceTime = DateUtil.getDateTime(responseBean.result.serverTime);
        DateTime localTime = DateTime.now();
        Duration diff = localTime.difference(serviceTime);
        if (diff.inMinutes.abs() > 15) {
          responseStatus = LoginResponseStatus.LocalServeTimeDifference;
          return;
        }
        loginSuccess(responseBean, loginInputInfo);
      } else {
        AppLogManager.insert(ExceptionType.WARN.toString(), response.toString());
        responseStatus = LoginResponseStatus.OnLineError;
        String exceptionCode = responseBean.exceptionCode;

        if (StringUtil.equalsIgnoreCase(exceptionCode, "1")) {
          responseStatus = LoginResponseStatus.ErrorUserMsg;
          showDialog(responseStatus);
          return;
        }

        if (StringUtil.equalsIgnoreCase(exceptionCode, "2")) {
          responseStatus = LoginResponseStatus.ErrorPasswordExpired;
          showDialog(responseStatus);
          return;
        }

        if (StringUtil.equalsIgnoreCase(exceptionCode, "3")) {
          responseStatus = LoginResponseStatus.AccountLock;
          showDialog(responseStatus);
          return;
        }

        if (StringUtil.equalsIgnoreCase(exceptionCode, "4")) {
          responseStatus = LoginResponseStatus.AccountInvalid;
          showDialog(responseStatus);
          return;
        }

        if (StringUtil.equalsIgnoreCase(exceptionCode, "4")) {
          responseStatus = LoginResponseStatus.AccountInvalid;
          showDialog(responseStatus);
          return;
        }

        if (StringUtil.equalsIgnoreCase(exceptionCode, "7")) {
          responseStatus = LoginResponseStatus.NoShipment;
          showDialog(responseStatus);
          return;
        }

        if (StringUtil.equalsIgnoreCase(exceptionCode, "9")) {
          responseStatus = LoginResponseStatus.ImeiNotMatch;
          showDialog(responseStatus);
          return;
        }

        responseStatus = LoginResponseStatus.ImeiNotMatch;
        showDialog(responseStatus);
      }
    });
  }

  void loginSuccess(LoginResponseBean responseBean, LoginInputInfo inputInfo) {
    saveUserToApp(responseBean, inputInfo);
    clearUserToDb();
    saveUserToDb(responseBean, inputInfo);
  }

  void syncData(BuildContext context, SyncType syncType) {
    SyncManager.start(syncType, context: context, onSuccessSync: () {
      updateUserToDb(syncType, inputInfo);
    }, onFailSync: (e) {
      clearUserToDb();
    });
  }

  void clearUserToDb() {
    AppConfigManager.deleteAll();
  }

  void saveUserToDb(LoginResponseBean responseBean, LoginInputInfo inputInfo) {
    AppConfigEntity entity = AppConfigEntity();
    entity
      ..userCode = responseBean.loginName
      ..userName = responseBean.result.userName
      ..password = inputInfo.password
      ..lastUpdateTime = DateUtil.getNowDateStr();
    AppConfigManager.insert(entity);
  }

  Future updateUserToDb(SyncType syncType, LoginInputInfo inputInfo) async {
    AppConfigEntity entity = await AppConfigManager.queryByUserCode(inputInfo.userCode);
    entity.syncInitFlag = syncType.toString();
    await AppConfigManager.update(entity);
  }

  void saveUserToApp(LoginResponseBean responseBean, LoginInputInfo inputInfo) {
    Application.user
      ..userCode = responseBean.loginName
      ..userName = responseBean.result.userName
      ..passWord = inputInfo.password;
  }

  void showDialog(LoginResponseStatus responseStatus) {}
}
