import 'models/cart_item.dart';
import 'models/restaut.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class CartRepository extends ChangeNotifier {
  static final CartRepository _instance = CartRepository._internal();
  factory CartRepository() => _instance;
  CartRepository._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  // Ajoute un plat au panier (en incrémentant la quantité si déjà présent)
  void add(Restaut resto) {
    final index = _items.indexWhere((item) => item.resto.name == resto.name);

    if (index != -1) {
      final existing = _items[index];
      _items[index] = CartItem(
        resto: existing.resto,
        quantity: existing.quantity + 1,
      );
    } else {
      _items.add(CartItem(resto: resto));
    }
    notifyListeners();
  }

  // Supprime un plat du panier
  void remove(Restaut resto) {
    final index = _items.indexWhere((item) => item.resto.name == resto.name);
    if (index != -1) {
      final existing = _items[index];
      if (existing.quantity > 1) {
        _items[index] = CartItem(
          resto: existing.resto,
          quantity: existing.quantity - 1,
        );
      } else {
        _items.removeAt(index);
      }
    }
    notifyListeners();
  }

  // Vide complètement le panier
  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Retourne le nombre total d'éléments dans le panier
  int get count => _items.fold(0, (total, item) => total + item.quantity);

  // 💸 Nouveau getter ajouté ici :
  double get totalPrice => _items.fold(
    0.0, (total, item) => total + item.quantity * item.resto.price);
}