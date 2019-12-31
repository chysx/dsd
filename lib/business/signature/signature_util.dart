import 'package:flustars/flustars.dart';
import 'package:dsd/application.dart';
import 'package:dsd/business/signature/signature_logic.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/db/table/entity/md_account_entity.dart';
import 'package:uuid/uuid.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019-12-11 16:00

class SignatureUtil {
   static String createSignaturePath(int bizModel) {
     String day = DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.YEAR_MONTH_DAY);
    String uuid = Uuid().v1().replaceAll("-","");
    return '$day-$bizModel-$uuid.jpg';
  }

  static Future<Role> getRole(String userType, String accountNumber) async {
     Role role = new Role();
     if(userType == UserType.CUSTOMER){
       MD_Account_Entity entity = await Application.database.accountDao.findEntityByAccountNumber(accountNumber);
       role.title = 'CUSTOMER SIGN OFF';
       role.role = 'Customer';
       if (entity != null) {
         role.name = entity.Name;
         role.code = entity.AccountNumber;
       }
     }
     return role;
   }

}

