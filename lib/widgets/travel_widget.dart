import 'package:flutter/material.dart';

class TravelWidget extends StatelessWidget {
  final String travel;
  final String flagImage;
  const TravelWidget(
      {super.key, required this.travel, required this.flagImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      height: 137,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/$flagImage',
            width: 135,
            height: 96,
          ),
          Text(travel),
        ],
      ),
    );
  }
}
