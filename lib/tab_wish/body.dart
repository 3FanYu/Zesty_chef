import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import 'list_meal.dart';

class WishBody extends StatefulWidget {
  WishBody({Key key}) : super(key: key);

  @override
  _WishBodyState createState() => _WishBodyState();
}

class _WishBodyState extends State<WishBody> {
  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  Widget _buildListView() {
    var mealname = ['昇龍餃子', '黯然銷魂飯', '加菲貓千層麵', '一樂拉麵'];
    var username = ['余樊樊', '黃金十八羅漢', '超肥橘貓', '呦再不斬'];
    var paths = [
      'https://scontent.frmq2-1.fna.fbcdn.net/v/t1.15752-9/105769088_602026150439454_7319861255536146727_n.jpg?_nc_cat=110&ccb=2&_nc_sid=ae9488&_nc_ohc=3Kw_V1eJBqsAX-rHqUs&_nc_ht=scontent.frmq2-1.fna&oh=4278dfc4518547a4cb5eb130f4de30e1&oe=5FED3AD9',
      'https://scontent.frmq2-2.fna.fbcdn.net/v/t1.15752-9/82560298_265413568027105_2049773513535310427_n.jpg?_nc_cat=100&ccb=2&_nc_sid=ae9488&_nc_ohc=ZOf_95MKcHwAX91NBT3&_nc_ht=scontent.frmq2-2.fna&oh=ca5a8407cf6da10ac220aa771101cc77&oe=5FEE14EC',
      'https://scontent.frmq2-2.fna.fbcdn.net/v/t1.15752-9/129166212_694050544855925_130874659185852254_n.jpg?_nc_cat=104&ccb=2&_nc_sid=ae9488&_nc_ohc=Oe9nIEqicTsAX_JMKhX&_nc_ht=scontent.frmq2-2.fna&oh=52f613c6c9fb7bef5ac34ae7abdc6140&oe=5FEEA9AD',
      'https://scontent.frmq2-1.fna.fbcdn.net/v/t1.15752-9/128599918_200879571631454_5726815568780643602_n.png?_nc_cat=102&ccb=2&_nc_sid=ae9488&_nc_ohc=kf1gc8o1-PQAX-g9fo5&_nc_oc=AQnsyqZN_NUnbX944CBh5pM3_LhHDF7pE_E3oTh45TFm1_N2HAT5M-tPwQrrCK4r6KQ&_nc_ht=scontent.frmq2-1.fna&oh=25ed0bfe21a81ee8b5454ea38e4f2098&oe=5FEE1779'
    ];
    var categories = ['動漫卡通', '經典電影', '動漫卡通', '動漫卡通'];
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      itemBuilder: (BuildContext context, int index) {
        return MealList(
          id: 1,
          title: mealname[index],
          chefName: username[index],
          categoryName: categories[index],
          path: paths[index],
          backgroundColor: HexColor('#FFFFFF'),
        );
      },
      itemCount: 4,
    );
  }
}
