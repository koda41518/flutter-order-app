import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/cart_repository.dart';
import '../core/models/restaut.dart';
import '../core/models/order.dart';
import '../core/models/cart_item.dart';
import 'tracking_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _increment(BuildContext context, Restaut resto) {
    context.read<CartRepository>().add(resto);
  }

  void _decrement(BuildContext context, Restaut resto) {
    context.read<CartRepository>().remove(resto);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartRepository>();
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: const Color(0xFFFF002B),
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/empty_order.png', width: 200),
                  const SizedBox(height: 24),
                  const Text('Your cart is empty!', style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Image.network(
                    item.resto.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                  ),
                  title: Text(item.resto.name),
                  subtitle: Text('${item.resto.price.toStringAsFixed(2)} €'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _decrement(context, item.resto),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
                      IconButton(
                        onPressed: () => _increment(context, item.resto),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: items.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () => _openCheckoutModal(context, items),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF002B),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Checkout', style: TextStyle(fontSize: 18)),
              ),
            )
          : null,
    );
  }

  void _openCheckoutModal(BuildContext context, List<CartItem> items) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        String? paymentMethod;
        String address = '';

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Mode de paiement', style: TextStyle(fontSize: 18)),
                  RadioListTile<String>(
                    title: const Text('Carte'),
                    value: 'card',
                    groupValue: paymentMethod,
                    onChanged: (v) => setState(() => paymentMethod = v),
                  ),
                  RadioListTile<String>(
                    title: const Text('Espèces à la livraison'),
                    value: 'cash',
                    groupValue: paymentMethod,
                    onChanged: (v) => setState(() => paymentMethod = v),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Adresse ou point de rendez-vous',
                    ),
                    onChanged: (v) => address = v.trim(),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: (paymentMethod != null)
                        ? () {
                            final newOrder = Order(
                              name: items.first.resto.name,
                              image: _mapToAssetImage(items.first.resto.name),
                              itemCount: items.fold(0, (t, i) => t + i.quantity),
                              price: items.fold(0.0, (t, i) => t + i.quantity * i.resto.price),
                              date: DateTime.now(),
                              status: OrderStatus.inProgress,
                            );
                            Navigator.pop(ctx);
                            context.read<CartRepository>().clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TrackingScreen(order: newOrder),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF002B),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Valider la commande', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _mapToAssetImage(String name) {
    final normalized = name.toLowerCase();
    if (normalized.contains('burger')) return 'assets/images/Burger Tama.png';
    if (normalized.contains('cherry')) return 'assets/images/Cherry Healthy.png';
    if (normalized.contains('sushi')) return 'assets/images/sushi.png';
    if (normalized.contains('pizza')) return 'assets/images/pizza.png';
    if (normalized.contains('tacos')) return 'assets/images/tacos.png';
    if (normalized.contains('noodle')) return 'assets/images/Healthy Noodle.png';
    return 'assets/images/logo.png';
  }
}