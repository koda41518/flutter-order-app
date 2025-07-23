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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'itemCount': itemCount,
      'price': price,
      'status': status.name,
      'date': date.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      itemCount: (map['itemCount'] as num).toInt(),
      price: (map['price'] as num).toDouble(),
      status: OrderStatus.values.firstWhere((s) => s.name == map['status']),
      date: DateTime.parse(map['date']),
    );
  }
}