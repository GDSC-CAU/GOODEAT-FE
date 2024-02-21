import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
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
    TravelModel(
        travel: 'Vietnam',
        flagImage: 'Vietnam.png',
        travelLanguage: 'Vietnamese',
        travelCurrency: 'Vietnamese dong'),
    TravelModel(
        travel: 'Korea',
        flagImage: 'Korea.png',
        travelLanguage: 'Korean',
        travelCurrency: 'South Korean won'),
  ];

  //컨트롤러
  final controller = Get.put(TravelController());
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  ListView makeTravelList(List<TravelModel> travelList) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: travelList.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: TravelWidget(
            travel: travelList[index].travel,
            flagImage: travelList[index].flagImage,
          ),
          onTap: () async {
            //기기 DB에 저장
            await secureStorage.write(
                key: 'travel', value: travelList[index].travel);
            await secureStorage.write(
                key: 'travelLanguage', value: travelList[index].travelLanguage);
            await secureStorage.write(
                key: 'travelCurrency', value: travelList[index].travelCurrency);

            controller.modify(
                travelList[index].travel,
                travelList[index].travelLanguage,
                travelList[index].travelCurrency);
            Get.back();
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }

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
            HeadingText(text: 'Where to visit?'),
            const Text('Click a image below that you are planning to visit'),
            Expanded(child: makeTravelList(travelList)),
          ],
        ),
      ),
    );
  }
}
