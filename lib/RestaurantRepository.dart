import '../models/restaut.dart';
import 'restaurant_data.dart';

class RestaurantRepository {
  List<Restaut> getAllRestaurants() {
    return allRestaurants;
  }

  Restaut? getByName(String name) {
    return allRestaurants.firstWhere((r) => r.name == name, orElse: () => null as Restaut);
  }
}
