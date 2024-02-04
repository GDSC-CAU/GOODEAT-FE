import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/travel_lang_select_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/pages/native_lang_select_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            GetBuilder<MyCountryCurrencyController>(
              builder: (controller) => Row(
                children: [
                  Text(controller.myCounty),
                  Text(controller.myCurrency),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Get.to(
                  () => const NativeLanguageSelect(fromHomeScreen: true)),
              child: const Text('본인 언어/화폐 설정'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => const TravelLanguageSelectPage()),
              child: const Text('여행지 설정'),
            ),
          ],
        ),
      ),
    );
  }
}
