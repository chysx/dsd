import 'package:dsd/synchronization/bean/table_uploade_bean.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/26 16:48

abstract class ISyncUpload {
  List<TableUploadBean> getTableUploadList();

  List<String> getUploadUniqueIdValues();
}
