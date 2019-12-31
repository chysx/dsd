import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/profile/note_info.dart';
import 'package:dsd/ui/page/profile/order_info.dart';
import 'package:dsd/ui/page/profile/profile_presenter.dart';
import 'package:dsd/ui/widget/fold_widget.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
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

class _SyncState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Profile'),
    Tab(text: 'Order'),
    Tab(text: 'Note')
  ];

  Widget createProfile(ProfilePresenter presenter) {
    List<MapEntry<String, String>> list = presenter.profileStoreList;
    List<Widget> rowList = list.map((item) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Text(
              '${item.key}:',
              style: TextStyles.normal,
            ),
            Spacer(),
            Expanded(
              child: Text(
                item.value ?? '',
                style: TextStyles.normal,
              ),
            )
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

  Widget createOrder(ProfilePresenter presenter) {
    var header = ListHeaderWidget(
      names: ["Date", "Order No.", "Type", "Qty", "Status"],
      weights: [1, 1, 1, 1, 1],
      aligns: [
        TextAlign.center,
        TextAlign.center,
        TextAlign.center,
        TextAlign.center,
        TextAlign.center,
      ],
    );

    return Column(
      children: <Widget>[
        header,
        Expanded(
          child: ListView.separated(
            itemCount: presenter.orderInfoList.length,
            separatorBuilder: (context, index) {
              return Divider(
                height: 2,
              );
            },
            itemBuilder: (context, index) {
              OrderInfo info = presenter.orderInfoList[index];
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1,
                                style: BorderStyle.solid),
                            shape: BoxShape.circle),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                            ),
                            Text(
                              info.getShowDay(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              info.getShowDate(),
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        info.no ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        info.type ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        info.qty ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        info.status ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  List<TextEditingController> descList = [];
  void initControllerCs(ProfilePresenter presenter) {
//    if(csList.length > 0) return ;
    descList.clear();
    for (NoteInfo info in presenter.noteInfoList) {
      TextEditingController controller = TextEditingController.fromValue(TextEditingValue(
        // 设置内容
          text: (info.dsc ?? '').toString(),
          // 保持光标在最后
          selection: TextSelection.fromPosition(
              TextPosition(affinity: TextAffinity.downstream, offset: (info.dsc ?? '').toString().length))));

      controller.addListener(() {
        info.dsc = controller.text;
      });
      descList.add(controller);
    }
  }

  Widget createNote(ProfilePresenter presenter) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                height: 2,
              );
            },
            itemCount: presenter.noteInfoList.length,
            itemBuilder: (context, index) {
              NoteInfo info = presenter.noteInfoList[index];
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          info.getShowDate(),
                          style: TextStyles.normal,
                        ),
                        Spacer(),
                        Text(
                          info.name ?? '',
                          style: TextStyles.normal,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    TextField(
                      controller:
                      descList.length > 0 ? descList[index] : new TextEditingController(),
                      enabled: presenter.isFromVisit,
                      style: TextStyles.normal,
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
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
        centerTitle: true,
        title: Text('CUSTOMER PROFILE'),
        bottom: TabBar(
          controller: tabController,
          tabs: myTabs,
        ),
      ),
      body: Consumer<ProfilePresenter>(builder: (context, presenter, _) {
        initControllerCs(presenter);
        return TabBarView(
          controller: tabController,
          children: <Widget>[
            createProfile(presenter),
            createOrder(presenter),
            createNote(presenter)
          ],
        );
      }),
    );
  }
}
