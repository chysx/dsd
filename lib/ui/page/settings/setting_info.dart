/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 18:01

class SettingInfo {
  String host;
  String port;
  bool isSsl = false;
  String env;

  static const String IS_SSL = 'True';
  static const String IS_NOT_SSL = 'False';

  static String boolToStr(bool isSsl){
    return isSsl ? IS_SSL : IS_NOT_SSL;
  }

  static bool strToBool(String isSsl){
    return isSsl == IS_SSL ? true : false;
  }

  @override
  String toString() {
    return 'SettingInfo{host: $host, port: $port, isSsl: $isSsl, env: $env}';
  }


}
