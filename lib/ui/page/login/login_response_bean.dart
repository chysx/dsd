class LoginResponseBean {
  String loginName;
  int exceptionCode;
  String exception;
  int status;
  int syncType;
  ResultBean result;

  LoginResponseBean([this.loginName, this.exceptionCode, this.exception, this.status, this.syncType, this.result]);

  LoginResponseBean.fromJson(Map<String, dynamic> json) {
    this.loginName = json['LoginName'];
    this.exceptionCode = json['ExceptionCode'];
    this.exception = json['Exception'];
    this.status = json['Status'];
    this.syncType = json['SyncType'];
    this.result = json['Result'] != null ? ResultBean.fromJson(json['Result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginName'] = this.loginName;
    data['ExceptionCode'] = this.exceptionCode;
    data['Exception'] = this.exception;
    data['Status'] = this.status;
    data['SyncType'] = this.syncType;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    return data;
  }
}

class ResultBean {
  String userName;
  String device;
  String serverTime;
  bool alert;
  int orgId;
  VersionBean version;

  ResultBean([this.userName, this.device, this.serverTime, this.alert, this.orgId, this.version]);

  ResultBean.fromJson(Map<String, dynamic> json) {
    this.userName = json['UserName'];
    this.device = json['Device'];
    this.serverTime = json['ServerTime'];
    this.alert = json['Alert'];
    this.orgId = json['OrgId'];
    this.version = json['Version'] != null ? VersionBean.fromJson(json['Version']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['Device'] = this.device;
    data['ServerTime'] = this.serverTime;
    data['Alert'] = this.alert;
    data['OrgId'] = this.orgId;
    if (this.version != null) {
      data['Version'] = this.version.toJson();
    }
    return data;
  }
}

class VersionBean {
  String downloadUrl;
  String versionNum;
  String fileSize;
  String updateDesc;
  bool isLastVersion;

  VersionBean({this.downloadUrl, this.versionNum, this.fileSize, this.updateDesc, this.isLastVersion});

  VersionBean.fromJson(Map<String, dynamic> json) {
    this.downloadUrl = json['DownloadUrl'];
    this.versionNum = json['VersionNum'];
    this.fileSize = json['FileSize'];
    this.updateDesc = json['UpdateDesc'];
    this.isLastVersion = json['IsLastVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DownloadUrl'] = this.downloadUrl;
    data['VersionNum'] = this.versionNum;
    data['FileSize'] = this.fileSize;
    data['UpdateDesc'] = this.updateDesc;
    data['IsLastVersion'] = this.isLastVersion;
    return data;
  }
}
