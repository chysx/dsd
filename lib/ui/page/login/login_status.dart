/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/7 15:48

enum LoginStatus {
  CheckUserCodeIsNull,
  CheckPasswordIsNull,
  SyncInit,
  SyncUpdate,
  OffLine,
}
enum LoginResponseStatus {
  //在线登录成功
  OnLineOk,
  //在线登录失败
  OnLineError,
  //离线登录成功
  OffLineOk,
  //离线登录失败
  OffLineError,
  //同步成功
  SyncOk,
  //同步失败
  SyncError,
  //错误的用户信息
  ErrorUserMsg,
  //账号无效
  AccountInvalid,
  //密码过期
  ErrorPasswordExpired,
  //账号锁定
  AccountLock,
  //用户编码为空
  VerifyErrorNullUserCode,
  //密码为空
  VerifyErrorNullPassword,
  //在线登录失败达到最大值
  OnLineErrorLimit,
  //本地服务器时间差异
  LocalServeTimeDifference,
  //强制修改初始密码
  UpdateInitPassword,
  //存在新的程序版本
  HasNewVersionApp,
  //当前账号没有分配Shipment
  NoShipment,
  //如果司机账号没有对应的APP版本好设置，则在登录时返回错误
  VersionIncorrect,
  //UserCode 和 IMEI不匹配
  ImeiNotMatch
}
