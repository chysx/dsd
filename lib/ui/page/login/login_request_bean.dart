/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/8 15:14
///
class LoginRequestBean {
  String imei;
  String newPassword;
  String password;
  String platForm;
  String userName;
  String versionNum;
  bool isChangePwd;

  LoginRequestBean(
      [this.imei, this.newPassword, this.password, this.platForm, this.userName, this.versionNum, this.isChangePwd]);

  LoginRequestBean.fromJson(Map<String, dynamic> json) {
    this.imei = json['IMEI'];
    this.newPassword = json['NewPassword'];
    this.password = json['Password'];
    this.platForm = json['PlatForm'];
    this.userName = json['UserName'];
    this.versionNum = json['VersionNum'];
    this.isChangePwd = json['IsChangePwd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IMEI'] = this.imei;
    data['NewPassword'] = this.newPassword;
    data['Password'] = this.password;
    data['PlatForm'] = this.platForm;
    data['UserName'] = this.userName;
    data['VersionNum'] = this.versionNum;
    data['IsChangePwd'] = this.isChangePwd;
    return data;
  }
}
