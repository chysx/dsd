import 'package:dsd/common/constant.dart';
import 'package:dsd/db/util.dart';
import 'package:dsd/res/colors.dart';
import 'package:dsd/res/dimens.dart';
import 'package:dsd/res/strings.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
import 'package:dsd/ui/widget/search_widget.dart';
import 'package:fluintl/fluintl.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/20 10:41

class RoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RouteState();
  }
}

class _RouteState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Text('Route'),
          onLongPress: () {
            DbUtil.copyDb();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          _buildTopContent(),
          Padding(
            padding: EdgeInsets.only(top: 6),
          ),
          _buildCenterContent(),
          Padding(
            padding: EdgeInsets.only(top: 6),
          ),
          _buildBottomContent(),
        ],
      ),
      drawer: DrawerWidget(),
    );
  }

  List<DropdownMenuItem<String>> makeDropList() {
    return <String>["1111111111111", "11111122222111", "1111666666111111"].map((item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: TextStyles.normal,
        ),
      );
    }).toList();
  }

  Widget _buildTopContent() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      color: ColorsRes.gray_normal,
      child: Row(
        children: <Widget>[
          DropdownButton<String>(
              underline: Container(),
              value: '1111111111111',
//                isExpanded: true,
              onChanged: (newValue) {},
              items: makeDropList()),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.map,
                color: ColorsRes.brown_normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterContent() {
    return SearchWidget((str) {
      print(str);
    });
  }

  Widget _buildBottomContent() {
    List<String> items = List.generate(20, (index) => 'item $index');
    return Expanded(
      child: Container(
        color: ColorsRes.gray_normal,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(index),
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: <Widget>[
                SlideAction(
                  child: Text('Print'),
                  color: Colors.grey.shade200,
                ),
                SlideAction(
                  child: Text('Delete'),
                  color: Colors.red,
                ),
              ],
              child: ListTile(
                title: Text('$index'),
              ),
            );
          },
        ),
      ),
    );
  }


}
