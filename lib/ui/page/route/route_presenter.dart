import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/system_config.dart';
import 'package:dsd/db/manager/route_manager.dart';
import 'package:dsd/db/manager/shipment_manager.dart';
import 'package:dsd/db/manager/system_config_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_shipment_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_shipment_header_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/shipment_info.dart';
import 'package:dsd/res/strings.dart';
import 'package:dsd/route/routers.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/page/route/config_info.dart';
import 'package:dsd/ui/widget/search_widget.dart';
import 'package:dsd/utils/string_util.dart';
import 'package:fluintl/fluintl.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' as material;

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
  RouteConfigInfo configInfo = new RouteConfigInfo();
  RouteTitle routeTitle = new RouteTitle();

  @override
  Future onEvent(RouteEvent event, [dynamic data]) async {
    switch (event) {
      case RouteEvent.InitData:
        await initData();
        break;
      case RouteEvent.SelectShipment:
        print('*********SelectShipment');
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

  Future initData() async {
    await initConfig();

    await fillShipmentList();
    await fillCurShipment();
    await fillCustomerData();
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

    print('print shipmentList');
    shipmentList.forEach((item) {
      print(item);
    });
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

  void onClickPlan(material.BuildContext context) {
    Application.router.navigateTo(context, Routers.route_plan, transition: TransitionType.inFromLeft);
  }

  void onClickProfile(material.BuildContext context) {}

  Future onClickStartCall(material.BuildContext context, CustomerInfo info) async {
    if (await isDoCheckIn(context, currentShipment.no)) return;
    String path =
        '''${Routers.task_list}?${FragmentArg.TASK_SHIPMENT_NO}=${currentShipment.no}&${FragmentArg.TASK_ACCOUNT_NUMBER}=${info.accountNumber}&${FragmentArg.TASK_NO_SCAN_REASON}=''&${FragmentArg.TASK_SHIPMENT_TYPE}=${currentShipment.type}&${FragmentArg.TASK_CUSTOMER_NAME}=${info.name}&${FragmentArg.TASK_CUSTOMER_TYPE}=${info.customerType}&${FragmentArg.TASK_IS_BLOCK}=${info.block}
    ''';

    Application.router.navigateTo(context, path, transition: TransitionType.inFromLeft);
  }

  ///
  /// 判断当前shipmentno是否做过checkin
  /// @param shipmentNo
  /// @return
  ///
  Future<bool> isDoCheckIn(material.BuildContext context, String shipmentNo) async {
    //判断当前shipmentno是否做过checkin
    DSD_T_ShipmentHeader_Entity tShipmentHeader =
        await Application.database.tShipmentHeaderDao.findEntityByShipmentNo(shipmentNo, ActionType.CheckIn);
    if (tShipmentHeader != null) {
      CustomerDialog.show(context, msg: IntlUtil.getString(context, Ids.tasklist_verification_no_visit));
      return true;
    }
    return false;
  }
}
