import 'package:dsd/common/system_config.dart';
import 'package:dsd/db/manager/system_config_manager.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/ui/page/route/config_info.dart';
import 'package:dsd/ui/page/task_list/config_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/11 10:33

enum TaskListEvent {
  InitData,
}

class TaskListPresenter extends EventNotifier<TaskListEvent> {
  TaskConfigInfo configInfo = new TaskConfigInfo();
  RouteConfigInfo routeConfigInfo = new RouteConfigInfo();
  String accountNumber;
  String noScanReason;
  String shipmentType;
  String customerType;
  String customerName;
  String shipmentNo;
  String block;

  @override
  Future onEvent(TaskListEvent event, [dynamic data]) async {
    switch (event) {
      case TaskListEvent.InitData:
        await initData();
        break;
    }
    super.onEvent(event, data);
  }

  Future initData() async {
    await initConfig();
    await configInfoRoute();
  }

  Future initConfig() async {
    configInfo.isEnableARCollection =
        await SystemManager.getValueByBoolean(CommonFunction.CATEGORY, CommonFunction.ENABLE_ARCOLLECTION);

    configInfo.isEnableSurvey =
        await SystemManager.getValueByBoolean(CommonFunction.CATEGORY, CommonFunction.ENABLE_SURVEY);

    configInfo.isEnableNote =
        await SystemManager.getValueByBoolean(CommonFunction.CATEGORY, CommonFunction.ENABLE_NOTE);

    configInfo.isEnableRebook =
        await SystemManager.getValueByBoolean(CommonFunction.CATEGORY, CommonFunction.ENABLE_REBOOK);

    configInfo.isEnableVansales =
        await SystemManager.getValueByBoolean(CommonFunction.CATEGORY, CommonFunction.ENABLE_VANSALES);

    configInfo.isEnablePreSell =
        await SystemManager.getValueByBoolean(CommonFunction.CATEGORY, CommonFunction.ENABLE_PRE_SELL);

    configInfo.isDispayWithoutPlanByTradeReturn =
        await SystemManager.getValueByBoolean(TradeReturn.CATEGORY, TradeReturn.DISPAY_WITHOUT_PLAN);

    configInfo.isDispayWithoutPlanByEmptyReturn =
        await SystemManager.getValueByBoolean(EmptyReturn.CATEGORY, EmptyReturn.DISPAY_WITHOUT_PLAN);

    configInfo.isEnableGeo = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_GEO);
  }

  Future configInfoRoute() async {
    routeConfigInfo.isEnableMap = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_MAP);
    routeConfigInfo.isEnableBarcode = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_BARCODE);
    routeConfigInfo.isEnableGeo = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_GEO);
    routeConfigInfo.isEnableHisOrder = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_HIS_ORDER);
    routeConfigInfo.isEnableNewCustomer = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_NEW_CUSTOMER);
    routeConfigInfo.isVanNewCustomer = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.VANS_NEW_CUSTOMER);
    routeConfigInfo.isDelNewCustomer = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.DEL_NEW_CUSTOMER);
    routeConfigInfo.isEnableNewShipment = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_NEW_SHIPMENT1);
    routeConfigInfo.isEnableOpenAR = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_OPEN_AR);
    routeConfigInfo.isMustComplete = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.MUST_COMPLETE);
    routeConfigInfo.isPrintPickSlip = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.PRINT_PICK_SLIP);
  }
}
