import 'package:dsd/bloc/bloc_base.dart';
import 'package:dsd/ui/page/settings/settings_presenter.dart';
import 'package:rxdart/rxdart.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/5 11:36

class SettingBloc extends BaseBloc {
  SettingPresenter presenter;
  BehaviorSubject<SettingPresenter> _settingSubject = BehaviorSubject<SettingPresenter>();

  Sink<SettingPresenter> get _settingSink => _settingSubject.sink;
  Stream<SettingPresenter> get settingStream => _settingSubject.stream.asBroadcastStream();

  BehaviorSubject<bool> _selectSubject = BehaviorSubject<bool>();
  Sink<bool> get _selectSink => _selectSubject.sink;
  Stream<bool> get selectStream => _selectSubject.stream.asBroadcastStream();

  SettingBloc(){
    presenter = new SettingPresenter();
    presenter.initData();
  }

  void notify() {
    _settingSink.add(presenter);
  }

  void setSelect(bool isSelect){
    _selectSink.add(isSelect);
  }

  @override
  void dispose() {
    _settingSubject.close();
    _selectSubject.close();
  }

}