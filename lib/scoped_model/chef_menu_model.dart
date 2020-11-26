import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:zesty_chef/conf/config.inc.dart';
import 'package:zesty_chef/model/chef_menu.dart';
import 'package:zesty_chef/model/menu.dart';

class ChefMenuModel extends Model {
  List<ChefMenu> _chefMenus = [];
  bool _isLoading = false;
  Conf conf = new Conf();

  List<ChefMenu> get chefMenus {
    return _chefMenus;
  }

  bool get isLoading {
    return _isLoading;
  }

  void fetchMeals() async {
    try {
      http.Response response =
          await http.get(conf.apiPath + 'chef/getChefMenu/3');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 1. Create a List of Meal
        final List<ChefMenu> fetchedChefMenu = [];
        // 2. Decode the response body
        Map<String, dynamic> map = jsonDecode(response.body);
        Map<String, dynamic> data = map['data'];
        // 3. Iterate through all the users in the list
        // 4. Create a new user and add to the list
        final ChefMenu chefMenu = ChefMenu.fromJson(data);
        // final ChefMenu chefMenu = ChefMenu(
        //   chefName: data['chef_name'],
        //   chefImage: data['chef_image'],
        //   chefIntro: data['chef_description'],
        //   menu: List<Menu>.from(data['menus'].map((x) => Menu.fromJson(x))),
        // );
        // print(chefMenu.menu[2].name);
        fetchedChefMenu.add(chefMenu);
        // 5. Update our list and the UI
        _chefMenus = fetchedChefMenu;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
