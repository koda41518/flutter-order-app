import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const FoodMarketApp());
}

class FoodMarketApp extends StatelessWidget {
  const FoodMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodMarket',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // ⬅️ point d'entrée visuel
    );
  }
}