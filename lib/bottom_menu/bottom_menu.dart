import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zesty_chef/tab_home/Home.dart';
import 'package:zesty_chef/tab_order/order.dart';
import 'package:zesty_chef/tab_wish/wish.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    HomePage(),
    OrderPage(),
    WishPage(),
  ];
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: HexColor('#4C5F6D'),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Colors.white : Colors.grey,
            ),
            title: Text(
              'home',
              style: TextStyle(
                color: _selectedIndex == 0 ? Colors.white : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              color: _selectedIndex == 1 ? Colors.white : Colors.grey,
            ),
            title: Text(
              'order',
              style: TextStyle(
                color: _selectedIndex == 1 ? Colors.white : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              color: _selectedIndex == 2 ? Colors.white : Colors.grey,
            ),
            title: Text(
              'wish',
              style: TextStyle(
                color: _selectedIndex == 2 ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
