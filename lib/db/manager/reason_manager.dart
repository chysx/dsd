import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/table/entity/md_dictionary_entity.dart';
import 'package:dsd/ui/dialog/model/key_value_info.dart';

import '../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/17 15:12

class ReasonManager{
  static Future<List<KeyValueInfo>> getReasonData(String reasonCategory)   async {
    List<KeyValueInfo> reasonList = [];
    List<MD_Dictionary_Entity> list = await Application.database.dictionaryDao.findEntityByCategory(reasonCategory,Valid.EXIST);
    for (MD_Dictionary_Entity entity in list) {
      KeyValueInfo reason = new KeyValueInfo();
      reason.name = entity.Description;
      reason.value = entity.Value;
      reasonList.add(reason);
    }
    return reasonList;
  }
}