import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../order_repository.dart';
class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  void initialize() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        print('📡 Connexion détectée → retry commandes');
        bool sent = await OrderRepository().retryPendingOrders();
        if (sent && _context != null) {
          ScaffoldMessenger.of(_context!).showSnackBar(
            SnackBar(content: Text('✅ Commandes en attente envoyées')),
          );
        }
      }
    });
  }
}