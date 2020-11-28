import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: HexColor('#F1F1F1'),
              child: SafeArea(
                child: Column(
                  children: [
                    new Expanded(child: new Container()),
                    TabBar(
                      labelStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                      labelColor: HexColor('#727272'),
                      tabs: [
                        Tab(
                          text: '待確認',
                        ),
                        Tab(text: '即將到來'),
                        Tab(text: '已完成'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.local_laundry_service),
              Icon(Icons.ac_unit),
              Icon(Icons.do_not_disturb),
            ],
          ),
        ),
      ),
    );
  }
}
