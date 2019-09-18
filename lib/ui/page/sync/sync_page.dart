import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/26 17:17

class SyncPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SyncState();
  }
}

class _SyncState extends State<SyncPage> with SingleTickerProviderStateMixin {
  TabController tabController;
  final List<Tab> myTabs = <Tab>[Tab(text: 'left'), Tab(text: 'right')];

  List<Widget> getWidgets() {
    return myTabs.map((tab) {
      return Center(
        child: Text(tab.text),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SYNC'),
        bottom: TabBar(
          controller: tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: getWidgets(),
      ),
    );
  }
}
