import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:zesty_chef/conf/config.inc.dart';
import 'package:zesty_chef/model/order.dart';
import 'package:http/http.dart' as http;

class OrderModel extends Model {
  Map<String, List<Order>> _orders = {};
  Map<String, dynamic> _result = {};
  bool _isLoading = false;
  Conf conf = new Conf();

  Map<String, List<Order>> get orders {
    return _orders;
  }

  Map<String, String> get result {
    return _result;
  }

  bool get isLoading {
    return _isLoading;
  }

  void fetchOrders() async {
    _isLoading = true;
    try {
      print('rerun');
      http.Response response = await http.get(conf.apiPath + 'user/orders/3');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 1. Create a List of Meal
        final Map<String, List<Order>> fetchedOrders = {
          "pending": [],
          "coming_soon": [],
          "completed": []
        };
        // 2. Decode the response body
        Map<String, dynamic> map = jsonDecode(response.body);
        List<dynamic> responseData = map['data'];
        // 3. Iterate through all the users in the list
        responseData?.forEach((dynamic orderData) {
          final Order order = Order.fromJson(orderData);
          // 4. Create a new user and add to the list
          if (orderData['status'] == 1) {
            fetchedOrders['pending'].add(order);
          } else if (orderData['status'] == 2) {
            fetchedOrders['coming_soon'].add(order);
          } else if (orderData['status'] == 3) {
            fetchedOrders['completed'].add(order);
          }
        });
        // 5. Update our list and the UI
        print('length=' + fetchedOrders['pending'].length.toString());
        _orders = fetchedOrders;
        _isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      _isLoading = false;
      print(error);
    }
  }

  void acceptOrder(int id) async {
    try {
      _isLoading = true;
      http.Response response =
          await http.post(conf.apiPath + 'chef/chefAccept/$id');
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> result = jsonDecode(response.body);
        _result = result;
        _isLoading = false;
        fetchOrders();
        notifyListeners();
      }
    } catch (error) {
      _isLoading = false;
      print(error);
    }
  }

  void denyOrder(int id) async {
    try {
      _isLoading = true;
      http.Response response =
          await http.post(conf.apiPath + 'chef/chefCancel/$id');
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> result = jsonDecode(response.body);
        _result = result;
        _isLoading = false;
        fetchOrders();
      }
    } catch (error) {
      _isLoading = false;
      print(error);
    }
  }
}
