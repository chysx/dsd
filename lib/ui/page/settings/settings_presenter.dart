import 'package:dsd/net/http_config.dart';
import 'package:dsd/ui/page/settings/setting_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 17:54

class SettingPresenter {
  List<SettingInfo> settingList = new List();
  SettingInfo curSettingInfo;

  void initData() {
    initSettingList();
    initCurSettingInfo();
  }

  void initSettingList() {
    settingList.clear();

    SettingInfo devInfo = new SettingInfo();
    devInfo
      ..host = UrlDev.HOST
      ..port = UrlDev.PORT
      ..isSsl = UrlDev.IS_SSL
      ..env = UrlDev.ENV;

    SettingInfo qasInfo = new SettingInfo();
    qasInfo
      ..host = UrlQas.HOST
      ..port = UrlQas.PORT
      ..isSsl = UrlQas.IS_SSL
      ..env = UrlQas.ENV;

    SettingInfo uatInfo = new SettingInfo();
    uatInfo
      ..host = UrlUat.HOST
      ..port = UrlUat.PORT
      ..isSsl = UrlUat.IS_SSL
      ..env = UrlUat.ENV;

    SettingInfo prdInfo = new SettingInfo();
    prdInfo
      ..host = UrlPrd.HOST
      ..port = UrlPrd.PORT
      ..isSsl = UrlPrd.IS_SSL
      ..env = UrlPrd.ENV;

    SettingInfo otherInfo = new SettingInfo();
    otherInfo
      ..host = ''
      ..port = ''
      ..isSsl = false
      ..env = 'OTHER';

    settingList.add(devInfo);
    settingList.add(qasInfo);
    settingList.add(uatInfo);
    settingList.add(prdInfo);
    settingList.add(otherInfo);
  }

  void initCurSettingInfo() {
    curSettingInfo = new SettingInfo();
    curSettingInfo
      ..host = UrlDev.HOST
      ..port = UrlDev.PORT
      ..isSsl = UrlDev.IS_SSL
      ..env = UrlDev.ENV;
  }

  void setCurSettingInfo(String env){
    for(SettingInfo info in settingList){
      if(info.env == env){
        curSettingInfo = info;
        break;
      }
    }
  }
}