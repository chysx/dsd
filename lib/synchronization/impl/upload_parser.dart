import 'package:dio/dio.dart';
import 'package:dsd/synchronization/base/abstract_parser.dart';
import 'package:dsd/synchronization/bean/sync_response_bean.dart';
import 'package:dsd/synchronization/sync/sync_response_status.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 16:08

class UploadParser extends AbstractParser<Response<Map<String, dynamic>>> {
  @override
  Future<bool> parse(Response<Map<String, dynamic>> response) async {
    SyncResponseBean syncDataBean = SyncResponseBean.fromJson(response.data);
    return syncDataBean.status == SyncResponseStatus.SUCCESS;
  }
}
