import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/profile/profile_presenter.dart';
import 'package:dsd/ui/widget/fold_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/19 11:08

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SyncState();
  }
}

class _SyncState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  TabController tabController;
  final List<Tab> myTabs = <Tab>[Tab(text: 'Profile'), Tab(text: 'Order'), Tab(text: 'Note')];

  Widget createProfile(ProfilePresenter presenter) {
    List<MapEntry<String, String>> list = presenter.profileStoreList;
    List<Widget> rowList = list.map((item) {
      return Padding(
        padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
        child: Row(
          children: <Widget>[
            Text('${item.key}:',style: TextStyles.normal,),
            Spacer(),
            Text(item.value,style: TextStyles.normal,),
          ],
        ),
      );
    }).toList();
    return FoldWidget(
      msg: 'STORE INFO',
      child: Column(
        children: rowList,
      ),
    );
  }

  Widget createOrder() {
    return Center(
      child: Text('zhang'),
    );
  }

  Widget createNote() {
    return Center(
      child: Text('zhang'),
    );
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
        title: Text('CUSTOMER PROFILE'),
        bottom: TabBar(
          controller: tabController,
          tabs: myTabs,
        ),
      ),
      body: Consumer<ProfilePresenter>(builder: (context, presenter, _) {
        return TabBarView(
          controller: tabController,
          children: <Widget>[createProfile(presenter), createOrder(), createNote()],
        );
      }),
    );
  }
}
