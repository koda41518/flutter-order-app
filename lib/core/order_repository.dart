import 'package:flutter/foundation.dart';
import '../core/models/order.dart';
import '../core/services/api_service.dart';

class OrderRepository extends ChangeNotifier {
  static final OrderRepository _instance = OrderRepository._internal();
  factory OrderRepository() => _instance;
  OrderRepository._internal();

  final List<Order> _orders = [];
  final List<Order> _pendingOrders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  List<Order> get inProgressOrders =>
      _orders.where((o) => o.status == OrderStatus.inProgress).toList();

  List<Order> get pastOrders =>
      _orders.where((o) => o.status != OrderStatus.inProgress).toList();

  List<Order> get pendingOrders => List.unmodifiable(_pendingOrders);

  Future<void> add(Order order) async {
    _orders.add(order);
    notifyListeners();

    try {
      await ApiService.postOrder(order.toJson());
      print('✅ Commande envoyée à l’API');
    } catch (e) {
      print('⚠️ API DOWN, commande mise en attente : $e');
      _pendingOrders.add(order);
    }
  }

  Future<bool> retryPendingOrders() async {
    final List<Order> sent = [];

    for (final order in _pendingOrders) {
      try {
        await ApiService.postOrder(order.toJson());
        print('🔁 Commande en attente envoyée : ${order.name}');
        sent.add(order);
      } catch (e) {
        print('❌ Envoi échoué pour ${order.name}');
      }
    }

    _pendingOrders.removeWhere((order) => sent.contains(order));
    return sent.isNotEmpty;
  }
  Future<void> fetchOrdersFromApi() async {
  try {
    final data = await ApiService.getOrders();
    final ordersFromApi = data.map((json) => Order.fromJson(json)).toList();

    _orders.clear();
    _orders.addAll(ordersFromApi);
    notifyListeners();
  } catch (e) {
    print('❌ Erreur chargement commandes API : $e');
  }
}
}