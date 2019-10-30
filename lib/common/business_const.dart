/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/22 10:06

/// 对应数据库中的Valid字段
class Valid {
  /// 存在
  static const String EXIST = "True";

  /// 不存在
  static const String NOT_EXIST = "False";
}

///
/// 根据配置控制View是显示与隐藏
///
class Show {
  /// 显示
  static const String YES = "1";

  /// 隐藏

  static const String NO = "0";

  /// 显示

  static const String TRUE = "True";

  /// 隐藏

  static const String FALSE = "False";
}

///
/// 根据配置控制
///
class IsReturn {
  /// 显示

  static const String TRUE = "True";

  /// 隐藏

  static const String FALSE = "False";
}

///
/// 根据配置控制（MD_Product表中的ebMobile__IsEmpty__c字段）
///
class Empty {
  ///
  /// 空瓶产品
  ///
  static const String TRUE = "True";

  ///
  /// 非空瓶产品
  ///
  static const String FALSE = "False";
}

class ProductUnit {
  static const String CS_EA = "CS_EA";
  static const String CS = "CS";
  static const String EA = "EA";
  static const String CS_EA_VALUE = "1";
  static const String CS_VALUE = "0";
  static const String EA_VALUE = "2";
}

class StockTracking {
  static const String CATEGORY = "StockTracking";
  static const String CHKO = "CHKO";
  static const String CHKI = "CHKI";
  static const String DELE = "DELE";
  static const String ERET = "ERET";
  static const String TRET = "TRET";
  static const String VASL = "VASL";
}

class StockChildTracking {
  static const String CATEGORY = "StockChildTracking";
  static const String CHKO_DELIVERY = "CHKO_DELIVERY";
  static const String CHKO_VANSALE = "CHKO_VANSALE";
  static const String CHKI_DELIVERY = "CHKI_DELIVERY";
  static const String CHKI_EMPTYRETURN = "CHKI_EMPTYRETURN";
  static const String CHKI_TRADERETURN = "CHKI_TRADERETURN";
  static const String CHKI_VANSALE = "CHKI_VANSALE";
  static const String EMPTY_IN_DELIVERY = "EMPTY_IN_DELIVERY";
  static const String EMPTY_IN_VANSALE = "EMPTY_IN_VANSALE";
}

class ActionType {
  static const String CheckOut = "CHKO";
  static const String CheckIn = "CHKI";
}
