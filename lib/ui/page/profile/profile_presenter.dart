import 'package:dsd/application.dart';
import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/constant.dart';
import 'package:dsd/common/dictionary.dart';
import 'package:dsd/db/manager/dictionary_manager.dart';
import 'package:dsd/db/table/entity/md_account_entity.dart';
import 'package:dsd/db/table/entity/md_dictionary_entity.dart';
import 'package:dsd/event/EventNotifier.dart';

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
  List<MD_Dictionary_Entity> dictionaryList = [];
  String accountNumber;
  String shipmentNo;
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

  void setPageParams(Map<String, List<String>> params) {
    shipmentNo = params[FragmentArg.ROUTE_SHIPMENT_NO][0];
    accountNumber = params[FragmentArg.ROUTE_ACCOUNT_NUMBER][0];
  }

  Future initData() async {
    await fillStore();
  }

  Future fillStore() async {
    dictionaryList =
        await Application.database.dictionaryDao.findEntityByCategory(AccountMasterFields.CATEGORY, Valid.EXIST);
    MD_Account_Entity account = await Application.database.accountDao.findEntityByAccountNumber(accountNumber);

    for (MD_Dictionary_Entity entity in dictionaryList) {
      String key = entity.Description;
      String value;
      if (entity.Value.contains(AccountMasterFields.STORE_INFO) && entity.Value != AccountMasterFields.STORE_INFO) {
        List<String> valueList = entity.Value.split(mark);
        String table = valueList[1];
        String field = valueList[2];
        if (table == 'MD_Account') {
          Map<String, dynamic> map = MD_Account_Entity.toJson(account);
          value = map[field];
          value = await convertValueToDesc(field,value);
        }
        MapEntry<String, String> mapEntry = new MapEntry(key, value);
        profileStoreList.add(mapEntry);
      }
    }
  }

   Future<String> convertValueToDesc(String columnName,String columnValue) async {
    if('EbMobile__TradeChannel__c'.toLowerCase() == columnName.toLowerCase()){
      String category = AccountMasterFields.Account_ebMobile__TradeChannel__c;
      return await DictionaryManager.getDictionaryDescription(category,columnValue);
    }else if('EbMobile__SubTradeChannel__c'.toLowerCase() == columnName.toLowerCase()){
      String category = AccountMasterFields.Account_ebMobile__SubTradeChannel__c;
      return await DictionaryManager.getDictionaryDescription(category,columnValue);
    }else if('EbMobile__Segment__c'.toLowerCase() == columnName.toLowerCase()){
      String category = AccountMasterFields.Account_ebMobile__Classification__c;
      return await DictionaryManager.getDictionaryDescription(category,columnValue);
    }
    return columnValue;
  }
}
