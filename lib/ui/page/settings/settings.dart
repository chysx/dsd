import 'package:dsd/res/colors.dart';
import 'package:dsd/res/dimens.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/settings/settings_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/2 15:21

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingState();
}

class _SettingState extends State<SettingsPage> {
  SettingPresenter presenter;
  TextEditingController hostCtrl = TextEditingController();
  TextEditingController portCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    presenter = new SettingPresenter();
    presenter.initData();

    ctrlHost();
    ctrlPort();
  }

  void ctrlHost() {
    hostCtrl.text = presenter.curSettingInfo.host;
    hostCtrl.addListener(() {
      presenter.curSettingInfo.host = hostCtrl.text;
    });
  }

  void ctrlPort() {
    portCtrl.text = presenter.curSettingInfo.port;
    portCtrl.addListener(() {
      presenter.curSettingInfo.port = portCtrl.text;
    });
  }

  List<DropdownMenuItem<String>> makeDropList() {
    return presenter.settingList.map((item){
      return DropdownMenuItem(
        value: item.env,
        child: Text(item.env,style: TextStyles.normal,),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimens.space_normal),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    child: Text(
                      'SSL:',
                      style: TextStyles.normal,
                    ),
                  ),
                  Checkbox(
                    value: presenter.curSettingInfo.isSsl,
                    onChanged: (value) {
                      setState(() {
                        presenter.curSettingInfo.isSsl = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    child: Text(
                      'Server:',
                      style: TextStyles.normal,
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: presenter.curSettingInfo.env,
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          presenter.setCurSettingInfo(newValue);
                        });
                      },
                      items: makeDropList()
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    child: Text(
                      'Address:',
                      style: TextStyles.normal,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: hostCtrl,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    child: Text(
                      'Port:',
                      style: TextStyles.normal,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: hostCtrl,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: ColorsRes.brown_normal,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
