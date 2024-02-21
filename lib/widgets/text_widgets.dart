import 'package:flutter/material.dart';
import 'package:goodeat_frontend/style.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingText extends Text {
  final String text;
  final Color color;

  HeadingText({Key? key, required this.text, Color? color})
      : color = color ?? AppColor.primary,
        super(
          key: key,
          text,
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        );
}

class HeadingSmallText extends Text {
  final String text;
  final Color color;

  HeadingSmallText({Key? key, required this.text, Color? color})
      : color = color ?? AppColor.primary,
        super(
            key: key,
            text,
            style: GoogleFonts.inter(
                fontSize: 24, fontWeight: FontWeight.w700, color: color));
}

class BodyText extends Text {
  final String text;
  final Color color;

  BodyText({Key? key, required this.text, Color? color})
      : color = color ?? AppColor.primary,
        super(
            key: key,
            text,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.normal, color: color));
}

class BodySemiText extends Text {
  final String text;
  final Color color;
  BodySemiText({Key? key, required this.text, Color? color})
      : color = color ?? AppColor.primary,
        super(
            key: key,
            text,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: color));
}

class BodySmallText extends Text {
  final String text;
  final Color color;
  BodySmallText({Key? key, required this.text, Color? color})
      : color = color ?? AppColor.primary,
        super(
            key: key,
            text,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.normal, color: color));
}

class BodySemiSmallText extends Text {
  final String text;
  final Color color;
  BodySemiSmallText({Key? key, required this.text, Color? color})
      : color = color ?? AppColor.primary,
        super(
            key: key,
            text,
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w600, color: color));
}
