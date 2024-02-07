import 'package:flutter/material.dart';

class AppBarText extends Text {
  final String text;

  const AppBarText({
    Key? key,
    required this.text,
  }) : super(key: key, text, style: const TextStyle(fontSize: 16));
}

class HeadingText extends Text {
  final String text;

  const HeadingText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold));
}
