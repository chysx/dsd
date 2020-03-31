import 'dart:async';

import 'package:dsd/application.dart';
import 'package:dsd/ui/dialog/list_blue_dialog.dart';
import 'package:dsd/ui/dialog/loading_dialog.dart';
import 'package:dsd/ui/dialog/model/key_value_info.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rxdart/rxdart.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/30 17:42

class BlueManager {
  static BlueManager _instance;

  BlueManager._();

  static BlueManager _getInstance() {
    if (_instance == null) {
      _instance = new BlueManager._();
    }
    return _instance;
  }

  factory BlueManager() => _getInstance();

  FlutterBlue flutterBlue = FlutterBlue.instance;

  Map<String, BluetoothDevice> map = {};

  BehaviorSubject subject = BehaviorSubject<int>();

  void scan(BuildContext context,Function(List<BluetoothDevice> result) call) {
    LoadingDialog.show(context,msg: 'loading...');
//    cancel();
//    map.clear();
    subject = BehaviorSubject<int>();
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((scanResult) {
      for (ScanResult result in scanResult) {
        map[result.device.id.toString()] = result.device;
      }
    });

    bool isHasEnd = false;
    int index = 0;
    flutterBlue.isScanning.listen((isScanning) {
      if (isScanning) {
        print('********************scan loading');
      } else {
        if(!isHasEnd){
          isHasEnd = true;
          LoadingDialog.dismiss(context);
          print('********************scan end');

          List<BluetoothDevice> deviceList = map.values.map((device) {
            print('name = ${device.name} id = ${device.id}');
            return device;
          }).toList();
          call(deviceList);
        }else{
          index++;
          subject.add(index);
        }

//        print('size = ${map.length}');

//        deviceList.removeWhere((device){
//          return device.name.isEmpty;
//        });
//        call(deviceList);
      }
    });


    subject
        .delay(Duration(milliseconds: 1000))
        .debounceTime(Duration(milliseconds: 1000))
        .listen((index) {

      List<BluetoothDevice> deviceList = map.values.map((device) {
        print('name = ${device.name} id = ${device.id}');
        return device;
      }).toList();

      List<KeyValueInfo> list = deviceList.map((device){
        return new KeyValueInfo()
          ..name = device.name
          ..value = device.id.toString()
          ..data = device;
      }).toList();

      eventBus.fire(new RefreshDialogEvent()..data = list);
    });

  }



  void cancel() {
    flutterBlue.stopScan();
    subject.close();
    map.clear();
  }

  Future sendAddress(String address) async {
    var platform = const MethodChannel('com.ebest.dsd.bluetooth/sendAddress');
    try {
      await platform.invokeMethod('sendAddress',<String,String>{'address': address});
    } on PlatformException catch (e) {
    }
  }
}
