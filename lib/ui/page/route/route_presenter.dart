import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/common/system_config.dart';
import 'package:dsd/db/manager/reason_manager.dart';
import 'package:dsd/db/manager/route_manager.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/db/manager/system_config_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_shipment_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_header_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/shipment_info.dart';
import 'package:dsd/res/strings.dart';
import 'package:dsd/route/page_builder.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:dsd/synchronization/sync_manager.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/dialog/list_dialog.dart';
import 'package:dsd/ui/dialog/model/key_value_info.dart';
import 'package:dsd/ui/dialog/signature_dialog.dart';
import 'package:dsd/ui/page/route/config_info.dart';
import 'package:dsd/ui/widget/search_widget.dart';
import 'package:dsd/utils/map_launch_util.dart';
import 'package:dsd/utils/string_util.dart';
import 'package:fluintl/fluintl.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart' as material;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:android_intent/android_intent.dart';

import 'customer_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/3 15:48

enum RouteEvent {
  InitData,
  SelectShipment,
  Search,
}

class RouteTitle extends EventNotifier {
  int completeCount = 0;
  int totalCount = 0;

  RouteTitle([this.completeCount, this.totalCount]);

  void reset() {
    completeCount = 0;
    totalCount = 0;
  }

  void makeRouteTitle(List<CustomerInfo> customerList) {
    reset();
    totalCount = customerList.length;
    for (CustomerInfo info in customerList) {
      if (info.isVisitComplete) completeCount++;
    }
    notifyListeners();
  }
}

class RoutePresenter extends EventNotifier<RouteEvent> {
  List<CustomerInfo> customerList = [];
  List<ShipmentInfo> shipmentList = [];
  ShipmentInfo currentShipment;
  String shipmentNoByCheckoutPage;
  RouteConfigInfo configInfo = new RouteConfigInfo();
  RouteTitle routeTitle = new RouteTitle();

  @override
  Future onEvent(RouteEvent event, [dynamic data]) async {
    switch (event) {
      case RouteEvent.InitData:
        await initData();
        break;
      case RouteEvent.SelectShipment:
        eventBus.fire(new SearchEvent());
        await setCurShipment(data);
        await fillCustomerData();
        routeTitle.makeRouteTitle(customerList);
        break;
      case RouteEvent.Search:
        await search(data);
        return;
    }
    super.onEvent(event, data);
  }

  void setBundle(Map<String,dynamic> bundle){
    try {
      shipmentNoByCheckoutPage = bundle[FragmentArg.ROUTE_SHIPMENT_NO];
    }catch (e) {}
  }

  Future initData() async {
    await initConfig();

    await fillShipmentList();
    await fillCurShipment();
    await setCurShipmentByCheckoutPage();
    await fillCustomerData();
    routeTitle.makeRouteTitle(customerList);
  }

  Future initConfig() async {
    configInfo.isEnableMap = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_MAP);
    configInfo.isEnableBarcode = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_BARCODE);
    configInfo.isEnableGeo = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_GEO);
    configInfo.isEnableHisOrder = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_HIS_ORDER);
    configInfo.isEnableNewCustomer = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_NEW_CUSTOMER);
    configInfo.isVanNewCustomer = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.VANS_NEW_CUSTOMER);
    configInfo.isDelNewCustomer = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.DEL_NEW_CUSTOMER);
    configInfo.isEnableNewShipment = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_NEW_SHIPMENT1);
    configInfo.isEnableOpenAR = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_OPEN_AR);
    configInfo.isMustComplete = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.MUST_COMPLETE);
    configInfo.isPrintPickSlip = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.PRINT_PICK_SLIP);
    configInfo.isVisitBySeq = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.VISIT_BY_SEQ);
  }

  Future fillShipmentList() async {
    shipmentList = await ShipmentManager.getShipmentNoListByCheckOut();

    List<ShipmentInfo> checkInByTodayList = await ShipmentManager.getShipmentHeaderByCheckInByToday();
    shipmentList.removeWhere((item) {
      for (ShipmentInfo info in checkInByTodayList) {
        if (item.no == info.no) {
          return true;
        }
      }
      return false;
    });

    sortShipmentList();
  }

  void sortShipmentList() {
    shipmentList.sort((ShipmentInfo info1, ShipmentInfo info2) {
      int result = info2.shipmentDate.compareTo(info1.shipmentDate);
      return result == 0 ? info1.sequence.compareTo(info2.sequence) : result;
    });
  }

  Future fillCurShipment() async {
    if (currentShipment == null) {
      if (shipmentList.length > 0) {
        currentShipment = shipmentList[0];
      }
    } else {
      List<ShipmentInfo> list = await ShipmentManager.getShipmentNoListByCheckOut();
      if (list.length == 0) {
        //该处可能出现的场景有：在同步界面初始化成功后，此时后台恰好把相关数据都删了，这时候回到route界面会任然会
        //显示数据，原因就是内存没有清楚掉
        currentShipment = null;
      }

      //如果当前展示的Shipment是刚刚已经CheckIn后返回该界面时的情况，则要删除该shipment
      if (shipmentList.length > 0) {
        List<ShipmentInfo> checkInByTodayList = await ShipmentManager.getShipmentHeaderByCheckInByToday();
        for (ShipmentInfo info in checkInByTodayList) {
          if (currentShipment.no == info.no) {
            currentShipment = shipmentList[0];
          }
        }
      } else {
        currentShipment = null;
      }
    }
  }

  Future setCurShipmentByCheckoutPage() async {
    //传过来的shipmentNo可能不在列表中
    bool isInShipmentList = shipmentList.any((item) {
      return item.no == shipmentNoByCheckoutPage;
    });
    if (shipmentNoByCheckoutPage != null && shipmentNoByCheckoutPage.isNotEmpty && isInShipmentList)
      await setCurShipment(shipmentNoByCheckoutPage);
  }

  Future fillCustomerData() async {
    customerList.clear();
    if (currentShipment != null) {
      List<CustomerInfo> resultList = await RouteManager.getCustomerInfoList(currentShipment.no, currentShipment.type);
      customerList.addAll(resultList);
    }
  }

  static void makeIndex(List<CustomerInfo> list) {
    int index = 0;
    for (CustomerInfo info in list) {
      String index1 = realMakeIndex(++index);
      info.index = index1;
    }
  }

  static String realMakeIndex(int position) {
    if (position < 10) {
      return "0" + position.toString();
    } else {
      return position.toString();
    }
  }

  Future search(String nameOrCode) async {
    await fillCustomerData();
    if (StringUtil.isEmpty(nameOrCode)) {
      notifyListeners();
    } else {
      List<CustomerInfo> searchList = [];
      for (CustomerInfo info in customerList) {
        if (info.name.toUpperCase().contains(nameOrCode.toUpperCase()) ||
            info.accountNumber.toUpperCase().contains(nameOrCode.toUpperCase())) {
          searchList.add(info);
        }
      }
      customerList.clear();
      customerList.addAll(searchList);
      notifyListeners();
    }
  }

  List<String> getShipmentNoList() => shipmentList.map((item) => item.no);

  int getPosition(String accountNumber) {
    return customerList.indexWhere((item) => accountNumber == item.accountNumber);
  }

  Future setCurShipment(String shipmentNo) async {
    DSD_M_ShipmentHeader_Entity entity =
        await Application.database.mShipmentHeaderDao.findEntityByShipmentNo(shipmentNo, Valid.EXIST);
    if (entity != null) {
      currentShipment = new ShipmentInfo()
        ..no = entity.ShipmentNo
        ..type = entity.ShipmentType
        ..description = entity.Description
        ..shipmentDate = entity.ShipmentDate
        ..sequence = entity.LoadingSequence;
    }
  }

  void onClickPlan(material.BuildContext context, CustomerInfo info) {
    Map<String,dynamic> bundle = {
      FragmentArg.ROUTE_SHIPMENT_NO: currentShipment.no,
      FragmentArg.ROUTE_ACCOUNT_NUMBER: info.accountNumber,
    };
    material.Navigator.pushNamed(context, PageName.route_plan.toString(),arguments: bundle);

  }

  void onClickProfile(material.BuildContext context, CustomerInfo info) {
    Map<String,dynamic> bundle = {
      FragmentArg.ROUTE_SHIPMENT_NO: currentShipment.no,
      FragmentArg.ROUTE_ACCOUNT_NUMBER: info.accountNumber,
    };
    material.Navigator.pushNamed(context, PageName.profile.toString(),arguments: bundle);

  }

  Future onClickStartCall(material.BuildContext context, CustomerInfo info) async {
    if (await isDoCheckIn(context, currentShipment.no)) return;
    Map<String,dynamic> bundle = {
      FragmentArg.TASK_SHIPMENT_NO: currentShipment.no,
      FragmentArg.TASK_ACCOUNT_NUMBER: info.accountNumber,
      FragmentArg.TASK_NO_SCAN_REASON: '',
      FragmentArg.TASK_SHIPMENT_TYPE: currentShipment.type,
      FragmentArg.TASK_CUSTOMER_NAME: info.name,
      FragmentArg.TASK_CUSTOMER_TYPE: info.customerType,
      FragmentArg.TASK_IS_BLOCK: info.block,
    };
    material.Navigator.pushNamed(context, PageName.task_list.toString(),arguments: bundle);

  }

  void onClickNavigation(material.BuildContext context, CustomerInfo info) {
    MapLaunchUtil.launchQuery('1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA');

  }

  ///
  /// 判断当前shipmentno是否做过checkin
  /// @param shipmentNo
  /// @return
  ///
  Future<bool> isDoCheckIn(material.BuildContext context, String shipmentNo) async {
    //判断当前shipmentno是否做过checkin
    DSD_T_ShipmentHeader_Entity tShipmentHeader =
        await Application.database.tShipmentHeaderDao.findEntityByShipmentNo(shipmentNo,);
    if (tShipmentHeader != null && tShipmentHeader.ActionType == ActionType.CheckIn) {
      CustomerDialog.show(context, msg: IntlUtil.getString(context, Ids.tasklist_verification_no_visit));
      return true;
    }
    return false;
  }

  doClickCancel(material.BuildContext context, CustomerInfo info) async {
//    if(await isDoCheckIn(context,currentShipment.no)) return;
//    if(info.status != DeliveryStatus.DEFALUT_DELIVERY && info.status != DeliveryStatus.CANCEL){
//      Fluttertoast.showToast(msg: 'The customer had been visited which can’t cancel again.');
//      return;
//    }
    if(info.status == DeliveryStatus.CANCEL){
      Fluttertoast.showToast(msg: 'The customer had been cancelled.');
      return;
    }
    if(info.isVisitComplete) {
      Fluttertoast.showToast(msg: 'The customer had been visited which can’t cancel again.');
      return;
    }
    showReasonDialog(context,info);
  }

  Future showReasonDialog(material.BuildContext context,CustomerInfo info) async {
    List<KeyValueInfo> reasonList = await ReasonManager.getReasonData(CancelDelReasonExZF61.CATEGORY);
    ListDialog.show(context,title: IntlUtil.getString(context, Ids.checkoutInventory_title_reason),data: reasonList,onSelect: (reason) async {
      info.cancelReason = reason.value;
      String visitId = await RouteManager.updateDeliveryStatusCancel(currentShipment.no, info.accountNumber, info.cancelReason);
      uploadData(context, visitId, info.accountNumber);
    });
  }

  void uploadData(material.BuildContext context, String visitId, String accountNumber) {
    SyncParameter syncParameter = new SyncParameter();
    syncParameter.putUploadUniqueIdValues([visitId]).putUploadName([accountNumber]);

    SyncManager.start(SyncType.SYNC_UPLOAD_VISIT, context: context, syncParameter: syncParameter, onSuccessSync: () {
      Fluttertoast.showToast(msg: 'upload success');
      onEvent(RouteEvent.InitData);
    }, onFailSync: (e) async {
      Fluttertoast.showToast(msg: 'upload fail');
      onEvent(RouteEvent.InitData);
    });
  }
}
