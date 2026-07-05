import 'package:flutter/material.dart';

Widget avatarPlaceholder() {
  return Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.person, color: Colors.grey, size: 24),
  );
}
