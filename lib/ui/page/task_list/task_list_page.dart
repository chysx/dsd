import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/10 18:02

class TaskListPage extends StatefulWidget {
  final String data;
  TaskListPage(this.data);

  @override
  State<StatefulWidget> createState() {
    return new _TaskListState();
  }

}

class _TaskListState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data?? ''),
      ),
      body: Center(
        child: Text('fjdi'),
      ),
    );
  }

}