import 'package:flutter/material.dart';
import 'package:goodeat_frontend/style.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class ButtomButtonWidget extends StatelessWidget {
  final String labelText;
  final Color textColor;
  final Color backgroundColor;

  const ButtomButtonWidget(
      {super.key,
      required this.labelText,
      Color? textColor,
      Color? backgroundColor})
      : textColor = textColor ?? AppColor.white,
        backgroundColor = backgroundColor ?? AppColor.primary;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Center(
              child: BodySemiSmallText(text: labelText, color: textColor))),
    );
  }
}
