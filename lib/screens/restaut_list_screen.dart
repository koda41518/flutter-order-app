import 'package:flutter/material.dart';
import '../core/models/restaut.dart';
import 'restaut_detail_screen.dart';

class RestautListScreen extends StatelessWidget {
  RestautListScreen({super.key});

  final List<Restaut> restaurants = [
    Restaut(
      name: "Cherry Healthy",
      description: "Delicious healthy meals",
      imageUrl: "https://images.unsplash.com/photo-1600891964599-f61ba0e24092",
      rating: 4.5,
      price: 12.90,
    ),
    
    Restaut(
      name: "Burger Tama",
      description: "Big juicy burgers",
      imageUrl: "https://images.unsplash.com/photo-1550547660-d9450f859349",
      rating: 4.2,
      price: 9.50,
    ),
    Restaut(
      name: "Healthy Noodle",
      description: "Light and tasty noodles",
      imageUrl: "https://images.unsplash.com/photo-1586190848861-99aa4a171e90",
      rating: 4.8,
      price: 11.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurants")),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final resto = restaurants[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(resto.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(resto.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("⭐ ${resto.rating} • ${resto.price.toStringAsFixed(2)} €"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestautDetailScreen(resto: resto),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}