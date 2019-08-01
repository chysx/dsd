import 'package:dsd/log/log_util.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/26 16:54

class SyncSqlUtil {
  static const String PRIMARY_VALUE_SEPARATOR = ";";
  static const String MARK = "UPLOAD_UNIQUE_ID_VALUES_MARK";
  static const String EQ = "=";
  static const String IN = "in";

  static String getStringByUniqueIdValues(List<String> uniqueIdValues) {
    if (uniqueIdValues == null || uniqueIdValues.length == 0) return null;

    StringBuffer sb = new StringBuffer();
    uniqueIdValues.forEach((str) {
      sb..write(str)..write(PRIMARY_VALUE_SEPARATOR);
    });
    String result = sb.toString();
    return result.substring(0, result.length - 1);
  }

  static List<String> getUniqueIdValuesByString(String uniqueIdValuesStr) {
    if (uniqueIdValuesStr == null) return null;
    return uniqueIdValuesStr.split(PRIMARY_VALUE_SEPARATOR);
  }

  static String buildSql(String resSql, List<String> uniqueIdValues) {
    if (!resSql.contains(MARK)) return resSql;
    if (uniqueIdValues == null || uniqueIdValues.length == 0)
      throw new Exception("SQL里面主键指定了，但是没有传值");
    StringBuffer replace = new StringBuffer();
    if (uniqueIdValues.length == 1) {
      replace..write(EQ)..write("'")..write(uniqueIdValues[0])..write("'");
    } else {
      replace..write(IN)..write("(");
      for (int i = 0; i < uniqueIdValues.length; i++) {
        if (i < uniqueIdValues.length - 1) {
          replace..write("'")..write(uniqueIdValues[i])..write("'")..write(",");
        } else {
          replace..write("'")..write(uniqueIdValues[i])..write("'");
        }
      }
      replace..write(")");
    }
    String buildSql = resSql.replaceAll(MARK, replace.toString());
    Log().logger.i(buildSql);
    return buildSql;
  }

  static List<String> addSelectionArgs(
      List<String> uniqueIdValues, String arg) {
    if (uniqueIdValues == null || uniqueIdValues.length == 0) {
      return [arg];
    }

    List<String> result = new List(uniqueIdValues.length + 1);
    result[0] = arg;
    for (int i = 0; i < uniqueIdValues.length; i++) {
      result[i + 1] = uniqueIdValues[i];
    }
    return result;
  }
}
