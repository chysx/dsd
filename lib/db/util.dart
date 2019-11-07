import 'dart:io';

import 'package:dsd/common/constant.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/16 16:39

class DbUtil{
  static void copyDb(){
    if(!Platform.isAndroid) return;

    String packageName = 'com.ebest.dsd';
    String appDocPath = DirectoryUtil.getAppDocPath();
    String dbPath = appDocPath.substring(0,appDocPath.lastIndexOf(packageName)) + packageName + '/databases/' + Constant.DB_NAME;
    String dstDir = DirectoryUtil.getStoragePath(category: Constant.WORK_DB);
    print('dstDir = $dstDir');
    DirectoryUtil.createDirSync(dstDir);
    File file = File(dbPath);
    file.copySync(dstDir + '/' + Constant.DB_NAME);

    Fluttertoast.showToast(
        msg: "copy db",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,

        fontSize: 16.0
    );
  }
}
