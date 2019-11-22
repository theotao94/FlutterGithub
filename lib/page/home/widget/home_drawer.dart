import 'package:flutter/material.dart';
import 'package:flutter_github/common/style/har_style.dart';
import 'package:flutter_github/model/User.dart';
import 'package:flutter_github/redux/har_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoreBuilder<HARState>(
        builder: (context,store){
          User user = store.state.userInfo;
          return Drawer(
            child: Container(
              color: store.state.themeData.primaryColor,
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: Material(
                    color: HARColors.white,
                    child: Column(
                      children: <Widget>[
                        Container(color: Colors.red,height: MediaQuery.of(context).size.height/4,
                        width:  MediaQuery.of(context).size.width,
                        child: Stack(children: <Widget>[
                          Container(color: Colors.amber,height: 20,width: 20,)
                        ],),
                        )
                      ],
                    ) ,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
