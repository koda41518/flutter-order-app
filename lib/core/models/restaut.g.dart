// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaut.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaut _$RestautFromJson(Map<String, dynamic> json) => Restaut(
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  rating: (json['rating'] as num).toDouble(),
);

Map<String, dynamic> _$RestautToJson(Restaut instance) => <String, dynamic>{
  'name': instance.name,
  'imageUrl': instance.imageUrl,
  'description': instance.description,
  'price': instance.price,
  'rating': instance.rating,
};
