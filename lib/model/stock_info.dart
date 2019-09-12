/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/11 17:52

class StockInfo {
  String productCode;
  int cs;
  int ea;
  int planCs;
  int planEa;

  int getCsChange() {
    return planCs - cs;
  }

  int getEaChange() {
    return planEa - ea;
  }
}
