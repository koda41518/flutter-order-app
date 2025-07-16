import 'package:json_annotation/json_annotation.dart';

part 'restaut.g.dart';

@JsonSerializable()
class Restaut {
  final String name;
  final String image;
  final String description;
  final String price; // <-- ici on passe en String
  final double rating;

  Restaut({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
  });

  factory Restaut.fromJson(Map<String, dynamic> json) => _$RestautFromJson(json);
  Map<String, dynamic> toJson() => _$RestautToJson(this);
}