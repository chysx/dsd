import 'dart:io';
import 'dart:typed_data';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/27 11:10

class SignatureDialog extends StatelessWidget {
  void _save(Uint8List data) {
    String storagePath = DirectoryUtil.getStoragePath();
    String dstDir = storagePath + '/img';
    print('dstDir = $dstDir');
    DirectoryUtil.createDirSync(dstDir);
    File file = new File(dstDir + '/test.png');
    file.writeAsBytes(data);
  }

  @override
  Widget build(BuildContext context) {
    var signature = Signature(
      width: 300,
      height: 300,
      backgroundColor: Colors.lightBlueAccent,
    );
    return AlertDialog(
      title: Text('Signature'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[Text('body'), signature],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('ok'),
          onPressed: () async {
            if (signature.isNotEmpty) {
              Uint8List data = await signature.exportBytes();
              _save(data);
            }
          },
        ),
        FlatButton(
          child: Text('cancel'),
          onPressed: () {},
        )
      ],
    );
  }

  static show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return new SignatureDialog();
        });
  }
}
