import 'package:dsd/res/colors.dart';
import 'package:dsd/res/styles.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/28 15:35

class ListHeaderWidget extends StatelessWidget {
  final List<String> names;
  final List<int> weights;
  final List<TextAlign> aligns;

  ListHeaderWidget({this.names, this.weights, this.aligns,Key key}) : super(key: key);

  List<Widget> _makeWidgets() {
    int position = -1;
    return names.map((item) {
      position++;
      return Expanded(
        flex: weights[position],
        child:   Text(
          item,
          textAlign:aligns[position],
          style: TextStyles.normal,
        )
      );
    }).toList();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: ColorsRes.gray_normal,
      child: Row(
        children: _makeWidgets(),
      ),
    );
  }

}
