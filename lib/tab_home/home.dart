import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zesty_chef/conf/config.inc.dart';
import 'package:zesty_chef/scoped_model/chef_menu_model.dart';
import 'package:zesty_chef/tab_home/menu_card.dart';
import 'package:zesty_chef/upload_menu/add_menu.dart';

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
                          loadAssets();
                        }),
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
                  return MenuCard(
                    img: config.imagePath + model.chefMenus[0].menu[index].img,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        // selectedAssets: images,
        //ios customization
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
        ),
        //Android customization
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Select Photos",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if (resultList.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMenu(
            images: resultList,
          ),
        ),
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => keepAlive;
}
