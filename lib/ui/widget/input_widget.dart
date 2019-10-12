import 'package:dsd/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/10 15:41

class InputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Theme(
        data: ThemeData(primaryColor: Colors.grey),
        child: TextField(
          style: TextStyles.small,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 0, bottom: 0),
          ),
        ),
      ),
    );
  }

}