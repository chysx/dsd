
import 'package:dsd/db/util.dart';
import 'package:dsd/res/colors.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/route/customer_info.dart';
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
        centerTitle: true,
        title: GestureDetector(
          child: Consumer<RouteTitle>(
            builder: (context,routeTitle,_){
              return Text('Route(${routeTitle.completeCount}/${routeTitle.totalCount})');
            },
          ),
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
              _buildCenterContent(presenter),
              Padding(
                padding: EdgeInsets.only(top: 6),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
              _buildBottomContent(presenter),
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
              value: presenter.currentShipment?.no,
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

  Widget _buildCenterContent(RoutePresenter presenter) {
    return SearchWidget((str) {
      presenter.onEvent(RouteEvent.Search,str);
    });
  }

  Widget _buildBottomContent(RoutePresenter presenter) {
    List<CustomerInfo> customerList = presenter.customerList;
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: customerList.length,
          itemBuilder: (context, index) {
            CustomerInfo info = customerList[index];
            Widget row = Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: (){
                      presenter.onClickPlan(context);
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
                      presenter.onClickProfile(context);
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
                    padding: EdgeInsets.only(left: 0),
                    onPressed: (){
                      presenter.onClickStartCall();
                    },
                    color: Colors.blue,
                    child: Text(
                      'Start Call',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
            Widget child = info.isMore ? row : Container();
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
                      setState(() {
                        info.isMore = !info.isMore;
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Text(
                          info?.index?? '',
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
                                info?.name?? '',
                                style: TextStyles.normal,
                              ),
                              Text(
                                info?.address?? '',
                                style: TextStyles.small,
                              ),
                              Text(
                                info?.timeSlotFrom?? '',
                                style: TextStyles.small,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    size: 15,
                                  ),
                                  Text(
                                    info?.contactName?? '',
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
                  child
                ],

              ),
            );
          },
        ),
      ),
    );
  }
}
