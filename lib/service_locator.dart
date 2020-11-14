import 'package:get_it/get_it.dart';
import 'package:zesty_chef/scoped_model/meal_model.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerFactory<MealModel>(() => MealModel());
}
