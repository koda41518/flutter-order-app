import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/models/order.dart';

class OrderRepository extends ChangeNotifier {
  static final OrderRepository _instance = OrderRepository._internal();
  factory OrderRepository() => _instance;
  OrderRepository._internal();

  final List<Order> _orders = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Order> get orders => List.unmodifiable(_orders);

  List<Order> get inProgressOrders =>
      _orders.where((o) => o.status == OrderStatus.inProgress).toList();

  List<Order> get pastOrders =>
      _orders.where((o) => o.status != OrderStatus.inProgress).toList();

  Future<void> add(Order order) async {
    _orders.add(order);
    notifyListeners();

    // Enregistrement dans Firestore
    await _firestore.collection('orders').add(order.toJson());
  }
}