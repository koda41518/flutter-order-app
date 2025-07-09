import 'core/models/cart_item.dart';

class CartRepository {
  static final CartRepository _instance = CartRepository._internal();
  factory CartRepository() => _instance;

  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  void add(Restaut resto) {
    _items.add(CartItem(resto: resto));
  }

  int get count => _items.length;
}
