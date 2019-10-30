import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/db/table/entity/dsd_t_truck_stock_entity.dart';
import 'package:dsd/db/table/entity/dsd_t_truck_stock_tracking_entity.dart';
import 'package:dsd/model/truck_stock_product_info.dart';
import 'package:dsd/synchronization/sync/sync_dirty_status.dart';
import 'package:flustars/flustars.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/11 15:51

///
/// 操作类型
///
enum StockType {
  DO, //正向操作（增加库存数据）
  CANCEL //逆向操作(删除库存数据)
}

class TruckStockManager {

  static Future setStock(StockType stockType, String action, int truckId, String shipmentNo, String productCode,
      int csChange, int eaChange, [int csSaleableChange, int eaSaleableChange, String visitId]) async {
    DSD_T_TruckStock_Entity csTruckStock =
        await Application.database.tTruckStockDao.findEntityByCon(truckId, shipmentNo, productCode, ProductUnit.CS);

    DSD_T_TruckStock_Entity eaTruckStock =
        await Application.database.tTruckStockDao.findEntityByCon(truckId, shipmentNo, productCode, ProductUnit.EA);

    int csStockQtyFrom = csTruckStock?.StockQty ?? 0;
    int eaStockQtyFrom = eaTruckStock?.StockQty ?? 0;
    int csStockQtyTo = csStockQtyFrom;
    int eaStockQtyTo = eaStockQtyFrom;

    int csSaleable = csTruckStock?.SaleableQty ?? 0;
    int eaSaleable = eaTruckStock?.SaleableQty ?? 0;

    csChange = csChange ?? 0;
    eaChange = eaChange ?? 0;
    csSaleableChange = csSaleableChange ?? 0;
    eaSaleableChange = eaSaleableChange ?? 0;


    switch (action) {
      case StockTracking.CHKO:
        switch (stockType) {
          case StockType.DO:
            csStockQtyTo += csChange;
            eaStockQtyTo += eaChange;

            csSaleable += csSaleableChange;
            eaSaleable += eaSaleableChange;
            break;
          case StockType.CANCEL:
            csStockQtyTo -= csChange;
            eaStockQtyTo -= eaChange;

            csSaleable -= csSaleableChange;
            eaSaleable -= eaSaleableChange;
            break;
        }
        break;
      case StockTracking.DELE:
        switch (stockType) {
          case StockType.DO:
            csStockQtyTo -= csChange;
            eaStockQtyTo -= eaChange;

            csSaleable += csSaleableChange;
            eaSaleable += eaSaleableChange;
            break;
          case StockType.CANCEL:
            csStockQtyTo += csChange;
            eaStockQtyTo += eaChange;

            csSaleable -= csSaleableChange;
            eaSaleable -= eaSaleableChange;
            break;
        }
        break;
      case StockTracking.TRET:
        switch (stockType) {
          case StockType.DO:
            csStockQtyTo += csChange;
            eaStockQtyTo += eaChange;
            break;
          case StockType.CANCEL:
            csStockQtyTo -= csChange;
            eaStockQtyTo -= eaChange;
            break;
        }
        break;
      case StockTracking.ERET:
        switch (stockType) {
          case StockType.DO:
            csStockQtyTo += csChange;
            break;
          case StockType.CANCEL:
            csStockQtyTo -= csChange;
            break;
        }
        eaStockQtyTo = 0; //空瓶箱产品没有EA，所以这里存储为0
        break;
      case StockTracking.CHKI:
        switch (stockType) {
          case StockType.DO:
            csStockQtyTo -= csChange;
            eaStockQtyTo -= eaChange;
            csStockQtyTo = csStockQtyTo > 0 ? csStockQtyTo : 0;
            eaStockQtyTo = eaStockQtyTo > 0 ? eaStockQtyTo : 0;

            csSaleable -= csSaleableChange;
            eaSaleable -= eaSaleableChange;
            csSaleable = csSaleable > 0 ? csSaleable : 0;
            eaSaleable = eaSaleable > 0 ? eaSaleable : 0;

            break;
          case StockType.CANCEL:
            csStockQtyTo += csChange;
            eaStockQtyTo += eaChange;

            csSaleable += csSaleableChange;
            eaSaleable += eaSaleableChange;
            break;
        }
        break;
    }

    if (csTruckStock != null) {
      csTruckStock.StockQty = csStockQtyTo;
      csTruckStock.SaleableQty = csSaleable;
      csTruckStock.LastUpdateUser = Application.user.userCode;
      csTruckStock.LastUpdateTime = DateUtil.getDateStrByDateTime(DateTime.now());
      csTruckStock.dirty = SyncDirtyStatus.DEFAULT;

      await Application.database.tTruckStockDao.updateEntity(csTruckStock);
    } else {
      csTruckStock = new DSD_T_TruckStock_Entity.Empty();
      csTruckStock.TruckId = truckId;
      csTruckStock.ShipmentNo = shipmentNo;
      csTruckStock.ProductCode = productCode;
      csTruckStock.ProductUnit = ProductUnit.CS;
      csTruckStock.StockQty = csStockQtyTo;
      csTruckStock.SaleableQty = csSaleable;
      csTruckStock.CreateUser = Application.user.userCode;
      csTruckStock.CreateTime = DateUtil.getDateStrByDateTime(DateTime.now());
      csTruckStock.dirty = SyncDirtyStatus.DEFAULT;
      await Application.database.tTruckStockDao.insertEntity(csTruckStock);
    }

    if (eaTruckStock != null) {
      eaTruckStock.StockQty = eaStockQtyTo;
      eaTruckStock.SaleableQty = eaSaleable;
      eaTruckStock.LastUpdateUser = Application.user.userCode;
      eaTruckStock.LastUpdateTime = DateUtil.getDateStrByDateTime(DateTime.now());
      eaTruckStock.dirty = SyncDirtyStatus.DEFAULT;

      await Application.database.tTruckStockDao.updateEntity(eaTruckStock);
    } else {
      eaTruckStock = new DSD_T_TruckStock_Entity.Empty();
      eaTruckStock.TruckId = truckId;
      eaTruckStock.ShipmentNo = shipmentNo;
      eaTruckStock.ProductCode = productCode;
      eaTruckStock.ProductUnit = ProductUnit.EA;
      eaTruckStock.StockQty = eaStockQtyTo;
      eaTruckStock.SaleableQty = eaSaleable;
      eaTruckStock.CreateUser = Application.user.userCode;
      eaTruckStock.CreateTime = DateUtil.getDateStrByDateTime(DateTime.now());
      eaTruckStock.dirty = SyncDirtyStatus.DEFAULT;
      await Application.database.tTruckStockDao.insertEntity(eaTruckStock);
    }

    DSD_T_TruckStockTracking_Entity csAdd = new DSD_T_TruckStockTracking_Entity.Empty();
    csAdd.VisitId = visitId;
    csAdd.TruckId = truckId;
    csAdd.ShipmentNo = shipmentNo;
    csAdd.TrackingTime = DateUtil.getDateStrByDateTime(DateTime.now());
    csAdd.ProductCode = productCode;
    csAdd.ProductUnit = ProductUnit.CS;
    csAdd.ChangeAction = action;
    csAdd.FromQty = csStockQtyFrom;
    csAdd.ToQty = csStockQtyTo;
    csAdd.CreateUser = Application.user.userCode;
    csAdd.CreateTime = DateUtil.getDateStrByDateTime(DateTime.now());
    csAdd.dirty = SyncDirtyStatus.DEFAULT;
    await Application.database.tTruckStockTrackingDao.insertEntity(csAdd);

    DSD_T_TruckStockTracking_Entity eaAdd = new DSD_T_TruckStockTracking_Entity.Empty();
    eaAdd.VisitId = visitId;
    eaAdd.TruckId = truckId;
    eaAdd.ShipmentNo = shipmentNo;
    eaAdd.TrackingTime = DateUtil.getDateStrByDateTime(DateTime.now());
    eaAdd.ProductCode = productCode;
    eaAdd.ProductUnit = ProductUnit.EA;
    eaAdd.ChangeAction = action;
    eaAdd.FromQty = eaStockQtyFrom;
    eaAdd.ToQty = eaStockQtyTo;
    eaAdd.CreateUser = Application.user.userCode;
    eaAdd.CreateTime = DateUtil.getDateStrByDateTime(DateTime.now());
    eaAdd.dirty = SyncDirtyStatus.DEFAULT;
    await Application.database.tTruckStockTrackingDao.insertEntity(eaAdd);
  }

  ///
  /// 获取产品的库存数据
  ///
  /// @param shippmentNo
  ///
  static Future<List<TruckStockProductInfo>> getProductStock(String shipmentNo) async {
    List<DSD_T_TruckStock_Entity> stockEntityList =
        await Application.database.tTruckStockDao.findEntityByShipment(shipmentNo);

    Map<String, TruckStockProductInfo> hashMap = {};
    for (DSD_T_TruckStock_Entity entity in stockEntityList) {
      String code = entity.ProductCode;
      String unit = entity.ProductUnit;
      TruckStockProductInfo info = hashMap[code];
      if (info == null) {
        info = new TruckStockProductInfo();
        hashMap[code] = info;
        info.productCode = code;
      }
      if (ProductUnit.CS == unit) {
        info.csStockQty = entity.StockQty;
        info.csSaleableQty = entity.SaleableQty;
      } else if (ProductUnit.EA == unit) {
        info.eaStockQty = entity.StockQty;
        info.eaSaleableQty = entity.SaleableQty;
      }
    }
    List<TruckStockProductInfo> resultList = [];
    resultList.addAll(hashMap.values);
    return resultList;
  }
}
