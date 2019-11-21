import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

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

  void scan(Function(List<BluetoothDevice> result) call) {
    cancel();
    map.clear();
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((scanResult) {
      for (ScanResult result in scanResult) {
        map[result.device.id.toString()] = result.device;
      }
    });

    flutterBlue.isScanning.listen((isScanning) {
      if (isScanning) {
        print('scanning');
      } else {
        print('********************scanning end');
        print('size = ${map.length}');
        if (map.length <= 0) return;

        List<BluetoothDevice> deviceList = map.values.map((device) {
          print('name = ${device.name} id = ${device.id}');
          return device;
        }).toList();
        deviceList.removeWhere((device){
          return device.name.isEmpty;
        });
        call(deviceList);
      }
    });
  }

  void cancel() {
    flutterBlue.stopScan();
  }

  Future sendAddress(String address) async {
    var platform = const MethodChannel('com.ebest.dsd.bluetooth/sendAddress');
    try {
      await platform.invokeMethod('sendAddress',<String,String>{'address': address});
    } on PlatformException catch (e) {
    }
  }
}
