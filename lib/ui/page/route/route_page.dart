
import 'package:dsd/common/constant.dart';
import 'package:dsd/db/util.dart';
import 'package:dsd/res/colors.dart';
import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/route/customer_info.dart';
import 'package:dsd/ui/page/route/route_presenter.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
import 'package:dsd/ui/widget/search_widget.dart';
import 'package:flutter/cupertino.dart';
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
      drawer: DrawerWidget(page: ConstantMenu.ROUTE,),
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
                      presenter.onClickPlan(context,info);
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
                      presenter.onClickProfile(context,info);
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
                      presenter.onClickNavigation(context, info);
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
                      presenter.onClickStartCall(context,info);
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
                  child: Text('CANCEL'),
                  color: Colors.red,
                  onTap: (){
                    presenter.doClickCancel(context,info);
                  },
                ),
              ],
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      setState(() {
                        info.isMore = !info.isMore;
                      });
                    },
                    child: Container(
                      color: info.isVisitComplete ? ColorsRes.gray_normal : Colors.white,
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
                                  '${info?.timeSlotFrom?? ''} - ${info?.timeSlotTo?? ''}',
                                  style: TextStyles.small,
                                ),
                                Text(
                                  'Arrival:${info?.arriveTime?? ''}',
                                  style: TextStyles.small,
                                ),
                                Text(
                                  'Finish:${info?.finishTime?? ''}',
                                  style: TextStyles.small,
                                ),
                                Text(
                                  'Note:${info?.deliveryNote?? ''}',
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
                                    Padding(padding: EdgeInsets.only(left: 10),),
                                    Text(
                                      info?.tel?? '',
                                      style: TextStyles.small,
                                    ),
                                    Icon(Icons.phone, size: 15),
                                    Padding(padding: EdgeInsets.only(left: 10),),
                                    Text(
                                      info?.phone?? '',
                                      style: TextStyles.small,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            info.status,
                            style: TextStyles.normal,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                        ],
                      ),
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
