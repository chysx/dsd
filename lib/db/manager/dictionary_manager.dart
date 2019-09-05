import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/table/entity/md_dictionary_entity.dart';

import '../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/29 18:16

class DictionaryManager {
  static Future<String> getDictionaryDescription(String category,String value) async {
    MD_Dictionary_Entity entity = await Application.database.dictionaryDao.findEntityByCon(category,value,Valid.EXIST);
    return entity == null ? "" : entity.Description?? '';
  }
}