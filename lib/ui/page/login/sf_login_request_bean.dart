/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-03-16 16:36

class SFLoginRequestBean {
    String loginName;
    String password;

    SFLoginRequestBean({this.loginName, this.password});

    factory SFLoginRequestBean.fromJson(Map<String, dynamic> json) {
        return SFLoginRequestBean(
            loginName: json['loginName'],
            password: json['password'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['loginName'] = this.loginName;
        data['password'] = this.password;
        return data;
    }
}