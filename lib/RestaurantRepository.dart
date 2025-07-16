import 'package:flutter/foundation.dart';
import '../core/models/restaut.dart';
import '../core/services/api_service.dart';

class RestaurantRepository extends ChangeNotifier {
  List<Restaut> _restaurants = [];

  List<Restaut> get restaurants => _restaurants;

  Future<void> fetchRestaurants() async {
    try {
      final data = await ApiService.getRestaurants();
      _restaurants = data.map((json) => Restaut.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print('❌ Erreur chargement restaurants : $e');
    }
  }

  Future<Restaut?> getByName(String name) async {
    if (_restaurants.isEmpty) {
      await fetchRestaurants(); // on les récupère si pas encore fait
    }
    try {
      return _restaurants.firstWhere((r) => r.name == name);
    } catch (_) {
      return null;
    }
  }
}