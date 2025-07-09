import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: const Color(0xFFFF002B),
      ),
      body: const Center(
        child: Text(
          'Cart is empty',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}