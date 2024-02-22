import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodeat_frontend/style.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class BottomButtonWidget extends StatelessWidget {
  final String labelText;
  final Color textColor;
  final Color backgroundColor;

  const BottomButtonWidget(
      {super.key,
      required this.labelText,
      Color? textColor,
      Color? backgroundColor,
      SvgPicture? icon})
      : textColor = textColor ?? AppColor.white,
        backgroundColor = backgroundColor ?? AppColor.point;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Center(
            child: BodySemiSmallText(text: labelText, color: textColor)));
  }
}

class BottomSmallButtonWidget extends StatelessWidget {
  final String labelText;
  final Color textColor;
  final Color backgroundColor;

  const BottomSmallButtonWidget(
      {super.key,
      required this.labelText,
      Color? textColor,
      Color? backgroundColor,
      SvgPicture? icon})
      : textColor = textColor ?? AppColor.white,
        backgroundColor = backgroundColor ?? AppColor.point;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Center(
            child: BodySemiSmallText(text: labelText, color: textColor)));
  }
}
