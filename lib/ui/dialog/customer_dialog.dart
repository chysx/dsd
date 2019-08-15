import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/15 14:22


typedef OnConfirm = void Function();
typedef OnCancel= void Function();

class CustomerDialog extends StatelessWidget {
  final OnConfirm onConfirm;
  final OnCancel onCancel;

  CustomerDialog({this.onConfirm,this.onCancel,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Title'),
      content: Text('zhang guo peng'),
      actions: <Widget>[
        FlatButton(
          child: Text('ok'),
          onPressed: () {
            dismiss(context);
            if(onConfirm != null) onConfirm();
          },
        ),
        FlatButton(
          child: Text('cancel'),
          onPressed: () {
            dismiss(context);
            if(onCancel != null) onCancel();
          },
        )
      ],
    );
  }

  static showCustomerDialog(BuildContext context,{OnConfirm onConfirm,OnCancel onCancel}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return new CustomerDialog(onConfirm: onConfirm,onCancel: onCancel);
        });
  }

  static dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
