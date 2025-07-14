import 'package:json_annotation/json_annotation.dart';

part 'restaut.g.dart';

@JsonSerializable()
class Restaut {
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final double rating;

  Restaut({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
  });

  factory Restaut.fromJson(Map<String, dynamic> json) => _$RestautFromJson(json);
  Map<String, dynamic> toJson() => _$RestautToJson(this);
}