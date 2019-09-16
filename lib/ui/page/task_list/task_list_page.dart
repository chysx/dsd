import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/route/customer_info.dart';
import 'package:dsd/ui/page/task_list/task_list_info.dart';
import 'package:dsd/ui/page/task_list/task_list_presenter.dart';
import 'package:dsd/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/10 18:02

class TaskListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TaskListState();
  }
}

class _TaskListState extends State<TaskListPage> {
  Widget getDesc(TaskInfo info) {
    return StringUtil.isEmpty(info.description)
        ? Container()
        : Text(
            info.description,
            style: TextStyles.small,
          );
  }

  Widget getMust(TaskInfo info) {
    return info.isMust
        ? Text(
            '*',
            style: TextStyle(color: Colors.red),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskList'),
      ),
      body: Consumer<TaskListPresenter>(
        builder: (context, presenter, _) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                      itemCount: presenter.taskList.length,
                      separatorBuilder: (context, index) {
                        return Divider(height: 2);
                      },
                      itemBuilder: (context, index) {
                        TaskInfo info = presenter.taskList[index];

                        return Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: Row(
                            children: <Widget>[
                              Image.asset(info.imgPath),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    info.name,
                                    style: TextStyles.normal,
                                  ),
                                  getDesc(info)
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                              ),
                              getMust(info),
                              Spacer(),
                              Text(
                                info.status,
                                style: TextStyles.normal,
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
