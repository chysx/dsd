import 'dart:convert';
import 'dart:io';

import 'package:dsd/common/constant.dart';
import 'package:dsd/utils/file_util.dart';
import 'package:flutter/widgets.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-03-13 12:57

class CodeUtil{
/*
  * Base64加密
  */
  static String base64EncodeByString(String data){
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }
  /*
  * Base64加密
  */
  static String base64EncodeByMap(Map<String,dynamic> data){
  var content = utf8.encode(jsonEncode(data));
  var digest = base64Encode(content);
  return digest;
  }
  /*
  * Base64加密
  */
  static String jsonMap2String(Map<String,dynamic> data){
//    var content = utf8.encode(jsonEncode(data));
//    return content as String;
    return jsonEncode(data);
  }
  /*
  * Base64解密
  */
  static String base64DecodeUtil(String data){
    List<int> bytes = base64Decode(data);
    // 网上找的很多都是String.fromCharCodes，这个中文会乱码
    //String txt1 = String.fromCharCodes(bytes);
    String result = utf8.decode(bytes);
    return result;
  }
  /*
  * 通过图片路径将图片转换成Base64字符串
  */
  static Future<String> image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  /*
  * 将图片文件转换成Base64字符串
  */
  static Future<String> imageFile2Base64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  /*
  * 将Base64字符串的图片转换成图片
  */
  static Future<Image> base642Image(String base64Txt) async {
    var decodeTxt = base64.decode(base64Txt);
    return Image.memory(decodeTxt,
      width:100,fit: BoxFit.fitWidth,
      gaplessPlayback:true, //防止重绘
    );
  }

  static Future<Image> base642Image22(String base64Txt) async {
    var decodeTxt = base64.decode(base64Txt);
    FileUtil.saveFileData(decodeTxt, Constant.WORK_IMG, 'test.jpg');
  }
}