/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 16:56

class StringUtil {
  static bool isEmpty(String str) => str == null || str.trim().isEmpty;

  static bool equalsIgnoreCase(String str1, String str2) {
    if (isEmpty(str1) || isEmpty(str2)) return false;
    return str1.trim().toLowerCase() == str2.trim().toLowerCase();
  }
}
