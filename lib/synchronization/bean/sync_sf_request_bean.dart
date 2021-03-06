/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-03-11 17:05

class SyncSfRequestBean {
    String deviceId;
    String groupNumber;
    String objectNames;
    String syncType;
    String driverId;

    SyncSfRequestBean({this.deviceId, this.groupNumber, this.objectNames, this.syncType, this.driverId});

    factory SyncSfRequestBean.fromJson(Map<String, dynamic> json) {
        return SyncSfRequestBean(
            deviceId: json['deviceId'],
            groupNumber: json['groupNumber'],
            objectNames: json['objectNames'],
            syncType: json['syncType'],
            driverId: json['driverId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['deviceId'] = this.deviceId;
        data['groupNumber'] = this.groupNumber;
        data['objectNames'] = this.objectNames;
        data['syncType'] = this.syncType;
        data['driverId'] = this.driverId;
        return data;
    }
}