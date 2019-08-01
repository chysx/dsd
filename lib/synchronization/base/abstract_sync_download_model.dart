import 'package:dio/dio.dart';
import 'package:dsd/net/api_service.dart';
import 'package:dsd/synchronization/bean/sync_request_bean.dart';
import 'package:dsd/synchronization/bean/sync_response_bean.dart';
import 'package:dsd/synchronization/impl/download_parser.dart';
import 'package:dsd/synchronization/impl/download_request_create.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:rxdart/rxdart.dart';

import 'abstract_sync_mode.dart';
import 'i_sync_download.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 11:54

abstract class AbstractSyncDownloadModel
    extends AbstractSyncMode<Future<SyncRequestBean>, Response<Map<String, dynamic>>>
    implements ISyncDownload {
  AbstractSyncDownloadModel(SyncType syncType) : super(syncType) {
    parser = new DownloadParser();
    parser.setParsePolicy(this);
    requestCreate = new DownloadRequestCreate();
    requestCreate.setSyncDownloadModel(this);
  }

  Future<Observable<Response<Map<String, dynamic>>>> prepare() async{
    return Observable.fromFuture(requestCreate.create()).flatMap((syncRequestBean){
      return Observable.fromFuture(
          ApiService.getSyncDataByDownload(syncRequestBean));
    });
  }

  void onSuccess() {
    super.onSuccess();
  }

  void onFail() {
    super.onFail();
  }

  List<List<String>> getDownloadParameterValues() {
    return syncParameter.getDownloadParameterValues();
  }

  void policy() {}

  @override
  bool isAllDataAndAllInsert(String tableName) {
    return false;
  }

}
