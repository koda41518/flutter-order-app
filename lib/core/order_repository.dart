import 'package:flutter/foundation.dart';
import '../core/models/order.dart';

class OrderRepository extends ChangeNotifier {
  static final OrderRepository _instance = OrderRepository._internal();
  factory OrderRepository() => _instance;
  OrderRepository._internal();

  final List<Order> _orders = [];
  List<Order> get orders => List.unmodifiable(_orders);

  void add(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}Ò