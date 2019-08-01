/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/26 17:58

abstract class ISyncDownload {
  List<String> getTableDownloadList();

  List<List<String>> getDownloadParameterValues();
}
