import 'package:dsd/synchronization/sync/sync_config.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/31 17:36

class TableKeyBean {
  String name;
  List<String> keys;

  TableKeyBean(this.name, this.keys);

  String getKeysStr() {
    StringBuffer sb = new StringBuffer();
    for (String key in keys) {
      sb..write(key)..write(SyncConfig.PRIMARY_KEY_SEPARATOR);
    }
    String result = sb.toString();
    return result.substring(0, result.length - 1);
  }
}
