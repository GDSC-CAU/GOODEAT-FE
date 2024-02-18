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

class TitleText extends Text {
  final String text;

  const TitleText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
}

class CaptionText extends Text {
  final String text;

  const CaptionText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.normal));
}

class MainText extends Text {
  final String text;

  const MainText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.normal));
}
