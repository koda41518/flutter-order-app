import 'package:flutter/material.dart';
import '../core/models/order.dart';
import '../core/models/order.dart'; // 🔁 Vérifie bien le chemin

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<Order> _orders = [
    Order(
      name: 'Avosalado',
      image: 'https://via.placeholder.com/50',
      itemCount: 3,
      price: 18000000,
    ),
    Order(
      name: 'Kopi Kudda',
      image: 'https://via.placeholder.com/50',
      itemCount: 10,
      price: 450000,
    ),
    Order(
      name: 'Es Tong-Tong',
      image: 'https://via.placeholder.com/50',
      itemCount: 2,
      price: 900500,
    ),
    Order(
      name: 'Bwang Puttie',
      image: 'https://via.placeholder.com/50',
      itemCount: 10,
      price: 450000,
    ),
    Order(
      name: 'Kari Sleman',
      image: 'https://via.placeholder.com/50',
      itemCount: 1,
      price: 289000,
      status: OrderStatus.completed,
      date: DateTime(2024, 6, 12, 14, 0),
    ),
    Order(
      name: 'Avosalado',
      image: 'https://via.placeholder.com/50',
      itemCount: 1,
      price: 6000000,
      status: OrderStatus.cancelled,
      date: DateTime(2024, 5, 2, 9, 0),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  List<Order> get inProgressOrders =>
      _orders.where((o) => o.status == OrderStatus.inProgress).toList();

  List<Order> get pastOrders =>
      _orders.where((o) => o.status != OrderStatus.inProgress).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: const Color(0xFFFF002B),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'In Progress'),
            Tab(text: 'Past Orders'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(inProgressOrders),
          _buildOrderList(pastOrders),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    if (orders.isEmpty) {
      return const Center(child: Text('No orders here.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      itemBuilder: (context, i) {
        final o = orders[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(o.image, width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(o.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('${o.itemCount} item(s) • IDR ${o.price.toStringAsFixed(0)}'),
          trailing: o.date != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatDate(o.date!),
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    if (o.status == OrderStatus.cancelled)
                      const Text(
                        'Cancelled',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                  ],
                )
              : null,
        );
      },
    );
  }

  String _formatDate(DateTime d) {
    final day = d.day.toString().padLeft(2, '0');
    final month = _monthNames[d.month - 1];
    final hour = d.hour.toString().padLeft(2, '0');
    final minute = d.minute.toString().padLeft(2, '0');
    return '$month $day, $hour:$minute';
  }

  static const List<String> _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
}