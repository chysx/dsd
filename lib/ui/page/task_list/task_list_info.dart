

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/12 10:32

class TaskInfo {
  String no;
  String imgPath;
  String name;
  String description;
  String type;
  String status;
  bool isMust;
  bool isScroll;
  bool isRebook;
  int weight;
  String orderNo;
}

class Weight {
  static const int DeliveryX = 1;
  static const int TradeReturnX = 2;
  static const int EmptyReturnX = 3;
  static const int Delivery = 4;
  static const int VanSales = 5;
  static const int TradeReturn = 6;
  static const int EmptyReturn = 7;
  static const int PreSales = 8;
  static const int AR_Collection = 9;
  static const int Document = 10;
  static const int Survey = 11;
  static const int Note = 12;
}
