import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../core/models/restaut.dart';
import '../core/services/api_service.dart';

class RestaurantRepository extends ChangeNotifier {
  List<Restaut> _restos = [];
  StreamSubscription<ConnectivityResult>? _sub;

  List<Restaut> get restos => _restos;

  RestaurantRepository() {
    _init();
  }

  Future<void> _init() async {
    await fetchAll();
    _sub = Connectivity().onConnectivityChanged.listen((status) {
      if (status != ConnectivityResult.none) {
        fetchAll();
      }
    });
  }

  Future<void> fetchAll() async {
    try {
      final data = await ApiService.getRestaurants();
      _restos = data.map((e) => Restaut.fromJson(e)).toList();
      notifyListeners();
    } catch (_) {
      // Gérer l'erreur si besoin
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}