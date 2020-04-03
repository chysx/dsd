import 'package:dsd/application.dart';
import 'package:dsd/db/manager/app_config_manager.dart';
import 'package:dsd/db/table/entity/app_config_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/log/log4dart.dart';
import 'package:dsd/net/http_config.dart';
import 'package:dsd/net/http_service.dart';
import 'package:dsd/route/page_builder.dart';
import 'package:dsd/synchronization/sql/checkin_model_sql_find.dart';
import 'package:dsd/synchronization/sql/checkout_model_sql_find.dart';
import 'package:dsd/synchronization/sql/visit_model_sql_find.dart';
import 'package:dsd/synchronization/sync/sync_mapping.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/sync_manager.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/page/login/Login_by_online.dart';
import 'package:dsd/ui/page/login/login_input_info.dart';
import 'package:dsd/ui/page/login/login_status.dart';
import 'package:dsd/ui/page/login/sf_login_response_bean.dart';
import 'package:dsd/ui/page/login/sf_token_response_bean.dart';
import 'package:dsd/ui/page/settings/setting_info.dart';
import 'package:dsd/ui/page/settings/settings_presenter.dart';
import 'package:dsd/utils/code_util.dart';
import 'package:dsd/utils/device_info.dart';
import 'package:dsd/utils/file_util.dart';
import 'package:dsd/utils/string_util.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 11:00

enum LoginEvent { InitData }

class SfLoginPresenter extends EventNotifier<LoginEvent> {
  LoginInputInfo inputInfo = new LoginInputInfo();
  AppConfigEntity appConfigEntity;

  @override
  void onEvent(LoginEvent event, [dynamic data]) async {
    switch (event) {
      case LoginEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  Future initData() async {
    await fillAppConfigEntity();
    initUrlConfig();
  }

  void initUrlConfig() {
    if (appConfigEntity != null) {
      switch (appConfigEntity.env) {
        case UrlDev.ENV:
          HttpConfig.urlConfig = UrlConfig.DEV;
          break;
        case UrlQas.ENV:
          HttpConfig.urlConfig = UrlConfig.QAS;
          break;
        case UrlUat.ENV:
          HttpConfig.urlConfig = UrlConfig.UAT;
          break;
        case UrlPrd.ENV:
          HttpConfig.urlConfig = UrlConfig.PRD;
          break;
      }

      HttpService().resetConfigDio();
    }
  }

  Future fillAppConfigEntity() async {
    List<AppConfigEntity> list =
        await Application.database.appConfigDao.findAll();
    if (!ObjectUtil.isEmptyList(list)) {
      appConfigEntity = list[0];
      Application.logger.i('appConfigEntity = ${appConfigEntity.toString()}');
      fillInputData();
      fillAppUser();
      fillHttpService();
    }
  }

  void fillInputData() {
    inputInfo.userCode = appConfigEntity.userCode;
  }

  void fillAppUser() {
    Application.user.userCode = appConfigEntity.userCode;
    Application.user.userName = appConfigEntity.userName;
    Application.user.passWord = appConfigEntity.password;

  }

  void fillHttpService() {
    HttpService().token = appConfigEntity.token;
    HttpService().url = appConfigEntity.url;
  }

  void testCreateFields() {
    String tableName = 'MD_Account';
    String sql = VisitModelSqlFind.VISIT_MD_Account_Sql_Find;
    sql = sql.replaceAll('\n', '');
    sql = sql.replaceAll('\t', '');
    sql = sql.substring(sql.indexOf('SELECT') + 6,sql.indexOf('FROM')).trim();
    List<String> fieldList = sql.split(',');
    if(fieldList[0].contains('.')){
      fieldList = fieldList.map((item){
        return item.substring(item.indexOf('.') + 1);
      }).toList();
    }
    String mark = local2SfMapping[tableName] + MARK;
    Map<String,String> map = {};
    for(String key in fieldMapping.keys){
      if(key.contains(mark)){
        String value = fieldMapping[key];
        map[value] = key.substring(key.indexOf(MARK) + 1);
      }
    }
    List<String> resultList = [];
    for(String field in fieldList) {
      resultList.add(map[field.trim()]);
    }
    print(resultList.join(','));

    for(int i = 0;i < resultList.length;i++){
      print('${fieldList[i]}:                  ${resultList[i]}');
    }
  }


  Future testLoadConfig(BuildContext context) async {
    SyncManager.start(SyncType.SYNC_CONFIG_SF, context: context, onSuccessSync: () {
      CustomerDialog.show(context, msg: 'Sync config success');
    }, onFailSync: (e) async {
      CustomerDialog.show(context, msg: 'Sync config fail');
    });
  }

  Future testLoadSync(BuildContext context) async {
    SyncManager.start(SyncType.SYNC_INIT_SF, context: context, onSuccessSync: () {
      CustomerDialog.show(context, msg: 'Sync success');
    }, onFailSync: (e) async {
      CustomerDialog.show(context, msg: 'Sync fail');
    });
  }

  void testParser(){
    String values = "a289E000000y9YZQAY ▏SN-20200326000245 ▏2020-03-26 ▏Delivery ▏Rele ▏DMS ▏2020-03-26 10:30:22 ▏ ▏ ▏a299E000000ixpxQAA ▏0001 ▏BigTruck ▏ ▏0.00 ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏ ▏New ▏ ▏ ▏1 ▏SN-20200326000245 ▏ ▏true ▏ ▏ ▏";
    String fields = "Id,ShipmentNo__c,Plan_Shipment_Date__c,ShipmentType__c,ReleaseStatus__c,ReleaseUser__c,ReleaseTime__c,ActionType__c,CheckinTime__c,TruckId__c,TrunkCode__c,TruckType__c,LoadingSequence__c,TotalProductQty__c,TotalItemAmount__c,Odometer__c,Checker__c,CheckerConfirm__c,CheckerConfirmTime__c,CheckerSignImg__c,DCheckerSignImg__c,Cashier__c,CashierConfirm__c,CashierSignImg__c,CashierConfirmTime__c,DCashierSignImg__c,Gatekeeper__c,GKSignImg__c,GKConfirmTime__c,GKConfirm__c,DGKSignImg__c,Status__c,iDelyTruck__c,iDelyDriver__c,SalesOrganization__c,ExternalId__c,GUID__c,IsActive__c,iDelyLastUpdateTime__c,iDelyLastUpdateUserCode__c,iDelyCreateUserCode__c";

    String FIELD_SEPARATOR = ",";
    String ROW_SEPARATOR = "▏";
    List<String> valueList = values.split(ROW_SEPARATOR);
    List<String> fieldList = fields.split(FIELD_SEPARATOR);
    Map<String,String> map = {};

    for(int i = 0;i < valueList.length;i++) {
      map[fieldList[i]] = valueList[i];
    }

    for(String key in map.keys){
      print('$key = ${map[key]}');
    }

  }


  Future login(BuildContext context, LoginInputInfo loginInputInfo) async {
//    if(true){
//      testCreateFields();
////    testLoadSync(context);
////    FileUtil.getFilePath('log');
////    testParser();
//      return;
//    }
    print(loginInputInfo.toString());
    LoginStatus loginStatus = checkLoginInput(loginInputInfo);
    print('*******************status = ${loginStatus.toString()}');
    switch (loginStatus) {
      case LoginStatus.CheckUserCodeIsNull:
        CustomerDialog.show(context, msg: 'Please input your account.');
        break;
      case LoginStatus.CheckPasswordIsNull:
        CustomerDialog.show(context, msg: 'Please input your password!');
        break;
      case LoginStatus.SyncUpdate:
        loadToken(context, SyncType.SYNC_UPDATE_SF, loginInputInfo);
        break;
      case LoginStatus.SyncInit:
        loadToken(context, SyncType.SYNC_INIT_SF, loginInputInfo);
        break;
      case LoginStatus.OffLine:
        onClickCheckout(context);
        break;
      default:
    }
  }

  void loadToken(BuildContext context, SyncType syncType, LoginInputInfo loginInputInfo) {
    LoginByOnline.start(context, LoginType.Token, (data) async {
      SFTokenResponseBean responseBean = data;
      if (ObjectUtil.isEmptyString(responseBean.accessToken)) {
        CustomerDialog.show(context, msg: 'Login failed. Please check your network and try again.');
      } else {
        await saveUserToDbByToken(responseBean);
        HttpService().token = responseBean.accessToken;
        HttpService().url = responseBean.instanceUrl;
        loginByOnline(context,syncType,loginInputInfo);
      }
    });
  }

  void loginByOnline(BuildContext context, SyncType syncType, LoginInputInfo loginInputInfo) {
    LoginByOnline.start(context, LoginType.Login, (data) {
      SFLoginResponseBean responseBean = data;
      if (responseBean.records.status == '1') {
        DateTime serviceTime = DateUtil.getDateTime(responseBean.records.serverTime);
        DateTime localTime = DateTime.now();
        Duration diff = localTime.difference(serviceTime);
//          if (diff.inMinutes.abs() > 15) {
//            responseStatus = LoginResponseStatus.LocalServeTimeDifference;
//            CustomerDialog.show(context,
//                msg: 'Your phone time is incorrect.\n'
//                    'Phone time ${DateUtil.getDateStrByDateTime(new DateTime.now())}\n'
//                    'Server time ${responseBean.result.serverTime}',
//                onConfirm: (){
//                  if(Platform.isAndroid){
//                    AndroidIntent intent = const AndroidIntent(
//                      action: 'android.settings.DATE_SETTINGS',
//                    );
//                    intent.launch();
//                  }
//                });
//            return;
//          }
        loginSuccess(context, syncType, responseBean, loginInputInfo);
      } else {
        CustomerDialog.show(context, msg: responseBean.records?.exceptionDescrption ?? 'Login failed. Please check your network and try again.');
//        loginSuccess(context, syncType, responseBean, loginInputInfo);
      }
    },loginInputInfo);
  }

  Future onClickCheckout(BuildContext context) async {
    Map<String, dynamic> bundle = {};
    await Navigator.pushNamed(context, PageName.check_out_shipment.toString(),
        arguments: bundle);
  }

  Future onClickSetting(BuildContext context) async {
    LoggerSuper().info('api', 'zhangguopeng');
    Map<String, dynamic> bundle = {};
    var result = await Navigator.pushNamed(
        context, PageName.settings.toString(),
        arguments: bundle);

    if (result == 'refresh') {
      fillAppConfigEntity();
    }
  }

  LoginStatus checkLoginInput(LoginInputInfo loginInputInfo) {
    if (StringUtil.isEmpty(loginInputInfo.userCode))
      return LoginStatus.CheckUserCodeIsNull;

    if (StringUtil.isEmpty(loginInputInfo.password))
      return LoginStatus.CheckPasswordIsNull;

    if (appConfigEntity == null ||
        StringUtil.isEmpty(appConfigEntity.userCode) ||
        StringUtil.isEmpty(appConfigEntity.password) ||
        !StringUtil.equalsIgnoreCase(
            loginInputInfo.userCode, appConfigEntity.userCode) ||
        !StringUtil.equalsIgnoreCase(
            loginInputInfo.password, appConfigEntity.password)) {
      return LoginStatus.SyncInit;
    }

    if (StringUtil.isEmpty(appConfigEntity.syncInitFlag))
      return LoginStatus.SyncInit;

    int lastDay = DateUtil.getDateTime(appConfigEntity.lastUpdateTime).day;
    int nowDay = new DateTime.now().day;

    if (lastDay != nowDay) return LoginStatus.SyncUpdate;

    return LoginStatus.OffLine;
  }

  Future loginSuccess(BuildContext context, SyncType syncType,
      SFLoginResponseBean responseBean, LoginInputInfo inputInfo) async {
    await saveUserToDbByLogin(responseBean, inputInfo);

    loadConfig(context, syncType);
  }

  Future loadConfig(BuildContext context, SyncType syncType) async {
    SyncManager.start(SyncType.SYNC_CONFIG_SF, context: context, onSuccessSync: () {
      syncData(context,syncType);
    }, onFailSync: (e) async {
      CustomerDialog.show(context, msg: 'Sync config fail');
    });
  }


  void syncData(BuildContext context, SyncType syncType) {
    SyncManager.start(syncType, context: context, onSuccessSync: () async {
      loadUpdateTime(context,syncType);
    }, onFailSync: (e) async {
      await clearUserToDb();
      appConfigEntity.syncInitFlag = null;
      CustomerDialog.show(context, msg: 'Sync fail');
    });
  }

  void loadUpdateTime(BuildContext context, SyncType syncType) {
    LoginByOnline.start(context, LoginType.UpdateTime, (data) async {
      if(data == 'SUCCESS'){
        await saveUserToDbBySync(syncType);
        onClickCheckout(context);
      }else{
        await clearUserToDb();
        appConfigEntity.syncInitFlag = null;
        CustomerDialog.show(context, msg: data);
      }
    });
  }

  Future clearUserToDb() async {
    await AppConfigManager.deleteAll();
  }

  Future saveUserToDbByToken(SFTokenResponseBean responseBean) async {
    List<AppConfigEntity> list = await AppConfigManager.queryAll();
    AppConfigEntity entity;
    if (ObjectUtil.isEmptyList(list)) {
      entity = AppConfigEntity.Empty();
      entity
        ..token = responseBean.accessToken
        ..url = responseBean.instanceUrl;
      await AppConfigManager.insert(entity);
    } else {
      AppConfigEntity entity = list[0];
      entity
        ..token = responseBean.accessToken
        ..url = responseBean.instanceUrl;
      await AppConfigManager.update(entity);
    }
  }


  Future saveUserToDbByLogin(SFLoginResponseBean responseBean,
      LoginInputInfo inputInfo) async {
    List<AppConfigEntity> list = await AppConfigManager.queryAll();
    SettingInfo settingInfo = await SettingPresenter.getCurSettingInfo();
    AppConfigEntity entity;
    if (ObjectUtil.isEmptyList(list)) {
      entity = AppConfigEntity.Empty();
      entity
        ..userCode = responseBean.records.loginName
        ..userName = responseBean.records.userName
        ..password = inputInfo.password
        ..version = DeviceInfo().versionName
        ..lastUpdateTime = DateUtil.getNowDateStr()
        ..host = settingInfo.host
        ..port = settingInfo.port
        ..isSsl = SettingInfo.boolToStr(settingInfo.isSsl)
        ..env = settingInfo.env;
      await AppConfigManager.insert(entity);
    } else {
      AppConfigEntity entity = list[0];
      entity
        ..userCode = responseBean.records.loginName
        ..userName = responseBean.records.userName
        ..password = inputInfo.password
        ..version = DeviceInfo().versionName
        ..lastUpdateTime = DateUtil.getNowDateStr();
      await AppConfigManager.update(entity);
    }
    await fillAppConfigEntity();
  }

  Future saveUserToDbBySync(SyncType syncType,) async {
    List<AppConfigEntity> list = await AppConfigManager.queryAll();
    AppConfigEntity entity;
    if (ObjectUtil.isEmptyList(list)) {
      entity = AppConfigEntity.Empty();
      entity
        ..syncInitFlag = syncType.toString();
        await AppConfigManager.insert(entity);
    } else {
      AppConfigEntity entity = list[0];
      entity
        ..syncInitFlag = syncType.toString();
    await AppConfigManager.update(entity);
    }
  }
}
