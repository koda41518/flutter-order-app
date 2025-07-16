import 'package:flutter/material.dart';
import '../core/models/restaut.dart';
import '../restaurantRepository.dart';
import 'restaut_detail_screen.dart';
import '../image_helper.dart';

class RestautListScreen extends StatefulWidget {
  const RestautListScreen({super.key});

  @override
  State<RestautListScreen> createState() => _RestautListScreenState();
}

class _RestautListScreenState extends State<RestautListScreen> {
  final RestaurantRepository _repo = RestaurantRepository();
  late Future<void> _initFetch;

  @override
  void initState() {
    super.initState();
    _initFetch = _repo.fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurants")),
      body: FutureBuilder(
        future: _initFetch,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (_repo.restaurants.isEmpty) {
            return const Center(child: Text('Aucun restaurant trouvé.'));
          }

          return ListView.builder(
            itemCount: _repo.restaurants.length,
            itemBuilder: (context, index) {
              final resto = _repo.restaurants[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: buildImage(resto.imageUrl, width: 60, height: 60),
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
          );
        },
      ),
    );
  }
}Ò