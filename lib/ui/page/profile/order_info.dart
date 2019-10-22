import 'package:dsd/common/constant.dart';
import 'package:flustars/flustars.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/8 15:41

class OrderInfo {
  String no;
  String date;
  String type;
  String qty;
  String price;
  String status;

  String getShowDay(){
    if(date == null || date.isEmpty) return '';
    DateTime dateTime = DateUtil.getDateTime(date);
    return dateTime.day.toString();
  }

  String getShowDate(){
    if(date == null || date.isEmpty) return '';
    DateTime dateTime = DateUtil.getDateTime(date);
    return getMonth(dateTime.month) + ' ' + dateTime.year.toString();
  }
}