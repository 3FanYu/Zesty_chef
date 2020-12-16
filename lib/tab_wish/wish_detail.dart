import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zesty_chef/conf/config.inc.dart';

class WishDetailPage extends StatefulWidget {
  final int mealID;
  const WishDetailPage({Key key, @required this.mealID}) : super(key: key);

  @override
  _WishDetailPageState createState() => _WishDetailPageState();
}

class _WishDetailPageState extends State<WishDetailPage> {
  Conf config = new Conf();
  int mealIndex = 0;
  int _currentImageIndex = 0;
  // List<MenuDetails> test = [
  //   MenuDetails(description: "lol", path: "app/image/1.jpg"),
  //   MenuDetails(description: "lol1", path: "app/image/1.jpg"),
  //   MenuDetails(description: "lol2", path: "app/image/1.jpg"),
  //   MenuDetails(description: "lol3", path: "app/image/1.jpg"),
  //   MenuDetails(description: "lol4", path: "app/image/1.jpg"),
  //   MenuDetails(description: "lol5", path: "app/image/1.jpg"),
  // ];
  String reason = '';
  void _updateImageIndex(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
      _currentImageIndex = index;
      print(_currentImageIndex);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  Widget _buildPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#BE413A'),
        iconTheme: IconThemeData(
          color: HexColor('#898888'),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print('object');
                },
                child: Icon(
                  Icons.mail,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 20,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(
                          'https://scontent.frmq2-2.fna.fbcdn.net/v/t1.0-9/61473066_2837548139651092_7657527123665485824_o.jpg?_nc_cat=107&ccb=2&_nc_sid=09cbfe&_nc_ohc=ad19A7oJJigAX-sVlv3&_nc_ht=scontent.frmq2-2.fna&oh=cb9ac0b5b9c4a0fffac485c00e39cbbd&oe=5FEBA122'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      '余樊樊',
                      style: TextStyle(
                        color: HexColor('#757373'),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 80,
            child: _buildCarousel(),
          ),
          Expanded(
            flex: 2,
            child: _buildDotIndicator(),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: RaisedButton(
                      child: Text('我要挑戰'),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => mealOrder(
                        //       mealDetail: model.meals,
                        //     ),
                        //   ),
                        // );
                      }),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  // child: Icon(
                  //   Icons.mail,
                  //   size: 30,
                  //   color: Colors.red,
                  // ),
                ),
                Spacer(),
                // Icon(Icons.hourglass_empty),
              ],
            ),
          ),
          Expanded(
              flex: 64,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '餐點名稱：',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '昇龍餃子',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '餐點介紹：',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '希望能吃到跟小當家裡面一樣會動的昇龍餃子',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

//生成圖片輪播器
  Widget _buildCarousel() {
    var menuDetails = [
      'https://scontent.frmq2-1.fna.fbcdn.net/v/t1.15752-9/105769088_602026150439454_7319861255536146727_n.jpg?_nc_cat=110&ccb=2&_nc_sid=ae9488&_nc_ohc=3Kw_V1eJBqsAX-rHqUs&_nc_ht=scontent.frmq2-1.fna&oh=4278dfc4518547a4cb5eb130f4de30e1&oe=5FED3AD9',
      'https://scontent.frmq2-2.fna.fbcdn.net/v/t1.15752-9/128176029_208320914208149_564985122850153705_n.jpg?_nc_cat=104&ccb=2&_nc_sid=ae9488&_nc_ohc=73KddXcS5rAAX9Qx214&_nc_ht=scontent.frmq2-2.fna&oh=ca6177363ac16e4fbf59ea8d5a8b275d&oe=5FED3134'
    ];
    return Container(
      child: GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CarouselSlider(
              items: menuDetails.map((obj) {
                return Image.network(
                  obj,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: _updateImageIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }

//生成圖片輪播器下面的點點
  Widget _buildDotIndicator() {
    var menuDetails = ['', ''];
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: menuDetails.map((obj) {
            int index = menuDetails.indexOf(obj);
            print(index);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                ),
                color: _currentImageIndex == index
                    ? HexColor('#707070')
                    : HexColor('#FFFFFF'),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
