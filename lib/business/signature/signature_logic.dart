import 'package:flutter/material.dart';
import 'package:dsd/application.dart';
import 'package:dsd/business/signature/signature_util.dart';
import 'package:dsd/common/system_config.dart';
import 'package:dsd/ui/dialog/signature_dialog.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019-12-11 16:44

abstract class SignatureLogic {
   Future<bool> isNeedRoleSignOff();

   Future<String> getDriverSignOffConfig();

   bool isAuthorization();

   int getFunctionType();

   String getRoleType();

   String accountNumber;
   OnSuccess onSuccess;
   OnFail onFail;

   SignatureLogic({this.accountNumber,this.onSuccess,this.onFail});

  Future show(BuildContext context) async {
    if(!await isNeedRoleSignOff()) {
      progressDriverSignOff(context);
      return;
    }
    progressRoleSignOff(context);
  }

   Future progressRoleSignOff(BuildContext context) async {
     Role role = await SignatureUtil.getRole(getRoleType(), accountNumber);
     String authorization = isAuthorization() ? CommonFunction.CHECKER_AUTHORIZATION_NEED : CommonFunction.CHECKER_AUTHORIZATION_NOTNEED;

     SignatureDialog.show(context,
         title: role.title,
         name: role.name,
         code: role.code,
         role: role.role,
         signatureName: SignatureUtil.createSignaturePath(getFunctionType()),
         authorization: authorization,

         onSuccess: (context,info){
           if(onSuccess != null){
             onSuccess(context,info);
           }

           progressDriverSignOff(context);
         },
         onFail: (context,info){
           Navigator.of(context).pop();
           if(onFail != null){
             onFail(context,info);
           }
         }
     );
   }

  Future progressDriverSignOff(BuildContext context) async {
    if(await getDriverSignOffConfig() == CommonFunction.DRIVER_SIGN_OFF_NOTNEED)
      return;

    SignatureDialog.show(context,
      title: 'DRIVER SIGN OFF',
      name: Application.user.userName,
      code: Application.user.userCode,
      role: 'Driver',
      signatureName: SignatureUtil.createSignaturePath(getFunctionType()),
      authorization: CommonFunction.CHECKER_AUTHORIZATION_NOTNEED,

      onSuccess: (context,info) async {
        if(await isNeedRoleSignOff()) Navigator.of(context).pop();
        Navigator.of(context).pop();
        if(onSuccess != null){
          onSuccess(context,info);
        }
      },
      onFail: (context,info){
        Navigator.of(context).pop();
        if(onFail != null){
          onFail(context,info);
        }
      }
    );
  }

}

class SignatureResultInfo {
  String name;
  String code;
  String signatureName;
}

class Role {
  String title;
  String name = "";
  String code = "";
  String role;
}

typedef OnFail = void Function(BuildContext context,SignatureResultInfo info);
typedef OnSuccess = void Function(BuildContext context,SignatureResultInfo info);