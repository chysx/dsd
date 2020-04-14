import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/dictionary_manager.dart';
import 'package:dsd/db/manager/md_account_manager.dart';
import 'package:dsd/db/table/entity/dsd_m_delivery_header_entity.dart';
import 'package:dsd/db/table/entity/md_account_entity.dart';
import 'package:dsd/db/table/entity/md_contact_entity.dart';
import 'package:dsd/db/table/entity/md_dictionary_entity.dart';
import 'package:dsd/event/EventNotifier.dart';
import 'package:dsd/ui/page/profile/note_info.dart';
import 'package:dsd/ui/page/profile/order_info.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/19 11:56

enum ProfileEvent {
  InitData,
}

class ProfilePresenter extends EventNotifier<ProfileEvent> {
  List<MapEntry<String, String>> profileStoreList = [];
  List<MapEntry<String, String>> profileContactList = [];
  List<MD_Dictionary_Entity> dictionaryList = [];
  List<OrderInfo> orderInfoList = [];
  List<NoteInfo> noteInfoList = [];
  String accountNumber;
  String shipmentNo;
  bool isFromVisit;
  static const String mark = ".";

  @override
  void onEvent(ProfileEvent event, [dynamic data]) async {
    switch (event) {
      case ProfileEvent.InitData:
        await initData();
        break;
    }
    super.onEvent(event, data);
  }

  void setBundle(Map<String, dynamic> bundle) {
    shipmentNo = bundle[FragmentArg.ROUTE_SHIPMENT_NO];
    accountNumber = bundle[FragmentArg.ROUTE_ACCOUNT_NUMBER];
    isFromVisit = bundle[FragmentArg.IS_FROM_VISIT] ?? false;
  }

  Future initData() async {
    await fillCustomerData();
    await fillOrderData();
    await fillNoteData();
  }

  Future fillCustomerData() async {
    dictionaryList = await Application.database.dictionaryDao
        .findEntityByCategory(AccountMasterFields.CATEGORY, Valid.EXIST);

    MD_Account_Entity account = await Application.database.accountDao
        .findEntityByAccountNumber(accountNumber);

    MD_Contact_Entity contact = await Application.database.contactDao
        .findEntityByAccountNumber(accountNumber);

    List<DSD_M_DeliveryHeader_Entity> deliveryHeaderList = await Application
        .database.mDeliveryHeaderDao
        .findEntityByCon(shipmentNo, accountNumber);
    DSD_M_DeliveryHeader_Entity deliveryHeader;
    if (deliveryHeaderList.length > 0) deliveryHeader = deliveryHeaderList[0];

    for (MD_Dictionary_Entity entity in dictionaryList) {
      if (entity.Value.contains(AccountMasterFields.STORE_INFO) &&
          entity.Value != AccountMasterFields.STORE_INFO) {
        profileStoreList.add(await fillStore(entity, account, deliveryHeader,contact));
      } else if (entity.Value.contains(AccountMasterFields.CONTACT_INFO) &&
          entity.Value != AccountMasterFields.CONTACT_INFO) {
//        profileContactList.add(await fillStore(entity,account));
      }
    }
  }

  fillOrderData() async {
    List<DSD_M_DeliveryHeader_Entity> deliveryHeaderList = await Application
        .database.mDeliveryHeaderDao
        .findEntityByCon(shipmentNo, accountNumber);
    for (DSD_M_DeliveryHeader_Entity entity in deliveryHeaderList) {
      OrderInfo info = new OrderInfo();
      info.no = entity.OrderNo;
      info.date = entity.OrderDate;
      info.type = entity.DeliveryType;
      info.qty = entity.PlanDeliveryQty;
      info.status = "New";
      orderInfoList.add(info);
    }
  }

  fillNoteData() async {
    noteInfoList =
        await MdAccountManager.getRouteNoteList(shipmentNo, accountNumber);
  }

  Future<MapEntry<String, String>> fillStore(
      MD_Dictionary_Entity entity,
      MD_Account_Entity account,
      DSD_M_DeliveryHeader_Entity deliveryHeader,
      MD_Contact_Entity contact) async {
    String key = entity.Description;
    String value;
    List<String> valueList = entity.Value.split(mark);
    String table = valueList[1];
    String field = valueList[2];
    if (table == 'MD_Account' && account != null) {
      Map<String, dynamic> map = MD_Account_Entity.toJson(account);
      value = map[field];
      value = await convertValueToDesc(field, value);
    } else if (table == 'DSD_M_DeliveryHeader' && deliveryHeader != null) {
      Map<String, dynamic> map =
          DSD_M_DeliveryHeader_Entity.toJson(deliveryHeader);
      value = map[field];
    } else if (table == 'MD_Contact' && contact != null) {
      Map<String, dynamic> map =
      MD_Contact_Entity.toJson(contact);
      value = map[field];
    }
    return MapEntry(key, value);
  }

  Future<String> convertValueToDesc(
      String columnName, String columnValue) async {
    if ('EbMobile__TradeChannel__c'.toLowerCase() == columnName.toLowerCase()) {
      String category = AccountMasterFields.Account_ebMobile__TradeChannel__c;
      return await DictionaryManager.getDictionaryDescription(
          category, columnValue);
    } else if ('EbMobile__SubTradeChannel__c'.toLowerCase() ==
        columnName.toLowerCase()) {
      String category =
          AccountMasterFields.Account_ebMobile__SubTradeChannel__c;
      return await DictionaryManager.getDictionaryDescription(
          category, columnValue);
    } else if ('EbMobile__Segment__c'.toLowerCase() ==
        columnName.toLowerCase()) {
      String category = AccountMasterFields.Account_ebMobile__Classification__c;
      return await DictionaryManager.getDictionaryDescription(
          category, columnValue);
    }
    return columnValue;
  }

  @override
  void dispose() {
    if (isFromVisit) {
      String noteDesc = "";
      try {
        noteDesc = noteInfoList[0].dsc;
      } catch (e) {}
      MdAccountManager.updateAccount(accountNumber, noteDesc);
    }

    super.dispose();
  }
}
