import 'package:dsd/common/constant.dart';
import 'package:dsd/ui/dialog/list_dialog.dart';
import 'package:dsd/ui/dialog/model/key_value_info.dart';
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
    List list = <KeyValueInfo>[];
    Map map = <String,String>{"aaas":'1',"bbb":'2',"ccc":'3',"aaa11":'1',"bbb22":'2',"ccc33":'3',"aaa66":'1',"bbb77":'2',"ccc88":'3',};
    for(MapEntry<String,String> entry in map.entries){
      KeyValueInfo info1 = KeyValueInfo<String>();
      info1.name = entry.key;
      info1.value = entry.value;
      list.add(info1);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SHIPMENT'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('button'),
          onPressed: (){
//            SignatureDialog.show(context);
          ListDialog.show(context,title: 'shipment',data: list,onSelect: (info){
            print('info = ${info.name}');
          });
          },
        ),
      ),
      drawer: DrawerWidget(),
    );
  }

}

