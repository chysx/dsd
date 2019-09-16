
import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/common/system_config.dart';
import 'package:dsd/db/manager/system_config_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/md_dictionary_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/task_visit_model.dart';
import 'package:dsd/ui/page/route/config_info.dart';
import 'package:dsd/ui/page/task_list/config_info.dart';
import 'package:dsd/ui/page/task_list/task_list_info.dart';

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
    await loadVisitCacheData();
    await fillTaskListData();
  }

  void setPageParams(Map<String,List<String>> params) {
    shipmentNo = params[FragmentArg.TASK_SHIPMENT_NO][0];
    accountNumber = params[FragmentArg.TASK_ACCOUNT_NUMBER][0];
    noScanReason = params[FragmentArg.TASK_NO_SCAN_REASON][0];
    shipmentType = params[FragmentArg.TASK_SHIPMENT_TYPE][0];
    customerName = params[FragmentArg.TASK_CUSTOMER_NAME][0];
    customerType = params[FragmentArg.TASK_CUSTOMER_TYPE][0];
    block = params[FragmentArg.TASK_IS_BLOCK][0];
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

  ///
  /// 加载当前拜访的数据
  ///
   Future loadVisitCacheData() async {
    TaskVisitModel().clearData();
    await TaskVisitModel().fillVisitData(shipmentNo, accountNumber);
    TaskVisitModel().setNoScanReason(noScanReason);
  }

  ///
  /// 获取TaskList列表
  ///
   Future fillTaskListData() async {
    taskList.clear();
    List<DSD_M_DeliveryHeader_Entity> mList = await Application.database.mDeliveryHeaderDao.findEntityByCon(shipmentNo, accountNumber);
    List<DSD_T_DeliveryHeader_Entity> tList = await Application.database.tDeliveryHeaderDao.findEntityByCon(shipmentNo, accountNumber);

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
          MD_Dictionary_Entity entity =  await Application.database.dictionaryDao.findEntityByCon(DeliveryStatus.CATEGORY,hasTDelivery.DeliveryStatus,Valid.EXIST);
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
          MD_Dictionary_Entity entity =  await Application.database.dictionaryDao.findEntityByCon(DeliveryStatus.CATEGORY,hasTDelivery.DeliveryStatus,Valid.EXIST);
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
    return list.firstWhere((item){
      return item.DeliveryNo == deliveryNo;
    },orElse: () => null);
  }

}
