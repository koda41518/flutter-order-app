import 'package:flutter/material.dart';
import '../core/models/order.dart';
import '../core/order_repository.dart';
import '../image_helper.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final OrderRepository _orderRepo = OrderRepository();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _orderRepo,
      builder: (context, _) {
        final inProgress = _orderRepo.inProgressOrders;
        final past = _orderRepo.pastOrders;

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
              _buildOrderList(inProgress),
              _buildOrderList(past),
            ],
          ),
        );
      },
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
            child: Image.asset(order.image, width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(order.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('${order.itemCount} item(s) • IDR ${order.price.toStringAsFixed(0)}'),
          trailing: order.date != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatDate(order.date!),
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