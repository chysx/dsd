import 'package:dsd/common/constant.dart';
import 'package:flustars/flustars.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/9 11:14

class NoteInfo {
  String date;
  String name;
  String dsc;

  String getShowDate(){
    if(date == null || date.isEmpty) return '';
    DateTime dateTime = DateUtil.getDateTime(date);
    return getMonth(dateTime.month) + ' ' + dateTime.day.toString() + ' ' + dateTime.year.toString();
  }
}
