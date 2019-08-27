import 'package:dsd/common/constant.dart';
import 'package:dsd/ui/dialog/signature_dialog.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/26 17:06

class CheckInShipmentPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CheckInShipmentState();
  }

}

class _CheckInShipmentState extends State<CheckInShipmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SHIPMENT'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('button'),
          onPressed: (){
            SignatureDialog.show(context);
          },
        ),
      ),
      drawer: DrawerWidget(),
    );
  }

}

