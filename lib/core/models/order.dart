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

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'itemCount': itemCount,
        'price': price,
        'status': status.name,
        'date': date.toIso8601String(),
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        name: json['name'],
        image: json['image'],
        itemCount: json['itemCount'],
        price: (json['price'] as num).toDouble(),
        status: OrderStatus.values.firstWhere(
          (s) => s.name == json['status'],
          orElse: () => OrderStatus.inProgress,
        ),
        date: DateTime.parse(json['date']),
      );
}