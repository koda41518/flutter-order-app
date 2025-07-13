import 'package:flutter/material.dart';
import '../core/models/order.dart';

class TrackingScreen extends StatefulWidget {
  final Order order;
  const TrackingScreen({ super.key, required this.order });

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late OrderStatus status;

  @override
  void initState(){
    super.initState();
    status = widget.order.status;
    _simulateProgress();
  }

  Future<void> _simulateProgress() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() => status = OrderStatus.completed);
  }

  @override
  Widget build(BuildContext context){
    String text;
    IconData icon;
    switch (status) {
      case OrderStatus.inProgress:
        text = 'Préparation en cours…';
        icon = Icons.kitchen;
        break;
      case OrderStatus.completed:
        text = 'Commande en route !';
        icon = Icons.delivery_dining;
        break;
      case OrderStatus.cancelled:
        text = 'Commande annulée';
        icon = Icons.cancel;
        break;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Suivi de commande')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text(text, style: const TextStyle(fontSize: 24)),
        ]),
      ),
    );
  }
}