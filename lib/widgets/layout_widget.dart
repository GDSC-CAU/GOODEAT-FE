import 'package:flutter/material.dart';
import 'package:goodeat_frontend/style.dart';

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

class BackGround extends Container {
  BackGround({
    Key? key,
    required Widget child,
  }) : super(
            key: key,
            child: child,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColor.white, AppColor.background])));
}
