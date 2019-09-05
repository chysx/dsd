import 'package:dsd/res/strings.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/23 14:16

class SearchWidget extends StatelessWidget {
  final Function(String str) onSearch;
  final TextEditingController hostCtrl = new TextEditingController();
  SearchWidget(this.onSearch, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final BehaviorSubject subject = BehaviorSubject<String>();
    subject.debounceTime(Duration(seconds: 1)).listen((str) {
      onSearch(str);
    });
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
        height: 36,
        child: Theme(
          data: ThemeData(primaryColor: Colors.grey),
          child: TextField(
            style: TextStyles.normal,
            controller: hostCtrl,
            onChanged: (str) {
              subject.add(str);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 0, bottom: 0),
              hintText: IntlUtil.getString(context, Ids.userName),
              prefixIcon: GestureDetector(
                onTap: () {
                  CustomerDialog.showCustomerDialog(context, msg: 'hahaha');
                },
                child: Icon(Icons.search),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  CustomerDialog.showCustomerDialog(context, msg: 'hahaha');
                },
                child: Icon(Icons.highlight_off),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

