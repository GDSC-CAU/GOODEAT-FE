import 'package:flutter/material.dart';
import 'package:goodeat_frontend/style.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class SelectButtonWidget extends StatelessWidget {
  final String labelText;
  final Color textColor;
  final Color backgroundColor;

  const SelectButtonWidget(
      {super.key,
      required this.labelText,
      Color? textColor,
      Color? backgroundColor})
      : textColor = textColor ?? AppColor.white,
        backgroundColor = backgroundColor ?? AppColor.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColor.primary),
              borderRadius: BorderRadius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(text: labelText, color: textColor),
            const Icon(
              Icons.arrow_drop_down_circle,
              color: AppColor.secondary,
            ),
          ],
        ));
  }
}
