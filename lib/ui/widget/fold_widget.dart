import 'package:dsd/res/colors.dart';
import 'package:dsd/res/styles.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/27 17:53

class FoldWidget extends StatefulWidget {
  final Widget child;
  final String msg;
  bool isMore;

  FoldWidget({this.msg,this.isMore = true,this.child, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FoldState();
  }
}

class _FoldState extends State<FoldWidget> {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.isMore ? widget.child : Container();
    Icon icon = widget.isMore
        ? Icon(
            Icons.expand_more,
            color: Colors.grey,
          )
        : Icon(
            Icons.expand_less,
            color: Colors.grey,
          );
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isMore = !widget.isMore;
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            color: ColorsRes.gray_normal,
            child: Row(
              children: <Widget>[
                Text(widget.msg,style: TextStyles.large,),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: icon,
                  ),
                ),
              ],
            ),
          ),
        ),
        child
      ],
    );
  }
}
