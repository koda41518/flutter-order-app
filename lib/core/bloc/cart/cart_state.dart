import 'package:equatable/equatable.dart';
import '../../models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final bool orderSuccess;

  const CartState(this.items, {this.orderSuccess = false});

  double get totalPrice =>
      items.fold(0.0, (t, i) => t + i.quantity * i.resto.price);

  int get totalItems => items.fold(0, (t, i) => t + i.quantity);

  CartState copyWith({List<CartItem>? items, bool? orderSuccess}) {
    return CartState(
      items ?? this.items,
      orderSuccess: orderSuccess ?? this.orderSuccess,
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
        'orderSuccess': orderSuccess,
      };

  factory CartState.fromJson(Map<String, dynamic> json) {
    return CartState(
      (json['items'] as List).map((e) => CartItem.fromJson(e)).toList(),
      orderSuccess: json['orderSuccess'] ?? false,
    );
  }

  @override
  List<Object> get props => [items, orderSuccess];
}