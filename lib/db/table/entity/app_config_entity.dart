import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 10:29

@Entity(tableName: "app_config")
class AppConfigEntity {
  @PrimaryKey(autoGenerate: true)
  int id;
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
      this.id,
      this.userCode,
      this.userName,
      this.password,
      this.env,
      this.host,
      this.port,
      this.isSsl,
      this.syncInitFlag,
      this.version,
      this.lastUpdateTime);

  AppConfigEntity.Empty();

  @override
  String toString() {
    return 'AppConfigEntity{id: $id, userCode: $userCode, userName: $userName, password: $password, env: $env, host: $host, port: $port, isSsl: $isSsl, syncInitFlag: $syncInitFlag, version: $version, lastUpdateTime: $lastUpdateTime}';
  }


}
