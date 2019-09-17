import 'package:dsd/application.dart';
import 'package:dsd/business/visit/task_visit_util.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/common/system_config.dart';
import 'package:dsd/db/manager/system_config_manager.dart';
import 'package:dsd/db/manager/truck_stock_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_item_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_delivery_item_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/model/base_product_info.dart';
import 'package:dsd/model/product_total_info.dart';
import 'package:dsd/model/task_visit_model.dart';
import 'package:dsd/model/truck_stock_product_info.dart';
import 'package:dsd/synchronization/sync/sync_dirty_status.dart';
import 'package:flustars/flustars.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/16 12:06

enum DeliveryEvent {
  InitData,
}

class DeliveryPresenter extends EventNotifier<DeliveryEvent> {
  List<BaseProductInfo> showProductList = [];
  TaskVisitItemModel visitItem;
  ProductTotalInfo productTotalInfo;
  List<TruckStockProductInfo> stockList = [];
  String deliveryNo;
  String shipmentNo;
  String accountNumber;
  String customerName;
  String productUnitValue;
  bool isHold;

  @override
  Future onEvent(DeliveryEvent event, [dynamic data]) async {
    switch (event) {
      case DeliveryEvent.InitData:
        break;
    }
    super.onEvent(event, data);
  }

  void setPageParams(Map<String, List<String>> params) {
    deliveryNo = params[FragmentArg.DELIVERY_NO].first;
    shipmentNo = params[FragmentArg.DELIVERY_SHIPMENT_NO].first;
    accountNumber = params[FragmentArg.DELIVERY_ACCOUNT_NUMBER].first;
    customerName = params[FragmentArg.TASK_CUSTOMER_NAME].first;
  }

  Future initData() async {
    visitItem = TaskVisitModel().getVisitItemByDeliveryNo(deliveryNo);
    await initConfig();
  }

  Future initConfig() async {
    String productUnit = await SystemManager.getSystemConfigValue(Delivery.CATEGORY, Delivery.PRODUCT_UNIT);
    switch (productUnit) {
      case ProductUnit.CS_EA_VALUE:
        productUnitValue = ProductUnit.CS_EA;
        break;
      case ProductUnit.CS_VALUE:
        productUnitValue = ProductUnit.CS;
        break;
      case ProductUnit.EA_VALUE:
        productUnitValue = ProductUnit.EA;
        break;
    }
    isHold = DeliveryStatus.HOLD_VALUE == visitItem.tDeliveryHeader.DeliveryStatus;
  }

  Future fillProductData() async {
    showProductList.clear();

    List<DSD_T_DeliveryItem_Entity> tList =
        await Application.database.tDeliveryItemDao.findEntityByDeliveryNo(deliveryNo);
    List<DSD_M_DeliveryItem_Entity> mList =
        await Application.database.mDeliveryItemDao.findEntityByDeliveryNo(deliveryNo);
    for (DSD_M_DeliveryItem_Entity mItem in mList) {
      BaseProductInfo info = new BaseProductInfo();
      info.code = mItem.ProductCode;
      info.name = Application.productMap[mItem.ProductCode];
      if (mItem.ProductUnit == ProductUnit.CS) {
        info.plannedCs = int.tryParse(mItem.PlanQty);
      } else {
        info.plannedEa = int.tryParse(mItem.PlanQty);
      }
      info.isInMDelivery = true;
      showProductList.add(info);
      for (DSD_T_DeliveryItem_Entity tItem in tList) {
        if (mItem.ProductCode == tItem.ProductCode) {
          if (tItem.ProductUnit == ProductUnit.CS) {
            info.actualCs = int.tryParse(tItem.ActualQty);
          } else {
            info.actualEa = int.tryParse(tItem.ActualQty);
          }
        }
      }
    }
  }

  void fillProductSummaryData() {
    productTotalInfo.clear();
    for (BaseProductInfo info in showProductList) {
      productTotalInfo.totalPlanCs += info.plannedCs;
      productTotalInfo.totalPlanEa += info.plannedEa;
      productTotalInfo.totalActualCs += info.actualCs;
      productTotalInfo.totalActualEa += info.actualEa;
    }
  }

  ///
  /// 设置初始化库存
  ///
  Future fillStockData() async {
    stockList = await TruckStockManager.getProductStock(this.shipmentNo);
    for (BaseProductInfo item in showProductList) {
      for (TruckStockProductInfo stock in stockList) {
        if (stock.productCode == item.code) {
          stock.csStockQty += item.actualCs;
          stock.eaStockQty += item.actualEa;
        }
      }
    }
  }

  void doNext() {
    cacheDeliveryHeader();
    cacheDeliveryItems();
  }

  ///
  /// 缓存DeliveryHeader数据
  ///
  void cacheDeliveryHeader() {
    bool isSameQty = true;
    for (BaseProductInfo item in showProductList) {
      if (item.plannedCs != item.actualCs || item.plannedEa != item.actualEa) {
        isSameQty = false;
      }
    }

    if (isSameQty) {
      TaskVisitUtil.cacheDeliveryHeaderStatus(visitItem, DeliveryStatus.TOTAL_DELIVERED_VALUE);
    } else {
      TaskVisitUtil.cacheDeliveryHeaderStatus(visitItem, DeliveryStatus.PARTIAL_DELIVERED_VALUE);
    }
  }

  ///
  /// 缓存DeliveryItems数据
  ///
  void cacheDeliveryItems() {
    visitItem.tDeliveryItemList.clear();

    for (BaseProductInfo item in showProductList) {
      if (productUnitValue == ProductUnit.CS_EA || productUnitValue == ProductUnit.CS) {
        if (item.plannedCs != 0 || item.actualCs != 0) {
          DSD_T_DeliveryItem_Entity add = new DSD_T_DeliveryItem_Entity.Empty();
          add.DeliveryNo = deliveryNo;
          add.ProductCode = item.code;
          add.ProductUnit = ProductUnit.CS;
          add.PlanQty = item.plannedCs.toString();
          add.ActualQty = item.actualCs.toString();
          add.DifferenceQty = (item.plannedCs - item.actualCs).toString();
          add.Reason = item.reasonValue;
          add.CreateUser = Application.user.userCode;
          add.CreateTime = DateUtil.getDateStrByDateTime(DateTime.now());
          add.dirty = SyncDirtyStatus.DEFAULT;

          visitItem.tDeliveryItemList.add(add);
        }
      }

      if (productUnitValue == ProductUnit.CS_EA || productUnitValue == ProductUnit.EA) {
        if (item.plannedCs != 0 || item.actualEa != 0) {
          DSD_T_DeliveryItem_Entity add = new DSD_T_DeliveryItem_Entity.Empty();
          add.DeliveryNo = deliveryNo;
          add.ProductCode = item.code;
          add.ProductUnit = ProductUnit.EA;
          add.PlanQty = item.plannedEa.toString();
          add.ActualQty = item.actualEa.toString();
          add.DifferenceQty = (item.plannedEa - item.actualEa).toString();
          add.Reason = item.reasonValue;
          add.CreateUser = Application.user.userCode;
          add.CreateTime = DateUtil.getDateStrByDateTime(DateTime.now());
          add.dirty = SyncDirtyStatus.DEFAULT;

          visitItem.tDeliveryItemList.add(add);
        }
      }
    }
  }
}
