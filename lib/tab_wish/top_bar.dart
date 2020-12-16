import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  TopBar({Key key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100.0);
}

class _TopBarState extends State<TopBar> {
  List<ListItem> _dropdownItems = [
    ListItem(1, "全部"),
    ListItem(2, "我的"),
    ListItem(3, "已完成"),
    ListItem(4, "未完成"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: 40.0,
        left: 20.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(
        color: HexColor('#BE413A'),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/search.png', width: 30, height: 30),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: DropdownButton<ListItem>(
                    value: _selectedItem,
                    items: _dropdownMenuItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedItem = value;
                      });
                    }),
              ),
            ],
          ),
          // Image.asset('assets/images/chefs-hat.png', width: 40, height: 40),
        ],
      ),
    );
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
}
