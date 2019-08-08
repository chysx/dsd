import 'dart:collection';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/26 18:14

class SyncParameter {
  List<String> uploadUniqueIdValues;
  String uploadName;
  List<List<String>> downloadParameterValues;
  HashMap<String, String> commonMap = new HashMap();

  SyncParameter putCommon(String key, String value) {
    commonMap[key] = value;
    return this;
  }

  SyncParameter putUploadUniqueIdValues(List<String> uploadUniqueIdValues) {
    this.uploadUniqueIdValues = uploadUniqueIdValues;
    return this;
  }

  List<String> getUploadUniqueIdValues() {
    return this.uploadUniqueIdValues;
  }

  SyncParameter putDownloadParameterValues(List<List<String>> downloadParameterValues) {
    this.downloadParameterValues = downloadParameterValues;
    return this;
  }

  List<List<String>> getDownloadParameterValues() {
    return this.downloadParameterValues;
  }

  SyncParameter putUploadName(List<String> uploadNameList) {
    if (uploadNameList.length == 1) {
      this.uploadName = uploadNameList[0];
      return this;
    }
    StringBuffer sb = new StringBuffer();
    uploadNameList.forEach((item) {
      sb..write(item)..write(",");
    });
    if (sb.length > 0) {
      String result = sb.toString();
      this.uploadName = result.substring(0, result.length - 1);
    }
    return this;
  }

  String getUploadName() {
    return this.uploadName;
  }

  String getCommon(String key) {
    return commonMap[key];
  }
}
