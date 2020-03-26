import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/truck_stock_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_m_shipment_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/model/stock_info.dart';
import 'package:dsd/synchronization/sync/sync_dirty_status.dart';
import 'package:flustars/flustars.dart';

import '../application.dart';
import 'base_product_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/21 15:01

class DeliveryModel {
  String _deliveryNo;
  DSD_M_DeliveryHeader_Entity mDeliveryHeader;
  DSD_T_DeliveryHeader_Entity deliveryHeader;
  List<DSD_T_DeliveryItem_Entity> deliveryItemList = [];

  static DeliveryModel _instance;

  DeliveryModel._();

  static DeliveryModel _getInstance() {
    if (_instance == null) {
      _instance = new DeliveryModel._();
    }
    return _instance;
  }

  factory DeliveryModel() => _getInstance();

  Future initData(String deliveryNo) async {
    _deliveryNo = deliveryNo;
    mDeliveryHeader = await Application.database.mDeliveryHeaderDao.findEntityByDeliveryNo(deliveryNo) ??
        new DSD_M_DeliveryHeader_Entity.Empty();
    deliveryHeader = await Application.database.tDeliveryHeaderDao.findEntityByDeliveryNo(deliveryNo) ??
        new DSD_T_DeliveryHeader_Entity.Empty();
    if (deliveryHeader.DeliveryNo != null) {
      deliveryItemList = await Application.database.tDeliveryItemDao.findEntityByDeliveryNo(deliveryNo);
    }
  }

  bool isInitData() {
    return _deliveryNo != null;
  }

  void clear() {
    _deliveryNo = null;
    mDeliveryHeader = null;
    deliveryHeader = null;
    deliveryItemList.clear();
  }

  Future saveDeliveryHeader() async {
    String notTime = DateUtil.getDateStrByDateTime(new DateTime.now());
    deliveryHeader
      ..DeliveryNo = _deliveryNo
      ..OrderNo = mDeliveryHeader.OrderNo
      ..OrderDate = DateUtil.getDateStrByTimeStr(notTime, format: DateFormat.YEAR_MONTH_DAY)
      ..InvoiceNo = mDeliveryHeader.InvoiceNo
      ..PONumber = mDeliveryHeader.PONumber
      ..ActualDeliveryDate = DateUtil.getDateStrByTimeStr(notTime, format: DateFormat.YEAR_MONTH_DAY)
      ..CreateUser = Application.user.userCode
      ..CreateTime = notTime
      ..LastUpdateUser = Application.user.userCode
      ..LastUpdateTime = notTime
      ..EndTime = notTime
      ..dirty = SyncDirtyStatus.DEFAULT;

    DSD_T_DeliveryHeader_Entity entity = await Application.database.tDeliveryHeaderDao.findEntityByDeliveryNo(
        _deliveryNo);
    if (entity == null) {
      await Application.database.tDeliveryHeaderDao.insertEntity(deliveryHeader);
    } else {
      await Application.database.tDeliveryHeaderDao.updateEntity(deliveryHeader);
    }
  }

  void cacheDeliveryHeader(
      {String visitId, String shipmentNo, String accountNumber, String deliveryType, String deliveryStatus, String startTime}) {
    if (visitId != null) {
      deliveryHeader.VisitId = visitId;
    }
    if (shipmentNo != null) {
      deliveryHeader.ShipmentNo = shipmentNo;
    }
    if (accountNumber != null) {
      deliveryHeader.AccountNumber = accountNumber;
    }
    if (deliveryType != null) {
      deliveryHeader.DeliveryType = deliveryType;
    }
    if (deliveryStatus != null) {
      deliveryHeader.DeliveryStatus = deliveryStatus;
    }
    if (startTime != null) {
      deliveryHeader.StartTime = startTime;
    }
  }

  void cacheDeliveryHeaderCustomerSignature(String imgName){
    String notTime = DateUtil.getDateStrByDateTime(new DateTime.now());
    deliveryHeader
      ..CustomerSignStatus = '1'
      ..CustomerSignDate = notTime
      ..CustomerSignImg = imgName;
  }

  void cacheDeliveryHeaderDriverSignature(String imgName){
    String notTime = DateUtil.getDateStrByDateTime(new DateTime.now());
    deliveryHeader
      ..DriverSignStatus = '1'
      ..DriverSignDate = notTime
      ..DriverSignImg = imgName;
  }

  void cacheDeliveryHeaderByCustomerNot(){
    deliveryHeader.CustomerNot = '1';
  }

  void cacheDeliveryItemList(List<BaseProductInfo> productList, String productUnitValue,{List<BaseProductInfo> emptyList}) {
    deliveryItemList.clear();
    String notTime = DateUtil.getDateStrByDateTime(new DateTime.now());

    /***********************************Empty Product********************************************/
    for (BaseProductInfo info in emptyList) {
      if (info.actualCs != 0) {
        DSD_T_DeliveryItem_Entity add = new DSD_T_DeliveryItem_Entity.Empty();

        add.DeliveryNo = _deliveryNo;
        add.ProductCode = info.code;
        add.ProductUnit = ProductUnit.CS;
        add.PlanQty = info.plannedCs.toString();
        add.ActualQty = info.actualCs.toString();
        add.DifferenceQty = (info.plannedCs - info.actualCs).toString();
        add.Reason = "24";
        add.IsReturn = IsReturn.TRUE;
        add.ItemSequence = '2';
        add.CreateUser = Application.user.userCode;
        add.CreateTime = notTime;
        add.dirty = SyncDirtyStatus.DEFAULT;

        add.BasePrice = '0';
        add.NetPrice = '0';
        add.Discount = '0';
        add.Tax = '0';
        add.Deposit = '0';

        deliveryItemList.add(add);
      }
    }
    /***********************************Empty Product********************************************/

    for (BaseProductInfo info in productList) {
      if (productUnitValue == ProductUnit.CS_EA || productUnitValue == ProductUnit.CS) {
        if (info.plannedCs != 0 || info.actualCs != 0) {
          DSD_T_DeliveryItem_Entity add = new DSD_T_DeliveryItem_Entity.Empty();

          add.DeliveryNo = _deliveryNo;
          add.ProductCode = info.code;
          add.ProductUnit = ProductUnit.CS;
          add.PlanQty = info.plannedCs.toString();
          add.ActualQty = info.actualCs.toString();
          add.DifferenceQty = (info.plannedCs - info.actualCs).toString();
          add.Reason = info.reasonValue;
          add.ItemSequence = '2';
          add.CreateUser = Application.user.userCode;
          add.CreateTime = notTime;
          add.dirty = SyncDirtyStatus.DEFAULT;


          add.BasePrice = '0';
          add.NetPrice = '0';
          add.Discount = '0';
          add.Tax = '0';
          add.Deposit = '0';

          deliveryItemList.add(add);
        }
      }

      if (productUnitValue == ProductUnit.CS_EA || productUnitValue == ProductUnit.EA) {
        if (info.plannedEa != 0 || info.actualEa != 0) {
          DSD_T_DeliveryItem_Entity add = new DSD_T_DeliveryItem_Entity.Empty();

          add.DeliveryNo = _deliveryNo;
          add.ProductCode = info.code;
          add.ProductUnit = ProductUnit.EA;
          add.PlanQty = info.plannedEa.toString();
          add.ActualQty = info.actualEa.toString();
          add.DifferenceQty = (info.plannedEa - info.actualEa).toString();
          add.Reason = info.reasonValue;
          add.ItemSequence = '2';
          add.CreateUser = Application.user.userCode;
          add.CreateTime = notTime;
          add.dirty = SyncDirtyStatus.DEFAULT;

          add.BasePrice = '0';
          add.NetPrice = '0';
          add.Discount = '0';
          add.Tax = '0';
          add.Deposit = '0';

          deliveryItemList.add(add);
        }
      }
    }
  }

  ///
  /// 保存DeliveryItems数据
  ///
  Future saveDeliveryItems() async {
    //删除数据
    await saveStock(StockType.CANCEL, deliveryHeader.ShipmentNo, _deliveryNo);
    await Application.database.tDeliveryItemDao.deleteByNo(_deliveryNo);

    //增加数据
    await Application.database.tDeliveryItemDao.insertEntityList(deliveryItemList);
    await saveStock(StockType.DO, deliveryHeader.ShipmentNo, _deliveryNo);
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

      await TruckStockManager.setStock(stockType, action, truckId, shipmentNo, key, stocks[key].cs, stocks[key].ea,
          stocks[key].getCsChange(), stocks[key].getEaChange(), deliveryHeader.VisitId);
    }
  }

  bool isEmptyReturn(String productCode, List<DSD_T_DeliveryItem_Entity> tList) {
    return tList.any((entity) {
      return entity.ProductCode == productCode && entity.IsReturn == IsReturn.TRUE;
    });
  }

}
