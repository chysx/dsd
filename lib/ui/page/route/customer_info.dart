/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/4 10:48

class CustomerInfo {
  String idByVanSales;
  String accountNumber;
  String name;
  String address;
  String tel;
  String phone;
  String contactName;
  String status;
  double latitude;
  double longitude;
  String index;

  String cancelReason;
  bool isShow = false;
  String customerType;

  String newAndStatus;
  bool isVisitComplete;
  String block;
  String barcode;

  String timeSlotFrom;
  String timeSlotTo;

  String deliveryNote;
  String arriveTime;
  String finishTime;

  bool isMore = false;

  @override
  String toString() {
    return 'CustomerInfo{idByVanSales: $idByVanSales, accountNumber: $accountNumber, name: $name, address: $address, tel: $tel, phone: $phone, contactName: $contactName, status: $status, latitude: $latitude, longitude: $longitude, index: $index, cancelReason: $cancelReason, isShow: $isShow, customerType: $customerType, newAndStatus: $newAndStatus, isVisitComplete: $isVisitComplete, block: $block, barcode: $barcode, timeSlotFrom: $timeSlotFrom, timeSlotTo: $timeSlotTo, isMore: $isMore}';
  }


}
