import 'package:dsd/db/util.dart';
import 'package:dsd/res/colors.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/dialog/customer_dialog.dart';
import 'package:dsd/ui/page/route/route_presenter.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
import 'package:dsd/ui/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';


/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/20 10:41

class RoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RouteState();
  }
}

class _RouteState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Text('Route'),
          onLongPress: () {
            DbUtil.copyDb();
          },
        ),
      ),
      body: Consumer<RoutePresenter>(
        builder: (context, presenter, _){
          return Column(
            children: <Widget>[
              _buildTopContent(presenter),
              Padding(
                padding: EdgeInsets.only(top: 6),
              ),
              _buildCenterContent(),
              Padding(
                padding: EdgeInsets.only(top: 6),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
              _buildBottomContent(),
            ],
          );
        }
      ),
      drawer: DrawerWidget(),
    );
  }

  List<DropdownMenuItem<String>> makeDropList(RoutePresenter presenter) {
    return presenter.shipmentList.map((item) {
      return DropdownMenuItem<String>(
        value: item.no,
        child: Text(
          item.no,
          style: TextStyles.normal,
        ),
      );
    }).toList();
  }

  Widget _buildTopContent(RoutePresenter presenter) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      color: ColorsRes.gray_normal,
      child: Row(
        children: <Widget>[
          DropdownButton<String>(
              underline: Container(),
              value: presenter.currentShipment.no,
              onChanged: (newValue) {
                presenter.onEvent(RouteEvent.SelectShipment, newValue);
              },
              items: makeDropList(presenter)),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.map,
                color: ColorsRes.brown_normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterContent() {
    return SearchWidget((str) {
      print(str);
    });
  }

  Widget _buildBottomContent() {
    List<String> items = List.generate(20, (index) => 'item $index');
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(index),
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: <Widget>[
                SlideAction(
                  child: Text('Print'),
                  color: Colors.grey.shade200,
                ),
                SlideAction(
                  child: Text('Delete'),
                  color: Colors.red,
                ),
              ],
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      CustomerDialog.showCustomerDialog(context,title: 'sfjdo',msg: 'sdf');
//                      setState(() {
//                        isMore = !isMore;
//                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Text(
                          '01',
                          style: TextStyles.normal,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              Text(
                                'Team Zuich',
                                style: TextStyles.normal,
                              ),
                              Text(
                                'Wuhan',
                                style: TextStyles.small,
                              ),
                              Text(
                                '08:00-23:00',
                                style: TextStyles.small,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    size: 15,
                                  ),
                                  Text(
                                    'zhang san',
                                    style: TextStyles.small,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.phone_iphone, size: 15),
                                  Icon(Icons.phone, size: 15),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'D',
                          style: TextStyles.normal,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: (){

                          },
                          color: Colors.blue,
                          child: Text(
                            'Plan',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 1),),
                      Expanded(
                        child: FlatButton(
                          onPressed: (){

                          },
                          color: Colors.blue,
                          child: Text(
                            'Profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 1),),
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.only(left: 0),
                          onPressed: (){

                          },
                          color: Colors.blue,
                          child: Text(
                            'Navigation',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 1),),
                      Expanded(
                        child: FlatButton(
                          onPressed: (){

                          },
                          color: Colors.blue,
                          child: Text(
                            'Start Call',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],

              ),
            );
          },
        ),
      ),
    );
  }
}
