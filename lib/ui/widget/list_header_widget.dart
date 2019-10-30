import 'package:dsd/res/dimens.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/utils/string_util.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/28 15:35

class ListHeaderWidget extends StatefulWidget {
  final List<String> names;
  final List<String> supNames;
  final List<int> weights;
  final List<TextAlign> aligns;
  final bool isCheck;
  final bool isBold;
  final Function(bool) onChange;

  ListHeaderWidget({this.names, this.supNames, this.weights, this.aligns, this.isCheck, this.isBold = false, this.onChange, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListHeaderState(isCheck:isCheck);
  }
}

class _ListHeaderState extends State<ListHeaderWidget> {
  bool isCheck;

  _ListHeaderState({this.isCheck});

  TextStyle _getTextStyle(){
    return widget.isBold ? TextStyle(fontSize: Dimens.font_normal,fontWeight: FontWeight.bold) : TextStyles.normal;
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

  Widget _getSupWidget(int position) {
    if (widget.supNames != null && !StringUtil.isEmpty(widget.supNames[position])) {
      return Text(
        widget.supNames[position],
        textAlign: widget.aligns[position],
        style: widget.isBold ? TextStyle(fontSize: Dimens.font_small,fontWeight: FontWeight.bold) : TextStyles.small,
      );
    }
    return Container();
  }

  List<Widget> _makeWidgets() {
    int position = -1;
    List<Widget> list = [];
    list.addAll(widget.names.map((item) {
      position++;
      return Expanded(
          flex: widget.weights[position],
          child: Column(
            children: <Widget>[
              Text(
                item,
                textAlign: widget.aligns[position],
                style: widget.isBold ? TextStyle(fontSize: Dimens.font_normal,fontWeight: FontWeight.bold) : TextStyles.normal,
              ),
              _getSupWidget(position)
            ],
          ));
    }).toList());

    if (isCheck != null) {
      Widget checkBox = Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.center,
            child: Checkbox(
              value: isCheck,
              onChanged: (value) {
                setState(() {
                  isCheck = value;
                });
                if (widget.onChange != null) widget.onChange(value);
              },
            ),
          ));

      list.add(checkBox);
    }

    return list;
  }
}
