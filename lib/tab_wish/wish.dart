import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zesty_chef/tab_wish/body.dart';
import 'package:zesty_chef/tab_wish/top_bar.dart';

class WishPage extends StatefulWidget {
  WishPage({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<WishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F1F1F1'),
      appBar: TopBar(),
      body: WishBody(),
    );
  }
}
