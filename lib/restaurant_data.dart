import 'dart:convert';
import 'package:flutter/services.dart';
import 'core/models/restaut.dart';

Future<List<Restaut>> loadRestaurantsFromJson() async {
  final String jsonString = await rootBundle.loadString('assets/data/restaurants.json');
  final List<dynamic> jsonData = json.decode(jsonString);

  return jsonData.map((data) => Restaut.fromJson(data)).toList();
}

// maybe ce fichier ne sert plus a rien vu que je ramene les restau mn l api google sheet so 