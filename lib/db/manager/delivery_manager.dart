import 'package:dsd/application.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/4 14:25

class DeliveryManager {
  static Future insertOrUpdateDeliveryHeader(DSD_T_DeliveryHeader_Entity header) async {
    DSD_T_DeliveryHeader_Entity entity = await Application.database.tDeliveryHeaderDao.findEntityByDeliveryNo(header.DeliveryNo);
    if(entity == null){
      await Application.database.tDeliveryHeaderDao.insertEntity(header);
    }else{
      await Application.database.tDeliveryHeaderDao.updateEntity(header);
    }
  }

}