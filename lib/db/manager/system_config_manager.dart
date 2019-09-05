import 'package:dsd/common/business_const.dart';
import 'package:dsd/db/table/entity/dsd_m_system_config_entity.dart';

import '../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/4 11:03

class SystemManager {
  static Future<String> getSystemConfigValue(String category,String keyName) async {
    DSD_M_SystemConfig_Entity entity = await Application.database.mSystemConfigDao.findEntityByCon(category,keyName,Valid.EXIST);
    return entity == null ? "" : entity.Value?? '';
  }

  static Future<bool> getValueByBoolean(String category,String keyName) async {
    String result = await getSystemConfigValue(category,keyName) ;
    return result == Show.YES;
  }
}