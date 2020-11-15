import 'package:zesty_chef/model/menu.dart';

class ChefMenu {
  final String chefName;
  final String chefImage;
  final String chefIntro;
  final List<Menu> menu;
  ChefMenu({
    this.chefName,
    this.chefImage,
    this.chefIntro,
    this.menu,
  });
  factory ChefMenu.fromJson(dynamic json) {
    return ChefMenu(
      chefName: json['chef_name'],
      chefImage: json['chef_image'],
      chefIntro: json['chef_description'],
      menu: List<Menu>.from(
                json['menus'].map((x) => Menu.fromJson(x))),
    );
  }
}
