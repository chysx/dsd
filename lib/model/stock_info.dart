/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/11 17:52

class StockInfo {
  String productCode;
  int cs = 0;
  int ea = 0;
  int planCs = 0;
  int planEa = 0;

  int getCsChange() {
    return planCs - cs;
  }

  int getEaChange() {
    return planEa - ea;
  }
}
