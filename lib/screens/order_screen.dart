import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<Order> _orders = [
    Order(name: 'Avosalado', image: 'https://via.placeholder.com/50', itemCount: 3, price: 18000000),
    Order(name: 'Kopi Kudda', image: 'https://via.placeholder.com/50', itemCount: 10, price: 450000),
    Order(name: 'Es Tong-Tong', image: 'https://via.placeholder.com/50', itemCount: 2, price: 900500),
    Order(name: 'Bwang Puttie', image: 'https://via.placeholder.com/50', itemCount: 10, price: 450000),
    Order(name: 'Kari Sleman', image: 'https://via.placeholder.com/50', itemCount: 1, price: 289000, status: OrderStatus.completed, date: DateTime(2024, 6, 12, 14, 0)),
    Order(name: 'Avosalado', image: 'https://via.placeholder.com/50', itemCount: 1, price: 6000000, status: OrderStatus.cancelled, date: DateTime(2024, 5, 2, 9, 0)),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  List<Order> get inProgressOrders =>
      _orders.where((order) => order.status == OrderStatus.inProgress).toList();

  List<Order> get pastOrders =>
      _orders.where((order) => order.status != OrderStatus.inProgress).toList();

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
      itemBuilder: (context, index) {
        final order = orders[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(order.image, width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(order.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('${order.itemCount} item(s) • IDR ${order.price.toStringAsFixed(0)}'),
          trailing: order.date != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_formatDate(order.date!)}',
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    if (order.status == OrderStatus.cancelled)
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

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = _monthName(date.month);
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$month $day, $hour:$minute';
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
