import 'dart:typed_data';

import 'package:dsd/business/signature/signature_logic.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/res/colors.dart';
import 'package:dsd/res/dimens.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/utils/file_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signature/signature.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/27 11:10

class SignatureDialog extends StatefulWidget {
  final String title;
  String name;
  String code;
  final String role;
  final String signatureName;
  final String authorization;
  final OnSuccess onSuccess;
  final OnFail onFail;
  final bool isShowCustomerNot;

  TextEditingController userCtrl;
  TextEditingController pwdCtrl;

  SignatureDialog(
      {this.title,
        this.name,
        this.code,
        this.isShowCustomerNot,
        this.role,
        this.signatureName,
        this.authorization,
        this.onSuccess,
        this.onFail,
        Key key})
      : super(key: key);

  static show(BuildContext context,
      {String title,
        String name,
        String code,
        String role,
        bool isShowCustomerNot = false,
        String signatureName,
        String authorization,
        OnSuccess onSuccess,
        OnFail onFail}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return new SignatureDialog(
            title: title,
            name: name,
            code: code,
            role: role,
            isShowCustomerNot: isShowCustomerNot,
            signatureName: signatureName,
            authorization: authorization,
            onSuccess: onSuccess,
            onFail: onFail,
          );
        });
  }

  static dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  State<StatefulWidget> createState() {
    return _SignatureState(name, code,role);
  }
}

class _SignatureState extends State<SignatureDialog> {
  String name;
  String code;
  String role;
  Signature signature;
  bool isSelect = false;

  TextEditingController nameCtrl;
  TextEditingController codeCtrl;

  _SignatureState(this.name, this.code,this.role);

  @override
  Widget build(BuildContext context) {
    if (signature == null) {
      signature = Signature(
        width: 300,
        height: 300,
        backgroundColor: Colors.white,
      );
    }
    ctrlName();
    ctrlCode();
    return AlertDialog(
      backgroundColor: ColorsRes.gray_normal,
      contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                padding:
                EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 60,
                              child: Row(children: <Widget>[
                                Text(
                                  'Name:',
                                  style: TextStyles.normal,
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(color: Colors.red , fontSize: Dimens.font_normal),
                                ),
                              ],),
                            ),

                            Theme(
                              data: ThemeData(
                                  primaryColor: ColorsRes.gray_normal),
                              child: SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: nameCtrl,
                                  style: TextStyles.normal,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 10, right: 10, top: 3, bottom: 3),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 60,
                              child: Row(children: <Widget>[
                                Text(
                                  'Title:',
                                  style: TextStyles.normal,
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(color: Colors.red , fontSize: Dimens.font_normal),
                                ),
                              ],),
                            ),
                            Theme(
                              data: ThemeData(
                                  primaryColor: ColorsRes.gray_normal),
                              child: SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: codeCtrl,
                                  style: TextStyles.normal,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 10, right: 10, top: 3, bottom: 3),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Offstage(
                          offstage: !widget.isShowCustomerNot,
                          child: Row(children: <Widget>[
                            Checkbox(
                              value: isSelect,
                              onChanged: (value){
                                setState(() {
                                  isSelect = !isSelect;
                                });
                              },
                            ),
                            Text(
                              'Customer not available',
                              style: TextStyles.normal,
                            ),
                          ],),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 1)),
              signature
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('ok'),
          onPressed: () {
            saveSignature(context, signature);
          },
        ),
        FlatButton(
          child: Text('cancel'),
          onPressed: () {
            SignatureDialog.dismiss(context);
          },
        )
      ],
    );
  }

  void ctrlName() {
    nameCtrl = TextEditingController.fromValue(TextEditingValue(
      // 设置内容
        text: (name ?? '').toString(),
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: (name ?? 0).toString().length))));
    nameCtrl.addListener(() {
      name = nameCtrl.text;
    });
  }

  void ctrlCode() {
    codeCtrl = TextEditingController.fromValue(TextEditingValue(
      // 设置内容
        text: (role ?? '').toString(),
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: (role ?? 0).toString().length))));
    codeCtrl.addListener(() {
      role = codeCtrl.text;
    });
  }


  Future saveSignature(BuildContext context, Signature signature) async {
    if (signature.isNotEmpty) {
      SignatureResultInfo info = new SignatureResultInfo();
      info.name = name;
      info.code = code;
      info.signatureName = widget.signatureName;
      info.isSelectedCustomerNot = isSelect;
      try {
        Uint8List data = await signature.exportBytes();
        FileUtil.saveFileData(data, Constant.WORK_IMG, info.signatureName);
        if (widget.onSuccess != null) widget.onSuccess(context, info);
      } catch (e) {
        if (widget.onFail != null) widget.onFail(context, info);
      }
    } else {
      Fluttertoast.showToast(msg: 'You must signature.');
    }
  }
}
