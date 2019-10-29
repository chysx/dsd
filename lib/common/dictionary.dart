/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/29 17:01

class ShipmentStatus {
  static const String CATEGORY = "ShipmentStatus";
  static const String CHKI = "CHKI";
  static const String CHKO = "CHKO";
  static const String RELE = "RELE";
}

class ShipmentType {
  static const String CATEGORY = "ShipmentType";
  static const String DELIVERY = "Delivery";
  static const String VANSALES = "Van Sales";
}

class CustomerType {
  static const String Delivery = "Delivery";
  static const String VanSales = "Van Sales";
}

class DeliveryStatus {
  static const String CATEGORY = "DeliveryStatus";
  static const String DEFALUT_DELIVERY = "D";
  static const String DEFALUT_VANSALES = "V";
  static const String NOT_COMPLETE = "NC";
  static const String PARTIAL_DELIVERED = "PD";
  static const String TOTAL_DELIVERED = "TD";
  static const String REBOOK = "R";
  static const String HOLD = "H";
  static const String CANCEL = "C";
  static const String SALES = "S";

  static const String DEFALUT_DELIVERY_VALUE = "";
  static const String DEFALUT_VANSALES_VALUE = "";
  static const String NOT_COMPLETE_VALUE = "0";
  static const String PARTIAL_DELIVERED_VALUE = "1";
  static const String TOTAL_DELIVERED_VALUE = "2";
  static const String REBOOK_VALUE = "3";
  static const String HOLD_VALUE = "4";
  static const String CANCEL_VALUE = "5";
  static const String SALES_VALUE = "6";

  static String getDeliveryStatusDescription(String value) {
    if (value == null) return "";
    String des;
    switch (value) {
      case DeliveryStatus.NOT_COMPLETE_VALUE:
        des = DeliveryStatus.NOT_COMPLETE;
        break;
      case DeliveryStatus.PARTIAL_DELIVERED_VALUE:
        des = DeliveryStatus.PARTIAL_DELIVERED;
        break;
      case DeliveryStatus.TOTAL_DELIVERED_VALUE:
        des = DeliveryStatus.TOTAL_DELIVERED;
        break;
      case DeliveryStatus.REBOOK_VALUE:
        des = DeliveryStatus.REBOOK;
        break;
      case DeliveryStatus.HOLD_VALUE:
        des = DeliveryStatus.HOLD;
        break;
      case DeliveryStatus.CANCEL_VALUE:
        des = DeliveryStatus.CANCEL;
        break;
      case DeliveryStatus.SALES_VALUE:
        des = DeliveryStatus.SALES;
        break;
    }
    return des;
  }
}

class TaskType {
  static const String Delivery = "Delivery";
  static const String TradeReturn = "Trade Return";
  static const String EmptyReturn = "Empty Return";
  static const String VanSales = "Van Sales";
  static const String ARCollection = "ARCollection";
  static const String PreSales = "PreSales";
  static const String Document = "Document";
  static const String Survey = "Survey";
  static const String Notes = "Notes";
  static const String Profile = "Customer Profile";
}

class TaskDeliveryStatus {
  static const String Default = "";
  static const String NotComplete = "Not Complete";
  static const String Complete = "Complete";
  static const String PartialDelivered = "Partial Delivered";
  static const String TotalDelivered = "Total Delivered";
  static const String Rebook = "Rebook";
  static const String Hold = "Hold";
  static const String Cancel = "Cancel";
  static const String Sales = "Sales";
}

class AccountMasterFields {
  static const String CATEGORY = "AccountMasterFields";
  static const String STORE_INFO = "StoreInfo";
  static const String CONTACT_INFO = "ContactInfo";
  static const String FINANCE_INFO = "FinanceInfo";
  static const String DELIVERY_INFO = "DeliveryInfo";

  static const String Account_ebMobile__PaymentTerms__c = "Account_ebMobile__PaymentTerms__c";
  static const String Account_ebMobile__SubTradeChannel__c = "Account_ebMobile__SubTradeChannel__c";
  static const String Account_ebMobile__TradeChannel__c = "Account_ebMobile__TradeChannel__c";
  static const String Account_ebMobile__Classification__c = "Account_ebMobile__Classification__c";
}

class CheckOutDiffReason {
  static const String CATEGORY = "CODiffReason";
}

class CheckInDiffReason {
  static const String CATEGORY = "CIDiffReason";
}

class CancelDelReasonExZF61 {
  static const String CATEGORY = "CancelDelReasonExZF61";
}
