import 'package:dsd/res/colors.dart';
import 'package:dsd/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkin_presenter.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/12 16:20

class CheckInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHECKIN'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          )
        ],
      ),
      body: Consumer<CheckInPresenter>(
        builder: (context, presenter, _){
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              presenter.onClickItem(context, presenter.shipmentNo);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              color: ColorsRes.gray_normal,
              child: Row(
                children: <Widget>[
                  Text('INVENTORY CHECKIN',style: TextStyles.large,),
                  Spacer(),
                  Text(presenter.getIsCompleteText(),style: TextStyles.large,),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
