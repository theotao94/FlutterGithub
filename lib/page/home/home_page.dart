import 'package:flutter/material.dart';
import 'package:flutter_github/page/home/widget/home_drawer.dart';

class HomePage extends StatefulWidget {
  static final String pageName = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("123"),
      drawer: HomeDrawer(),
    );
  }
}
