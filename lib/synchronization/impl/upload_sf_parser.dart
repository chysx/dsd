import 'package:dio/dio.dart';
import 'package:dsd/log/log_util.dart';
import 'package:dsd/synchronization/base/abstract_parser.dart';
import 'package:dsd/synchronization/base/i_parse_policy.dart';
import 'package:dsd/synchronization/bean/sync_response_bean.dart';
import 'package:dsd/synchronization/sync/sync_response_status.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 16:08

class UploadSfParser extends AbstractParser<Response<Map<String, dynamic>>> {
  UploadSfParser(IParsePolicy parsePolicy) : super(parsePolicy);

  @override
  Future<bool> parse(Response<Map<String, dynamic>> response) async {
    String result = response.data['Result'];
    Log().logger.i('*************upload response***************\n $result');
    return result == 'SUCCESS';
  }
}
