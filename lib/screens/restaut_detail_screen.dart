import 'package:flutter/material.dart';
import '../core/models/restaut.dart';

class RestautDetailScreen extends StatelessWidget {
  final Restaut resto;

  const RestautDetailScreen({super.key, required this.resto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(resto.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(resto.imageUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(resto.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("⭐ ${resto.rating}", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Text(resto.description),
            const SizedBox(height: 12),
            Text("Price: ${resto.price.toStringAsFixed(2)} €", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to order/payment screen
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF002B)),
                child: const Text("Order Now"),
              ),
            )
          ],
        ),
      ),
    );
  }
}