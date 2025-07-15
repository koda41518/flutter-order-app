import 'package:connectivity_plus/connectivity_plus.dart';
import 'order_repository.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        print('📡 Connexion détectée → retry commandes');
        OrderRepository().retryPendingOrders();
      }
    });
  }
}