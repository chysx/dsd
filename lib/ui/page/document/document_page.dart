import 'package:dsd/res/styles.dart';
import 'package:dsd/ui/page/document/document_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'document_presenter.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/10/30 14:55

class DocumentPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PRINT'),
      ),
      body: Consumer<DocumentPresenter>(
        builder: (context, presenter, _) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                      itemCount: presenter.documentList.length,
                      separatorBuilder: (context, index) {
                        return Divider(height: 2);
                      },
                      itemBuilder: (context, index) {
                        DocumentInfo info = presenter.documentList[index];

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            presenter.onItemClick(context, info);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      info.name,
                                      style: TextStyles.normal,
                                    ),
                                    Text(
                                      'No.${info.deliveryNo}',
                                      style: TextStyles.small,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.print,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
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
