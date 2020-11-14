import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_menu/bottom_menu.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBar(),
    );
  }
}