import 'package:equatable/equatable.dart';
import '../../models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState(this.items);

  double get totalPrice =>
      items.fold(0.0, (t, i) => t + i.quantity * i.resto.price);

  int get totalItems => items.fold(0, (t, i) => t + i.quantity);

  @override
  List<Object> get props => [items];
}