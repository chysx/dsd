/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-03-16 15:22

class SFLoginResponseBean {
    Records records;

    SFLoginResponseBean({this.records});

    factory SFLoginResponseBean.fromJson(Map<String, dynamic> json) {
        return SFLoginResponseBean(
            records: json['records'] != null ? Records.fromJson(json['records']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.records != null) {
            data['records'] = this.records.toJson();
        }
        return data;
    }
}

class Records {
    String exceptionDescrption;
    String loginName;
    String serverTime;
    String status;
    String userName;

    Records({this.exceptionDescrption, this.loginName, this.serverTime, this.status, this.userName});

    factory Records.fromJson(Map<String, dynamic> json) {
        return Records(
            exceptionDescrption: json['exceptionDescrption'],
            loginName: json['loginName'],
            serverTime: json['serverTime'],
            status: json['status'],
            userName: json['userName'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['exceptionDescrption'] = this.exceptionDescrption;
        data['loginName'] = this.loginName;
        data['serverTime'] = this.serverTime;
        data['status'] = this.status;
        data['userName'] = this.userName;
        return data;
    }
}