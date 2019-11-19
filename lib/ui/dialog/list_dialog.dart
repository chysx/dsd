import 'package:flutter/material.dart';

import 'model/key_value_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/15 14:22


class ListDialog<T> extends StatelessWidget {
  final String title;
  final List<KeyValueInfo<T>> data;
  final Function(KeyValueInfo<T> info) onSelect;

  ListDialog({this.title, this.data,this.onSelect, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Container(
        width: 380,
        height: 220,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              KeyValueInfo<T> info = data[index];
              return ListTile(
                onTap: (){
                  onSelect(info);
                  dismiss(context);
                },
                title: Text(data[index].name),
              );
            }),
      ),
    );
  }

  static show<T>(BuildContext context, {String title,List<KeyValueInfo<T>> data,Function(KeyValueInfo<T> info) onSelect}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return new ListDialog(title: title,data: data,onSelect: onSelect,);
        });
  }

  static dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
