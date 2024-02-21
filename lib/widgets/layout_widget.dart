import 'package:flutter/material.dart';

class MyPadding extends Padding {
  final double paddingValue;

  MyPadding({
    Key? key,
    required Widget child,
    this.paddingValue = 24,
  }) : super(
          key: key,
          padding: EdgeInsets.all(paddingValue),
          child: child,
        );
}
