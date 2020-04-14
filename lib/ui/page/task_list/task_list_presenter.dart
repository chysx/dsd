import 'package:dsd/application.dart';
import 'package:dsd/business/signature/delivery_signature.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/common/system_config.dart';
import 'package:dsd/db/manager/system_config_manager.dart';
import 'package:dsd/db/manager/visit_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/md_dictionary_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/visit_model.dart';
import 'package:dsd/route/page_builder.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/page/route/config_info.dart';
import 'package:dsd/ui/page/task_list/config_info.dart';
import 'package:dsd/ui/page/task_list/task_list_info.dart';
import 'package:flutter/material.dart' as material;

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
  List<TaskInfo> taskList = [];
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
    await VisitModel().initData(shipmentNo, accountNumber);
    await fillTaskListData();
  }


  void setBundle(Map<String,dynamic> bundle){
    shipmentNo = bundle[FragmentArg.TASK_SHIPMENT_NO];
    accountNumber = bundle[FragmentArg.TASK_ACCOUNT_NUMBER];
    noScanReason = bundle[FragmentArg.TASK_NO_SCAN_REASON];
    shipmentType = bundle[FragmentArg.TASK_SHIPMENT_TYPE];
    customerName = bundle[FragmentArg.TASK_CUSTOMER_NAME];
    customerType = bundle[FragmentArg.TASK_CUSTOMER_TYPE];
    block = bundle[FragmentArg.TASK_IS_BLOCK];
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
    routeConfigInfo.isEnableNewCustomer =
        await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_NEW_CUSTOMER);
    routeConfigInfo.isVanNewCustomer = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.VANS_NEW_CUSTOMER);
    routeConfigInfo.isDelNewCustomer = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.DEL_NEW_CUSTOMER);
    routeConfigInfo.isEnableNewShipment =
        await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_NEW_SHIPMENT1);
    routeConfigInfo.isEnableOpenAR = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.ENABLE_OPEN_AR);
    routeConfigInfo.isMustComplete = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.MUST_COMPLETE);
    routeConfigInfo.isPrintPickSlip = await SystemManager.getValueByBoolean(Route.CATEGORY, Route.PRINT_PICK_SLIP);
  }

  ///
  /// 获取TaskList列表
  ///
  Future fillTaskListData() async {
    taskList.clear();
    List<DSD_M_DeliveryHeader_Entity> mList =
        await Application.database.mDeliveryHeaderDao.findEntityByCon(shipmentNo, accountNumber);
    List<DSD_T_DeliveryHeader_Entity> tList =
        await Application.database.tDeliveryHeaderDao.findEntityByCon(shipmentNo, accountNumber);

    await fillDeliveryData(mList, tList);
    await fillEmptyReturnData(mList, tList);
    fillDocumentData();
    fillProfileData();
  }

  Future fillDeliveryData(List<DSD_M_DeliveryHeader_Entity> mList, List<DSD_T_DeliveryHeader_Entity> tList) async {
    bool hasDelivery = false;
    for (DSD_M_DeliveryHeader_Entity item in mList) {
      if (TaskType.Delivery == item.DeliveryType) {
        TaskInfo delivery = new TaskInfo();
        delivery.no = item.DeliveryNo;
        delivery.orderNo = item.OrderNo;
        delivery.imgPath = 'assets/imgs/task_delivery.png';
        delivery.name = 'Delivery';
        delivery.description = 'No.' + item.DeliveryNo;
        delivery.type = TaskType.Delivery;
        delivery.status = TaskDeliveryStatus.NotComplete;
        delivery.isMust = true;
        delivery.isScroll = true;
        delivery.isRebook = configInfo.isEnableRebook;
        delivery.weight = Weight.DeliveryX;
        taskList.add(delivery);

        hasDelivery = true;

        //获取已做数据的状态
        DSD_T_DeliveryHeader_Entity hasTDelivery = getDeliveryHeaderByNo(tList, item.DeliveryNo);
        if (hasTDelivery != null) {
          MD_Dictionary_Entity entity = await Application.database.dictionaryDao
              .findEntityByCon(DeliveryStatus.CATEGORY, hasTDelivery.DeliveryStatus, Valid.EXIST);
          delivery.status = entity?.Description;

          switch (delivery.status) {
            case TaskDeliveryStatus.TotalDelivered:
            case TaskDeliveryStatus.PartialDelivered:
            case TaskDeliveryStatus.Hold:
              delivery.isScroll = false;
              break;
            default:
              delivery.isScroll = true;
              break;
          }
        }
      }
    }
  }

  Future fillEmptyReturnData(List<DSD_M_DeliveryHeader_Entity> mList, List<DSD_T_DeliveryHeader_Entity> tList) async {
    bool hasEmptyReturn = false;
    for (DSD_M_DeliveryHeader_Entity item in mList) {
      if (TaskType.EmptyReturn == item.DeliveryType) {
        TaskInfo emptyreturn = new TaskInfo();
        emptyreturn.no = item.DeliveryNo;
        emptyreturn.imgPath = 'assets/imgs/task_empty_return.png';
        emptyreturn.name = 'Empty Return';
        emptyreturn.description = 'No.' + item.DeliveryNo;
        emptyreturn.type = TaskType.EmptyReturn;
        emptyreturn.status = TaskDeliveryStatus.NotComplete;
        emptyreturn.isMust = true;
        emptyreturn.isScroll = true;
        emptyreturn.isRebook = configInfo.isEnableRebook;
        emptyreturn.weight = Weight.EmptyReturnX;
        taskList.add(emptyreturn);

        hasEmptyReturn = true;

        //获取已做数据的状态
        DSD_T_DeliveryHeader_Entity hasTDelivery = getDeliveryHeaderByNo(tList, item.DeliveryNo);
        if (hasTDelivery != null) {
          MD_Dictionary_Entity entity = await Application.database.dictionaryDao
              .findEntityByCon(DeliveryStatus.CATEGORY, hasTDelivery.DeliveryStatus, Valid.EXIST);
          emptyreturn.status = entity?.Description;

          switch (emptyreturn.status) {
            case TaskDeliveryStatus.TotalDelivered:
            case TaskDeliveryStatus.PartialDelivered:
            case TaskDeliveryStatus.Hold:
              emptyreturn.isScroll = false;
              break;
            default:
              emptyreturn.isScroll = true;
              break;
          }
        }
      }
    }
  }

  void fillDocumentData() {
    TaskInfo document = new TaskInfo();
    document.imgPath = 'assets/imgs/task_documents.png';
    document.name = 'Documents';
    document.type = TaskType.Document;
    document.status = TaskDeliveryStatus.Default;
    document.isMust = false;
    document.isScroll = false;
    document.isRebook = false;
    document.weight = Weight.Document;
    taskList.add(document);
  }

  void fillProfileData() {
    TaskInfo document = new TaskInfo();
    document.imgPath = 'assets/imgs/task_documents.png';
    document.name = 'Customer Profile';
    document.type = TaskType.Profile;
    document.status = TaskDeliveryStatus.Default;
    document.isMust = false;
    document.isScroll = false;
    document.isRebook = false;
    document.weight = Weight.Document;
    taskList.add(document);
  }

  ///
  /// 根据DeliveryNo查找集合中的DeliveryHeader
  ///
  DSD_T_DeliveryHeader_Entity getDeliveryHeaderByNo(List<DSD_T_DeliveryHeader_Entity> list, String deliveryNo) {
    return list.firstWhere((item) {
      return item.DeliveryNo == deliveryNo;
    }, orElse: () => null);
  }

  void onItemClick(material.BuildContext context, TaskInfo info) {
    switch (info.type) {
      case TaskType.Delivery:
        doDelivery(context, info);
        break;
      case TaskType.Profile:
        doProfile(context);
        break;
      case TaskType.Document:
        doDocument(context, info);
        break;
    }
  }

  Future doDelivery(material.BuildContext context, TaskInfo info) async {
    if (!info.isMust) return;
    String readOnly;
    switch (info.status) {
      case TaskDeliveryStatus.TotalDelivered:
      case TaskDeliveryStatus.PartialDelivered:
      case TaskDeliveryStatus.Pending_ER:
      case TaskDeliveryStatus.Rebook:
      case TaskDeliveryStatus.Cancel:
        readOnly = ReadyOnly.TRUE;
        break;
      default:
        readOnly = ReadyOnly.FALSE;
        break;
    }

    var page = (readOnly == ReadyOnly.TRUE ? PageName.delivery_summary : PageName.delivery);

    Map<String,dynamic> bundle = {
      FragmentArg.DELIVERY_NO: info.no,
      FragmentArg.DELIVERY_SHIPMENT_NO: shipmentNo,
      FragmentArg.DELIVERY_ACCOUNT_NUMBER: accountNumber,
      FragmentArg.TASK_CUSTOMER_NAME: customerName,
      FragmentArg.DELIVERY_TYPE: info.type,
      FragmentArg.DELIVERY_SUMMARY_READONLY: readOnly,
    };
    await material.Navigator.pushNamed(context, page.toString(),arguments: bundle);

    onResume();

  }

  doDocument(material.BuildContext context, TaskInfo info) {
    Map<String,dynamic> bundle = {
      FragmentArg.DELIVERY_SHIPMENT_NO: shipmentNo,
      FragmentArg.DELIVERY_ACCOUNT_NUMBER: accountNumber,
      FragmentArg.TASK_CUSTOMER_NAME: customerName,
    };
    material.Navigator.pushNamed(context, PageName.document.toString(),arguments: bundle);

  }

  void onResume() {
    onEvent(TaskListEvent.InitData);
  }

  void doProfile(material.BuildContext context) {
    Map<String,dynamic> bundle = {
      FragmentArg.ROUTE_SHIPMENT_NO: shipmentNo,
      FragmentArg.ROUTE_ACCOUNT_NUMBER: accountNumber,
      FragmentArg.TASK_CUSTOMER_NAME: customerName,
      FragmentArg.IS_FROM_VISIT: true,
    };
    material.Navigator.pushNamed(context, PageName.profile.toString(),arguments: bundle);

  }

  void onClickRight(material.BuildContext context) {
    if (!isPass(context)) return;
    Map<String,dynamic> bundle = {
      FragmentArg.DELIVERY_SHIPMENT_NO: shipmentNo,
      FragmentArg.DELIVERY_ACCOUNT_NUMBER: accountNumber,
      FragmentArg.TASK_CUSTOMER_NAME: customerName,
    };
    material.Navigator.pushNamed(context, PageName.visit_summary.toString(),arguments: bundle);

  }

  bool isPass(material.BuildContext context) {
    if (isNeedDoMustItem()) {
      CustomerDialog.show(context, msg: 'Please finish the mandatory tasks before finishing visit.');
      return false;
    }
    if (VisitManager.isVisitCompleteByVisit(VisitModel().visit)) {
      material.Navigator.of(context).pop();
      return false;
    }
    return true;
  }

  ///是否需要做必填项
  bool isNeedDoMustItem() {
    return taskList.any((item) {
      return item.isMust && item.status == TaskDeliveryStatus.NotComplete;
    });
  }

  @override
  void dispose() {

    VisitModel().clear();

    super.dispose();
  }

}
