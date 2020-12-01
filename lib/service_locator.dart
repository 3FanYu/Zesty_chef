import 'package:get_it/get_it.dart';
import 'package:zesty_chef/scoped_model/add_menu_model.dart';
import 'package:zesty_chef/scoped_model/chef_menu_model.dart';

import 'scoped_model/order_model.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerFactory<ChefMenuModel>(() => ChefMenuModel());
  locator.registerFactory<AddMenuModel>(() => AddMenuModel());
  locator.registerFactory<OrderModel>(() => OrderModel());
}
