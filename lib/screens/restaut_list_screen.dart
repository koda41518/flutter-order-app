import 'package:flutter/material.dart';
import '../core/models/restaut.dart';
import '../restaurantRepository.dart';
import 'restaut_detail_screen.dart';

class RestautListScreen extends StatelessWidget {
  RestautListScreen({super.key});

  final List<Restaut> restaurants = RestaurantRepository().getAllRestaurants();

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