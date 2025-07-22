import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget buildImage(
  String imageUrl, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  return imageUrl.startsWith('http')
      ? CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
          errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
        )
      : Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
        );
}