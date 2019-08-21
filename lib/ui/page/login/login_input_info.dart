/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 15:40

class LoginInputInfo {
  String userCode = "";
  String password = "";

  LoginInputInfo([this.userCode, this.password]);

  @override
  String toString() {
    return 'LoginInputInfo{userCode: $userCode, password: $password}';
  }


}
