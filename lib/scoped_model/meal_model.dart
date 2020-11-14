import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:zesty_chef/conf/config.inc.dart';
import 'package:zesty_chef/model/meal.dart';

class MealModel extends Model {
  List<Meal> _meals = [];
  bool _isLoading = false;
  Conf conf = new Conf();

  List<Meal> get meals {
    return _meals;
  }

  bool get isLoading {
    return _isLoading;
  }

  void fetchMeals() async {
    try {
      http.Response response =
          await http.get(conf.apiPath + 'chef/getChefMenu');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 1. Create a List of Meal
        final List<Meal> fetchedMealList = [];
        // 2. Decode the response body
        print(jsonDecode(response.body));
        Map<String, dynamic> map = jsonDecode(response.body);
        List<dynamic> responseData = map['data'];
        // 3. Iterate through all the users in the list
        responseData?.forEach((dynamic mealData) {
          // 4. Create a new user and add to the list
          final Meal meal = Meal(
            id: mealData['id'],
            name: mealData['name'],
            price: mealData['price'],
            maximumPeople: mealData['maximum_people'],
            minimumPeople: mealData['minimum_people'],
            stars: mealData['stars'],
            menuDetails: List<MenuDetail>.from(
                mealData['menu_details'].map((x) => MenuDetail.fromJson(x))),
          );
          fetchedMealList.add(meal);
        });
        // 5. Update our list and the UI
        _meals = fetchedMealList;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
