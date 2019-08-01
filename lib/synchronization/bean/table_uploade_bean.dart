import 'package:dsd/synchronization/utils/sync_sql_util.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/26 16:49

class TableUploadBean {
  String name;
  String sqlFind;
  String sqlUpdate;
  List<String> uniqueIdValues;

  TableUploadBean(this.name, this.sqlFind, this.sqlUpdate, this.uniqueIdValues);

  String getSqlFindBuild() {
    return SyncSqlUtil.buildSql(sqlFind, uniqueIdValues);
  }

  String getSqlUpdateBuild() {
    return SyncSqlUtil.buildSql(sqlUpdate, uniqueIdValues);
  }
}
