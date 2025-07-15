import 'dart:convert';
import 'package:flutter/services.dart';
import 'core/models/restaut.dart';
import 'core/services/api_service.dart';



Future<List<Restaut>> loadRestaurants() async {
  try {
    // Essayer l’API
    final data = await ApiService.getRestaurants();
    return data.map((json) => Restaut.fromJson(json)).toList();
  } catch (e) {
    print('⚠️ Erreur API, fallback sur JSON local : $e');

    // Si erreur → lecture du fichier local
    final String jsonString = await rootBundle.loadString('assets/data/restaurants.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((data) => Restaut.fromJson(data)).toList();
  }
}