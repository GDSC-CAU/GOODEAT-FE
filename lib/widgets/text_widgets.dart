import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarText extends Text {
  final String text;

  const AppBarText({
    Key? key,
    required this.text,
  }) : super(key: key, text, style: const TextStyle(fontSize: 16));
}

class HeadingText extends Text {
  final String text;

  HeadingText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style:
                GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w700));
}

class HeadingSmallText extends Text {
  final String text;

  HeadingSmallText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style:
                GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w700));
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

class BodyText extends Text {
  final String text;

  const BodyText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.normal));
}

class BodyHeavyText extends Text {
  final String text;

  const BodyHeavyText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600));
}

class BodySmallText extends Text {
  final String text;

  const BodySmallText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style:
                const TextStyle(fontSize: 19, fontWeight: FontWeight.normal));
}

class BodyHeavySmallText extends Text {
  final String text;

  const BodyHeavySmallText({
    Key? key,
    required this.text,
  }) : super(
            key: key,
            text,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600));
}
