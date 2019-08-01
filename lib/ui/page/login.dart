import 'package:flutter/material.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/1 15:45

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFDF2E4),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Image.asset(
                    'assets/imgs/login_logo.png',
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 50,right: 50),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: "UserName",
                        hintText: "UserName",
                        prefixIcon: Icon(Icons.person)
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: Color(0xFFA17A02),
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              onPressed: (){},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.settings),
                          Text("Setting"),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Version:0.1.71"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//  color: Color(0xFFFDF2E4),
//  child: Image.asset('assets/imgs/login_logo.png',
//  height: 100,
//  fit: BoxFit.cover,),

}
