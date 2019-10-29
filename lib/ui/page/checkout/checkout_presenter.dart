import 'package:dsd/application.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/check_out_and_in_model.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/sync_manager.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/30 11:43

enum CheckOutEvent { InitData }

class CheckoutPresenter extends EventNotifier<CheckOutEvent> {
  String shipmentNo;

  @override
  void onEvent(CheckOutEvent event, [dynamic data]) async {
    switch (event) {
      case CheckOutEvent.InitData:
        await initData();
        break;
    }

    super.onEvent(event, data);
  }

  void setPageParams(Map<String, List<String>> params) {
    shipmentNo = params[FragmentArg.ROUTE_SHIPMENT_NO].first;
  }

  Future initData() async {
    await CheckOutModel().initData(shipmentNo);
  }

  bool isComplete() {
    return CheckOutModel().shipmentItemList.length > 0;
  }

  String getIsCompleteText() {
    if (isComplete()) {
      return 'Completed';
    }
    return 'Not Completed';
  }

  Future onClickItem(BuildContext context, String shipmentNo) async {
    String path = '''${Routers.check_out_inventory}?${FragmentArg.ROUTE_SHIPMENT_NO}=$shipmentNo''';
    await Application.router.navigateTo(context, path, transition: TransitionType.inFromLeft);

    onResume();
  }

  void onResume() {
    onEvent(CheckOutEvent.InitData);
  }

  Future onClickRight(BuildContext context) async {
    if (isPass()) {
      await CheckOutModel().updateShipmentHeader();
      uploadData(context);
    } else {
      CustomerDialog.show(context, msg: 'You must complete the inventory count.');
    }
  }

  bool isPass() {
    return isComplete();
  }

  void uploadData(BuildContext context) {
    SyncParameter syncParameter = new SyncParameter();
    syncParameter.putUploadUniqueIdValues([shipmentNo]).putUploadName([shipmentNo]);

    SyncManager.start(SyncType.SYNC_UPLOAD_CHECKOUT, context: context,syncParameter: syncParameter, onSuccessSync: () {
      Navigator.of(context).pop();
    }, onFailSync: (e) async {
      CustomerDialog.show(context, msg: 'upload fail', onConfirm: () {
//        Navigator.of(context).pop();
      }, onCancel: () {
//        Navigator.of(context).pop();
      });
    });
  }

  @override
  void dispose() {
    CheckOutModel().clear();
    print('*************************checkout dispose************************');
    super.dispose();
  }
}
