import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

class AddMenuData {
  final String name;
  final List<String> descriptions;
  final int maximumPeople;
  final int minimumPeople;
  final bool isVege;
  final int price;
  final int categoryId;
  final List<List<int>> imageData;
  final String postScript;
  final String devices;
  final String allergicFood;
  AddMenuData({
    this.name,
    this.descriptions,
    this.maximumPeople,
    this.minimumPeople,
    this.isVege,
    this.price,
    this.categoryId,
    this.imageData,
    this.postScript,
    this.devices,
    this.allergicFood,
  });
  Map toJson() => {
        'name': name,
        'descriptions': descriptions,
        'maximum_people': maximumPeople,
        'minimum_people': minimumPeople,
        'is_vagetarian': isVege,
        'price': price,
        'category_id': categoryId,
        'images': imageData,
      };
}

class AddMenuCallBack {
  final String message;
  AddMenuCallBack({
    this.message,
  });
}
