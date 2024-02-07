import 'package:flutter/material.dart';
import 'package:goodeat_frontend/models/travel_model.dart';
import 'package:goodeat_frontend/widgets/layout_widget.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';
import 'package:goodeat_frontend/widgets/travel_widget.dart';

class TravelLanguageSelectPage extends StatefulWidget {
  const TravelLanguageSelectPage({super.key});

  @override
  State<TravelLanguageSelectPage> createState() =>
      _TravelLanguageSelectPageState();
}

class _TravelLanguageSelectPageState extends State<TravelLanguageSelectPage> {
  final List<TravelModel> travelList = [
    TravelModel(travel: 'Vietnam', flagImage: 'Vietnam.png'),
    TravelModel(travel: 'Korea', flagImage: 'Korea.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Place to Visit'),
      ),
      body: MyPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadingText(text: 'Where to visit?'),
            const Text('Click a image below that you are planning to visit'),
            Expanded(child: makeTravelList(travelList)),
          ],
        ),
      ),
    );
  }
}

ListView makeTravelList(List<TravelModel> travelList) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: travelList.length,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
    itemBuilder: (context, index) {
      return TravelWidget(
        travel: travelList[index].travel,
        flagImage: travelList[index].flagImage,
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 40),
  );
}
