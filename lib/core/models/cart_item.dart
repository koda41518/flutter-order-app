import 'restaut.dart';

class CartItem {
  final Restaut resto;
  final int quantity;

  CartItem({required this.resto, this.quantity = 1});

  CartItem copyWith({Restaut? resto, int? quantity}) {
    return CartItem(
      resto: resto ?? this.resto,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
        'resto': resto.toJson(),
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        resto: Restaut.fromJson(json['resto']),
        quantity: json['quantity'] ?? 1,
      );
}