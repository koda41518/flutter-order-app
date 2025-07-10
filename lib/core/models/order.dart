
enum OrderStatus { inProgress, completed, cancelled }

class Order {
  final String name;
  final String image;
  final int itemCount;
  final double price;
  final DateTime? date;
  final OrderStatus status;

  Order({
    required this.name,
    required this.image,
    required this.itemCount,
    required this.price,
    this.date,
    this.status = OrderStatus.inProgress,
  });
}