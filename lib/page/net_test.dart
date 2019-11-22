import 'package:flutter/material.dart';
import 'package:flutter_github/redux/har_state.dart';
import 'package:flutter_github/redux/login_redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class NetTestPage extends StatefulWidget {
  @override
  _NetTestPageState createState() => _NetTestPageState();
}

class _NetTestPageState extends State<NetTestPage> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  String _username = "";
  String _password = "";

  @override
  void initState() {
    username.value = TextEditingValue(text: "Taohonghui");
    password.value = TextEditingValue(text: "th137258h");

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        width: width,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              width: width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: username,
                      decoration: new InputDecoration(
                          labelText: "账号", border: OutlineInputBorder()),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: password,
                      decoration: new InputDecoration(
                          labelText: "密码", border: OutlineInputBorder()),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text("登录"),
                      onPressed: () {
                        _username = username.value.toString();
                        _password = password.value.toString();
                        StoreProvider.of<HARState>(context)
                            .dispatch(LoginAction(context, _username, _password));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
