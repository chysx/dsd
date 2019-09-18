
import 'package:dsd/res/styles.dart';
import 'package:dsd/utils/string_util.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/28 15:35

class ListHeaderWidget extends StatelessWidget {
  final List<String> names;
  final List<String> supNames;
  final List<int> weights;
  final List<TextAlign> aligns;

  ListHeaderWidget({this.names, this.supNames, this.weights, this.aligns, Key key}) : super(key: key);

  Widget _getSupWidget(int position) {
    if(supNames != null && !StringUtil.isEmpty(supNames[position])){
      return Text(
        supNames[position],
        textAlign: aligns[position],
        style: TextStyles.small,
      );
    }
    return Container();
  }

  List<Widget> _makeWidgets() {
    int position = -1;

    return names.map((item) {
      position++;
      return Expanded(
          flex: weights[position],
          child: Column(
            children: <Widget>[
              Text(
                item,
                textAlign: aligns[position],
                style: TextStyles.normal,
              ),
              _getSupWidget(position)
            ],
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: _makeWidgets(),
      ),
    );
  }
}
