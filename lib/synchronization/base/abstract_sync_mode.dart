import 'package:dsd/synchronization/impl/rx_photo_request.dart';
import 'package:dsd/synchronization/impl/rx_request.dart';
import 'package:dsd/synchronization/sync/sync_call_back.dart';
import 'package:dsd/synchronization/sync/sync_message.dart';
import 'package:dsd/synchronization/sync/sync_parameter.dart';
import 'package:dsd/synchronization/sync/sync_status.dart';
import 'package:dsd/synchronization/sync/sync_type.dart';
import 'package:rxdart/rxdart.dart';

import 'abstract_parser.dart';
import 'abstract_request.dart';
import 'abstract_request_create.dart';
import 'i_parse_policy.dart';
import 'i_sync_flow.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 11:49

abstract class AbstractSyncMode<RQ, RP> implements ISyncFlow<RP>, IParsePolicy {
  AbstractParser<RP> parser;
  AbstractRequestCreate<RQ> requestCreate;
  AbstractRequest request = new RxRequest();
  SyncCallBack callBack;
  SyncStatus syncStatus = SyncStatus.SYNC_INIT;
  SyncType syncType;
  SyncParameter syncParameter = new SyncParameter();
  SyncMessage syncMessage = new SyncMessage();

  AbstractSyncMode(SyncType syncType) {
    this.syncType = syncType;
    if (syncType == SyncType.SYNC_UPLOAD_PHOTO) {
      request = new RxPhotoRequest();
    }
    this.request.setSyncMode(this);
  }

  void setParameter(SyncParameter syncParameter) {
    if (syncParameter != null) this.syncParameter = syncParameter;
  }

  SyncParameter getParameter() {
    return this.syncParameter;
  }

  void setMessage(SyncMessage syncMessage) {
    if (syncMessage != null) this.syncMessage = syncMessage;
  }

  SyncMessage getMessage() {
    return this.syncMessage;
  }

  void setParser(AbstractParser parser) {
    this.parser = parser;
    this.parser.setParsePolicy(this);
  }

  AbstractParser getParser() {
    return this.parser;
  }

  void setSyncCallBack(SyncCallBack callBack) {
    this.callBack = callBack;
  }

  SyncStatus getSyncStatus() {
    return this.syncStatus;
  }

  SyncType getSyncType() {
    return this.syncType;
  }

  AbstractRequest getRequest() {
    return this.request;
  }

  Future start() async {
    Observable<RP> observable = await prepare();
    request.execute(observable, callBack);
  }

  void onInit() {
    syncStatus = SyncStatus.SYNC_INIT;
  }

  void onLoad() {
    syncStatus = SyncStatus.SYNC_LOAD;
  }

  void onSuccess() {
    syncStatus = SyncStatus.SYNC_SUCCESS;
  }

  void onFail() {
    syncStatus = SyncStatus.SYNC_FAIL;
  }

  void onFinish() {
    callBack = null;
    request = null;
  }
}
