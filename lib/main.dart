import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/cart_repository.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartRepository(),
      child: const FoodMarketApp(),
    ),
  );
}

class FoodMarketApp extends StatelessWidget {
  const FoodMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodMarket',
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      routes: {
        '/sign-in': (context) => const SignInScreen(),
        '/sign-up': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}