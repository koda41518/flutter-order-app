import 'package:food_app/core/models/restaut.dart';
import 'core/services/google_sheet_service.dart';

class RestaurantRepository {
  Future<List<Restaut>> getAllRestaurants() async {
    final data = await GoogleSheetService.fetchRestaurants();
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