import 'package:dsd/common/constant.dart';
import 'package:dsd/model/shipment_info.dart';
import 'package:dsd/res/colors.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/checkin/checkin_shipment_presenter.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:dsd/ui/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/26 17:06

class CheckInShipmentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CheckInShipmentState();
  }
}

class _CheckInShipmentState extends State<CheckInShipmentPage> {
  @override
  Widget build(BuildContext context) {
    var header = ListHeaderWidget(
      names: [
        'Shipment',
        'Visited/Total',
        'Type',
        'Status'
      ],
      weights: [1, 1, 1, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
        TextAlign.center,
        TextAlign.center,
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('SHIPMENT'),
      ),
      body: Consumer<CheckInShipmentPresenter>(builder: (context, presenter, _) {
        return Column(
          children: <Widget>[
            _buildTopContent(),
            Padding(
              padding: EdgeInsets.only(top: 6),
            ),
            _buildCenterContent(presenter),
            Padding(
              padding: EdgeInsets.only(top: 6),
            ),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            header,
            _buildBottomContent(presenter),
          ],
        );
      }),
      drawer: DrawerWidget(page: ConstantMenu.CHECK_IN,),
    );
  }

  Widget _buildTopContent() {
    return Container(
      padding: EdgeInsets.all(10),
      color: ColorsRes.gray_normal,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'SHIPMENTS',
              style: TextStyles.large,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterContent(CheckInShipmentPresenter presenter) {
    return SearchWidget((str) {});
  }

  Widget _buildBottomContent(CheckInShipmentPresenter presenter) {
    return Expanded(
      child: Container(
        child: ListView.separated(
            itemCount: presenter.shipmentInfoList.length,
            separatorBuilder: (context, index) {
              return Divider(
                height: 2,
              );
            },
          itemBuilder: (context, index){
              ShipmentInfo info = presenter.shipmentInfoList[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  presenter.onClickItem(context, info);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(info.no,style: TextStyles.normal,textAlign: TextAlign.center,),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('0/3',style: TextStyles.normal,textAlign: TextAlign.center,),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(info.type,style: TextStyles.normal,textAlign: TextAlign.center,),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(info.status,style: TextStyles.normal,textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
              );
          },
            ),
      ),
    );
  }
}
