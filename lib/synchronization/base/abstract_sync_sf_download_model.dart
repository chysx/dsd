import 'package:dio/dio.dart';
import 'package:dsd/net/api_service.dart';
import 'package:dsd/synchronization/bean/sync_request_bean.dart';
import 'package:dsd/synchronization/bean/sync_response_bean.dart';
import 'package:dsd/synchronization/bean/sync_sf_request_bean.dart';
import 'package:dsd/synchronization/impl/download_parser.dart';
import 'package:dsd/synchronization/impl/download_request_create.dart';
import 'package:dsd/synchronization/impl/download_sf_parser.dart';
import 'package:dsd/synchronization/impl/download_sf_request_create.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
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

abstract class AbstractSyncSfDownloadModel
    extends AbstractSyncMode<Future<SyncSfRequestBean>, Response<Map<String, dynamic>>> implements ISyncDownload {
  AbstractSyncSfDownloadModel(SyncType syncType,
      {SyncParameter syncParameter, OnSuccessSync onSuccessSync, OnFailSync onFailSync})
      : super(syncType, syncParameter: syncParameter, onSuccessSync: onSuccessSync, onFailSync: onFailSync) {
    parser = new DownloadSfParser(this);
    requestCreate = new DownloadSfRequestCreate(this);
  }

  Future<Observable<Response<Map<String, dynamic>>>> prepare() async {
    if(syncType == SyncType.SYNC_CONFIG_SF){
      return Observable.fromFuture(requestCreate.create()).flatMap((syncRequestBean) {
        return Observable.fromFuture(ApiService.getSFConfigData());
      });
    }else{
      return Observable.fromFuture(requestCreate.create()).flatMap((syncRequestBean) {
        return Observable.fromFuture(ApiService.getSFDownloadData(syncRequestBean));
      });
    }
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
