import 'package:flutter/material.dart';

Widget buildImage(
  String imageUrl, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  return imageUrl.startsWith('http')
      ? Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
        )
      : Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
        );
}