import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/cart_repository.dart';
import 'restaut_list_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    RestautListScreen(), // supprimé le const ici
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartRepository>();
    final hasNew = cart.count > 0 && _currentIndex != 1;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFFF002B),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_bag),
                if (hasNew)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints:
                          const BoxConstraints(minWidth: 12, minHeight: 12),
                      child: const Text('', style: TextStyle(fontSize: 8)),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}