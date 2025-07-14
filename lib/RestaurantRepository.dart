import 'dart:convert';
import 'package:flutter/services.dart';
import '../core/models/restaut.dart';

class RestaurantRepository {
  Future<List<Restaut>> getAllRestaurants() async {
    final data = await rootBundle.loadString('assets/data/restaurants.json');
    final List<dynamic> list = json.decode(data);
    return list.map((e) => Restaut.fromJson(e)).toList();
  }

  Future<Restaut?> getByName(String name) async {
    final restos = await getAllRestaurants();
    return restos.firstWhere((r) => r.name == name, orElse: () => null);
  }
}