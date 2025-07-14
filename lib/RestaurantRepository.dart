import 'core/models/restaut.dart';
import 'restaurant_data.dart';

class RestaurantRepository {
  List<Restaut> getAllRestaurants() {
    return allRestaurants;
  }

  Restaut? getByName(String name) {
    try {
      return allRestaurants.firstWhere((r) => r.name == name);
    } catch (_) {
      return null;
    }
  }
}
