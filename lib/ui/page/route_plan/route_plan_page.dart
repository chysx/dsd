

import 'package:dsd/model/route_plan_info.dart';
import 'package:dsd/res/strings.dart';
import 'package:dsd/ui/page/route_plan/route_plan_presenter.dart';
import 'package:dsd/ui/widget/drawer_widget.dart';
import 'package:dsd/ui/widget/list_header_widget.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RoutePlanPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var header = ListHeaderWidget(
      names: [
        IntlUtil.getString(context, Ids.route_plan_delivery_no),
        IntlUtil.getString(context, Ids.route_plan_type),
        IntlUtil.getString(context, Ids.route_plan_qty)
      ],
      weights: [1, 1, 1],
      aligns: [
        TextAlign.left,
        TextAlign.center,
        TextAlign.center,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('ROUTE PLAN'),
      ),
        body:
        Consumer<RoutePlanPresenter>(builder: (context, presenter, _) {
          return new Column(
            children: <Widget>[
              header,
              Expanded(
                child: ListView.builder(
                    itemCount: presenter.list.length,
                    itemBuilder: (content, index) {
                      RoutePlanInfo info = presenter.list[index];
                      return Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              "a",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "b",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "c",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    }),
              )
            ],
          );
        }),
       drawer: DrawerWidget(),
    );
  }
}