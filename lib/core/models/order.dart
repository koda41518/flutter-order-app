enum OrderStatus {
  inProgress,
  completed,
  cancelled,
}

class Order {
  final String name;
  final String image;
  final int itemCount;
  final double price;
  final OrderStatus status;
  final DateTime date;

  Order({
    required this.name,
    required this.image,
    required this.itemCount,
    required this.price,
    this.status = OrderStatus.inProgress,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}