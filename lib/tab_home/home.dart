import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zesty_chef/widgets/star_rating.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<HomePage> {
   List<IconData> _icons = []; //保存Icon数据

   @override
  void initState() {
    // 初始化数据  
    _retrieveIcons();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F1F1F1'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //上半部
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50, left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //廚師頭像
                    CircleAvatar(
                      radius: 46,
                      backgroundImage: NetworkImage(
                        'http://163.17.135.152/Zesty/storage/app/chef/test.jpg',
                      ),
                    ),
                    Spacer(),
                    //星級數
                    StarRating(
                      rating: 3.5,
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '主廚名稱',
                      style:
                          TextStyle(fontSize: 20, color: HexColor('#575757')),
                    ),
                    Text('綽號'),
                    Text('介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹介紹'),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Stack(
              children: [
                Center(
                  child: Text(
                    '嚴選套餐',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      print('add');
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //每行三列
                    childAspectRatio: 1.0 //显示区域宽高相等
                    ),
                itemCount: _icons.length,
                itemBuilder: (context, index) {
                  //如果显示到最后一个并且Icon总数小于200时继续获取数据
                  if (index == _icons.length - 1 && _icons.length < 200) {
                    _retrieveIcons();
                  }
                  return Icon(_icons[index]);
                }),
          ),
        ],
      ),
    );
  }
   void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access, Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}
