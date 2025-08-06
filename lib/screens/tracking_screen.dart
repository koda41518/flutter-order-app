import 'package:flutter/material.dart';
import '../core/models/order.dart';

class TrackingScreen extends StatefulWidget {
  final Order order;
  const TrackingScreen({super.key, required this.order});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late OrderStatus status;

  @override
  void initState() {
    super.initState();
    status = widget.order.status;
    _simulateProgress();
  }

  Future<void> _simulateProgress() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() => status = OrderStatus.completed);
  }

  @override
  Widget build(BuildContext context) {
    String text;
    Widget content;

    switch (status) {
      case OrderStatus.inProgress:
        text = 'Préparation en cours…';
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/success_order.png', width: 120),
            const SizedBox(height: 16),
            Text(text, style: const TextStyle(fontSize: 24)),
          ],
        );
        break;
      case OrderStatus.completed:
        text = 'Commande en route !';
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/delivery_in_progress.png', width: 120),
            const SizedBox(height: 16),
            Text(text, style: const TextStyle(fontSize: 24)),
          ],
        );
        break;
      case OrderStatus.cancelled:
        text = 'Commande annulée';
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cancel, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(text, style: const TextStyle(fontSize: 24)),
          ],
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Suivi de commande')),
      body: Center(child: content),
    );
  }
}