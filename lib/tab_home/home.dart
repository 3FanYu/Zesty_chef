import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zesty_chef/conf/config.inc.dart';
import 'package:zesty_chef/scoped_model/chef_menu_model.dart';

import 'package:zesty_chef/widgets/star_rating.dart';

import '../service_locator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<HomePage> 
with AutomaticKeepAliveClientMixin<HomePage> {
  bool keepAlive = false;
  Conf config = new Conf();
  ChefMenuModel chefMenuModel;
  @override
  void initState() {
    // 初始化数据
    super.initState();
    chefMenuModel = locator<ChefMenuModel>();
    chefMenuModel.fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ChefMenuModel>(
      model: chefMenuModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ChefMenuModel model) {
          Widget content = Text('No meals');
          if (model.isLoading) {
            content = Center(
              child: CircularProgressIndicator(),
            );
          } else if (!model.isLoading && model.chefMenus.length > 0) {
            content = _buildHomeBody(model);
            keepAlive = true;
            updateKeepAlive();
          } else if (!model.isLoading && model.chefMenus.length == 0) {
            keepAlive = false;
            updateKeepAlive();
          }
          return content;
        },
      ),
    );
  }

  Widget _buildHomeBody(ChefMenuModel model) {
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
                          config.imagePath + model.chefMenus[0].chefImage,
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
                        model.chefMenus[0].chefName,
                        style:
                            TextStyle(fontSize: 20, color: HexColor('#575757')),
                      ),
                      Text(model.chefMenus[0].chefName),
                      Text(model.chefMenus[0].chefIntro),
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
                  itemCount: model.chefMenus[0].menu.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        child: Image.network(
                          config.imagePath +
                              model
                                  .chefMenus[0].menu[index].menuDetails[0].path,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => keepAlive;

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
