import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFFFF002B),
      ),
      body: const Center(
        child: Text(
          'User Profile',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}