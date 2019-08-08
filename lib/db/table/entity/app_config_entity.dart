import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:29

@Entity(tableName: "app_config")
class AppConfigEntity {
  @primaryKey
  String userCode;
  String userName;
  String password;
  String env;
  String host;
  String port;
  String isSsl;
  String syncInitFlag;
  String version;
  String lastUpdateTime;

  AppConfigEntity(
      [this.userCode,
      this.userName,
      this.password,
      this.env,
      this.host,
      this.port,
      this.isSsl,
      this.syncInitFlag,
      this.version,
      this.lastUpdateTime]);
}
