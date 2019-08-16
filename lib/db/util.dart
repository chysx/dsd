import 'dart:io';

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
    String appDocPath = DirectoryUtil.getAppDocPath();
    String dbPath = appDocPath.substring(0,appDocPath.lastIndexOf('com.ebest.dsd')) + 'com.ebest.dsd' + '/databases/dsd.db';
    String storagePath = DirectoryUtil.getStoragePath();
    String dstDir = storagePath + '/db';
    print('dstDir = $dstDir');
    DirectoryUtil.createDirSync(dstDir);
    File file = File(dbPath);
    file.copySync(dstDir + '/dsd.db');

    Fluttertoast.showToast(
        msg: "copy db",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,

        fontSize: 16.0
    );
  }
}
