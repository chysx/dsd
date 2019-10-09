import 'package:dsd/ui/page/profile/note_info.dart';
import 'package:dsd/utils/sql_util.dart';

import '../../application.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/9 11:18

class MdAccountManager {
   static Future<List<NoteInfo>> getRouteNoteList(String shipmentNo, String accountNumber) async {
     String sql = ''' 
            SELECT
            header.orderdate,
            header.salesrep,
            account.NoteToDriver__c
        FROM
            dsd_m_deliveryheader AS header        
        INNER JOIN
            md_account AS account          
                ON header.accountnumber = account.accountnumber                   
        WHERE
            header.shipmentno = ? 
            AND header.accountnumber = ? 
        ORDER BY header.deliverysequence ASC
     ''';
     SqlUtil.log(sql,[shipmentNo,accountNumber]);
     List<NoteInfo> result = [];
     var db = Application.database.database;
     List<Map<String, dynamic>> list = await db.rawQuery(sql,[shipmentNo,accountNumber]);
     for (Map<String, dynamic> map in list) {
       NoteInfo info = new NoteInfo();
       List values = map.values.toList();
       info
         ..date = values[0]
         ..name = values[1]
         ..dsc = values[2];
       result.add(info);
     }
     return result;
  }
}