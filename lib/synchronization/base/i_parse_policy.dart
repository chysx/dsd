/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/26 18:03

abstract class IParsePolicy {
  void policy();

  bool isAllDataAndAllInsert(String tableName);
}
