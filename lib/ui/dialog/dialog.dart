import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {
  String msg;

  LoadingDialog({Key key, @required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new Container(
          width: 120,
          height: 120,
          decoration: new ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(),
              new Padding(
                padding: const EdgeInsets.only(top: 20),
                child: new Text(
                  msg,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return new LoadingDialog(msg: '正在获取详情');
        });
  }

  static dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
