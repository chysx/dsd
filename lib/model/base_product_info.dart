/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/16 14:26

class BaseProductInfo {
   String code;
   String name;
   int plannedCs;
   int plannedEa;
   int actualCs;
   int actualEa;
   String itmNumberCs;
   String itmNumberEa;
   String pack;
   String reasonValue;
  //该产品code是否存在DSD_M_DeliveryItem表中
   bool isInMDelivery;
   bool isCheck = false;
}