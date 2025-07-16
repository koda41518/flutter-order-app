import 'package:flutter/foundation.dart';
// restaurantRepository.dart
import '../core/models/restaut.dart';
import '../core/services/api_service.dart';

class RestaurantRepository {
  Future<List<Restaut>> getAllRestaurants() async {
    final data = await ApiService.getRestaurants(); // 👈 via API
    return data.map((e) => Restaut.fromJson(e)).toList();
  }

  Future<Restaut?> getByName(String name) async {
    final restos = await getAllRestaurants();
    try {
      return restos.firstWhere((r) => r.name == name);
    } catch (_) {
      return null;
    }
  }
}