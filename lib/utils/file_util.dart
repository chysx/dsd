import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dsd/application.dart';
import 'package:dsd/common/constant.dart';
import 'package:flustars/flustars.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019-11-07 14:23

class FileUtil {

  static String getFilePath(String fileDir) {
    String dstDir;
    if(Platform.isAndroid){
      dstDir = DirectoryUtil.getStoragePath(category: fileDir);
    }else if(Platform.isIOS) {
      dstDir = DirectoryUtil.getAppDocPath(category: fileDir);
    }

    Application.logger.i('dstDir = $dstDir');

    return dstDir;

  }

  static Future saveFileData(Uint8List data,String fileDir,String fileName) async {
    String dstDir = getFilePath(fileDir);
    if(dstDir == null) return;
    DirectoryUtil.createDirSync(dstDir);
    File file = new File(dstDir + '/' + fileName);
    await file.writeAsBytes(data);
  }

  static Uint8List readFileData(String fileDir,String fileName) {
    String dstDir = getFilePath(fileDir);
    Uint8List result;
    try{
      File file = new File(dstDir + '/' + fileName);
      result =  file.readAsBytesSync();
    }catch(e) {
      Application.logger.e(e.toString());
    }
    return result;
  }

  static writeString(Map<String, dynamic> content) async {
    String dstDir = getFilePath(Constant.WORK_LOG);
    if(dstDir == null) return;
    DirectoryUtil.createDirSync(dstDir);
    File file = new File(dstDir + '/' + 'log.txt');
    file.open(mode: FileMode.append);
    await file.writeAsString(jsonEncode(content));
  }

  ///
  /// 获取全路径中的不带拓展名的文件名
  ///
  /// @param filePath 文件路径
  /// @return 不带拓展名的文件名
  ///
  static String getFileNameNoExtension(String filePath) {
    if (filePath == null || filePath.isEmpty) return filePath;
    int lastIndex = filePath.lastIndexOf('.');
    if(lastIndex == -1) return filePath;
    return filePath.substring(0,lastIndex);
  }

}