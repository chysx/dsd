import 'package:dsd/res/colors.dart';
import 'package:dsd/res/strings.dart';
import 'package:dsd/res/styles.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/30 11:43

class CheckoutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(IntlUtil.getString(context, Ids.checkout_title)),),
      body: Container(
        padding: EdgeInsets.all(10),
        color: ColorsRes.gray_normal,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(IntlUtil.getString(context, Ids.checkout_view_inventory),style: TextStyles.normal,),
                    Text(IntlUtil.getString(context, Ids.checkout_msg_inventory_nocompleted),style: TextStyles.small,),
                  ],
                ),
                Text(IntlUtil.getString(context, Ids.checkout_msg_inventory_nocompleted),style: TextStyles.normal,),
                Icon(Icons.arrow_forward_ios,color: Colors.grey,)
              ],
            )
          ],
        ),
      ),
    );
  }

}