/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/29 14:19

class ShipmentInfo {
  String no;
  String type;
  String status;
  String description;
  bool isComplete; //已经CheckIn的Shipment是否上传数据过（主要用在CheckIn模块界面中）
  bool isCheck; //（主要用在CheckIn模块界面中）
  String shipmentDate;
  String sequence;

  @override
  String toString() {
    return 'ShipmentInfo{no: $no, type: $type, status: $status, description: $description, isComplete: $isComplete, isCheck: $isCheck, shipmentDate: $shipmentDate, sequence: $sequence}';
  }


}
