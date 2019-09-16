import 'package:dsd/application.dart';
import 'package:dsd/business/visit/task_visit_util.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/delivery_manager.dart';
import 'package:dsd/db/manager/truck_stock_manager.dart';
import 'package:dsd/db/manager/visit_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_shipment_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_visit_entity.dart';
import 'package:dsd/model/stock_info.dart';
import 'package:dsd/synchronization/sync/sync_dirty_status.dart';
import 'package:dsd/utils/string_util.dart';
import 'package:flustars/flustars.dart';
import 'package:uuid/uuid.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/11 11:56

class TaskVisitModel {
  DSD_T_Visit_Entity tVisit = new DSD_T_Visit_Entity.Empty();
  List<TaskVisitItemModel> visitItemModelList = [];

  static TaskVisitModel _instance;
  TaskVisitModel._();
  static TaskVisitModel _getInstance(){
    if(_instance == null){
      _instance = new TaskVisitModel._();
    }
    return _instance;
  }

  factory TaskVisitModel() => _getInstance();

  Future fillVisitData(String shipmentNo, String accountNumber) async {
    if (await TaskVisitUtil.isNeedCreateVisit(shipmentNo, accountNumber)) {
      createVisit(shipmentNo, accountNumber);
    } else {
      loadVisitAndTaskItemByDb(shipmentNo, accountNumber);
    }
  }

  void createVisit(String shipmentNo, String accountNumber) {
    if (StringUtil.isEmpty(tVisit.VisitId)) tVisit.VisitId = new Uuid().v1();
    if (StringUtil.isEmpty(tVisit.StartTime)) tVisit.StartTime = DateUtil.getDateStrByDateTime(DateTime.now());

    tVisit
      ..ShipmentNo = shipmentNo
      ..EndTime = DateUtil.getDateStrByDateTime(DateTime.now())
      ..UserCode = Application.user.userCode
      ..AccountNumber = accountNumber
      ..dirty = SyncDirtyStatus.DEFAULT;
  }

  Future loadVisitAndTaskItemByDb(String shipmentNo, String accountNumber) async {
    tVisit = await VisitManager.getVisitLastly(shipmentNo, accountNumber);

    List<DSD_T_DeliveryHeader_Entity> tDeliveryHeaderList =
        await Application.database.tDeliveryHeaderDao.findEntityByCon(shipmentNo, accountNumber);
    for (DSD_T_DeliveryHeader_Entity tDeliveryHeader in tDeliveryHeaderList) {
      TaskVisitItemModel visitItem = getVisitItemByDeliveryNo(tDeliveryHeader.DeliveryNo);
      visitItem.tDeliveryHeader = tDeliveryHeader;
      visitItem.tDeliveryItemList =
          await Application.database.tDeliveryItemDao.findEntityByDeliveryNo(tDeliveryHeader.DeliveryNo);
    }
  }

  ///
  /// 根据DeliveryNo查找VisitItemInfo对象，如果没有找到则创建一个新的VisitItemInfo对象，
  /// 并添加到集合，然后返回
  ///
  /// @param deliveryNo
  /// @return
  ///
  TaskVisitItemModel getVisitItemByDeliveryNo(String deliveryNo) {
    if (StringUtil.isEmpty(deliveryNo)) return null;

    for (TaskVisitItemModel item in visitItemModelList) {
      if (item?.deliveryNo == deliveryNo) {
        return item;
      }
    }

    return createVisitItemByDeliveryNo(deliveryNo);
  }

  ///
  /// 根据DeliveryNo创建VisitItemInfo对象，并添加到集合
  ///
  /// @param deliveryNo
  /// @return
  ///
  TaskVisitItemModel createVisitItemByDeliveryNo(String deliveryNo) {
    TaskVisitItemModel result = new TaskVisitItemModel();
    result.deliveryNo = deliveryNo;
    visitItemModelList.add(result);
    return result;
  }

  void setNoScanReason(String noScanReason) {
    tVisit.NoScanReason = noScanReason;
  }

  ///
  /// 保存当个拜访项数据
  ///
  void saveItem(TaskVisitItemModel item) {
    saveVisit();
    saveDeliveryHeader(item);
    saveDeliveryItems(item);
  }

  ///
  /// 保存Visit数据
  ///
  Future saveVisit() async {
    VisitManager.insertOrUpdateVisit(tVisit);
  }

  ///
  /// 保存DeliveryHeader数据
  ///
  void saveDeliveryHeader(TaskVisitItemModel save) {
    if (save == null) return;
    for (TaskVisitItemModel item in visitItemModelList) {
      if (save.deliveryNo == item.deliveryNo) DeliveryManager.insertOrUpdateDeliveryHeader(item.tDeliveryHeader);
    }
  }

  ///
  /// 保存DeliveryItems数据
  ///
  Future saveDeliveryItems(TaskVisitItemModel save) async {
    if (save == null) return;
    for (TaskVisitItemModel item in visitItemModelList) {
      if (save.deliveryNo == item.deliveryNo) {
        //删除数据
        saveStock(StockType.CANCEL, tVisit.ShipmentNo, item.deliveryNo);
        await Application.database.tDeliveryItemDao.deleteByNo(item.deliveryNo);

        //增加数据
        await Application.database.tDeliveryItemDao.insertEntityList(item.tDeliveryItemList);
        saveStock(StockType.DO, tVisit.ShipmentNo, item.deliveryNo);
      }
    }
  }

  ///
  /// 保存库存
  ///
  Future saveStock(StockType stockType, String shipmentNo, String deliveryNo) async {
    DSD_M_ShipmentHeader_Entity shipmentHeader =
        await Application.database.mShipmentHeaderDao.findEntityByShipmentNo(shipmentNo, Valid.EXIST);

    DSD_T_DeliveryHeader_Entity tDeliveryHeader =
        await Application.database.tDeliveryHeaderDao.findEntityByDeliveryNo(deliveryNo);
    List<DSD_T_DeliveryItem_Entity> tDeliveryItems =
        await Application.database.tDeliveryItemDao.findEntityByDeliveryNo(deliveryNo);

    int truckId = shipmentHeader?.TruckId ?? 0;
    Map<String, StockInfo> stocks = {};
    for (DSD_T_DeliveryItem_Entity deliveryItem in tDeliveryItems) {
      String code = deliveryItem.ProductCode;
      if (!stocks.containsKey(code)) {
        StockInfo add = new StockInfo();
        add.productCode = code;
        stocks[add.productCode] = add;
      }

      switch (deliveryItem.ProductUnit) {
        case ProductUnit.CS:
          stocks[code].cs += int.tryParse(deliveryItem.ActualQty);
          stocks[code].planCs += int.tryParse(deliveryItem.PlanQty);
          break;
        case ProductUnit.EA:
          stocks[code].ea += int.tryParse(deliveryItem.ActualQty);
          stocks[code].planEa += int.tryParse(deliveryItem.PlanQty);
          break;
      }
    }

    for (String key in stocks.keys) {
      String action = "";

      switch (tDeliveryHeader.DeliveryType) {
        case TaskType.Delivery:
          if (isEmptyReturn(key, tDeliveryItems)) {
            action = StockTracking.ERET;
          } else {
            action = StockTracking.DELE;
          }
          break;
        case TaskType.TradeReturn:
          action = StockTracking.TRET;
          break;
        case TaskType.EmptyReturn:
          action = StockTracking.ERET;
          break;
        case TaskType.VanSales:
          if (isEmptyReturn(key, tDeliveryItems)) {
            action = StockTracking.ERET;
          } else {
            action = StockTracking.VASL;
          }
          break;
      }

      TruckStockManager.setStock(stockType, action, truckId, shipmentNo, key, stocks[key].cs, stocks[key].ea,
          stocks[key].getCsChange(), stocks[key].getEaChange(), tVisit.VisitId);
    }
  }

  bool isEmptyReturn(String productCode, List<DSD_T_DeliveryItem_Entity> tList) {
    return tList.any((entity) {
      return entity.ProductCode == productCode && entity.IsReturn == IsReturn.TRUE;
    });
  }

  ///
  /// 清空数据
  ///
   void clearData() {
    tVisit = new DSD_T_Visit_Entity.Empty();
    visitItemModelList.clear();
  }

}

class TaskVisitItemModel {
  String deliveryNo;

  DSD_T_DeliveryHeader_Entity tDeliveryHeader = new DSD_T_DeliveryHeader_Entity.Empty();
  List<DSD_T_DeliveryItem_Entity> tDeliveryItemList = [];
}
