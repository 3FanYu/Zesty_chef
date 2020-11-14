import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zesty_chef/conf/config.inc.dart';

import 'package:zesty_chef/scoped_model/meal_model.dart';
import 'package:zesty_chef/widgets/star_rating.dart';

import '../service_locator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<HomePage> {
  Conf config = new Conf();
  MealModel mealModel;
  @override
  void initState() {
    // 初始化数据
    super.initState();
    mealModel = locator<MealModel>();
    mealModel.fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MealModel>(
      model: mealModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MealModel model) {
          Widget content = Text('No meals');
          if (model.isLoading) {
            content = Center(
              child: CircularProgressIndicator(),
            );
          } else if (!model.isLoading && model.meals.length > 0) {
            content = _buildHomeBody(model);
            // keepAlive = true;
            // updateKeepAlive();
          } else if (!model.isLoading && model.meals.length == 0) {
            // keepAlive = false;
            // updateKeepAlive();
          }
          return content;
        },
      ),
    );
  }

  Widget _buildHomeBody(MealModel model) {
    return Scaffold(
      backgroundColor: HexColor('#F1F1F1'),
      body: SingleChildScrollView(
        child: Column(
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
            Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      ),
                  itemCount: model.meals.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        child: Image.network(
                          config.imagePath +
                              model.meals[index].menuDetails[0].path,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // void _retrieveIcons() {
  //   Future.delayed(Duration(milliseconds: 200)).then((e) {
  //     setState(() {
  //       _icons.addAll([
  //         Icons.ac_unit,
  //         Icons.airport_shuttle,
  //         Icons.all_inclusive,
  //         Icons.beach_access,
  //         Icons.cake,
  //         Icons.free_breakfast
  //       ]);
  //     });
  //   });
  // }
}
