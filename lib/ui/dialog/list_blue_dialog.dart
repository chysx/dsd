import 'package:dsd/application.dart';
import 'package:flutter/material.dart';

import 'model/key_value_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/15 14:22


class RefreshDialogEvent<T> {
  List<KeyValueInfo<T>> data;
}

class ListBlueDialog<T> extends StatefulWidget {
  final String title;
  List<KeyValueInfo<T>> data;
  final Function(KeyValueInfo<T> info) onSelect;
  final Function() onClose;

  ListBlueDialog({this.title, this.data,this.onSelect,this.onClose, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ListDialogState();
  }

  static show<T>(BuildContext context, {String title,List<KeyValueInfo<T>> data,
  Function(KeyValueInfo<T> info) onSelect,Function() onClose}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return new ListBlueDialog(title: title,data: data,onSelect: onSelect,onClose: onClose,);
        });
  }

  static dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }

}
class ListDialogState<T> extends State<ListBlueDialog> {
  StateSetter myState;
  @override
  void initState() {
    super.initState();


    eventBus.on<RefreshDialogEvent>().listen((event){
      if(myState != null)
      myState(() {
        widget.data = event.data;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('**************dispose****************');
    widget.onClose();

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        width: 380,
        height: 220,
        child:StatefulBuilder(builder: (context, state) {
          myState = state;
          return ListView.builder(
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                KeyValueInfo<T> info = widget.data[index];
                return ListTile(
                  onTap: (){
                    widget.onSelect(info);
                    ListBlueDialog.dismiss(context);
                  },
                  title: Text(widget.data[index].name.isEmpty ? 'no name' : widget.data[index].name),
                  subtitle: Text(widget.data[index].value),
                );
              });
        })

      ),
    );
  }

}
