import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/menu_board_page.dart';
import 'package:goodeat_frontend/Pages/travel_lang_select_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
import 'package:goodeat_frontend/pages/native_lang_select_page.dart';
import 'package:goodeat_frontend/widgets/layout_widget.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MyCountryCurrencyController firstController =
      Get.put(MyCountryCurrencyController());
  final TravelController secondController = Get.put(TravelController());

  //image_picker
  final picker = ImagePicker();

  Future getImage() async {
    if (secondController.travelLanguage == 'null') {
      //아직 여행지 설정을 하지 않았다면
    } else {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        //사진을 찍었다면
        List<int> imageBytes = await photo.readAsBytes();
        String base64EncodedImage = base64Encode(imageBytes);
        Get.to(() => MenuBoardPage(base64EncodedImage: base64EncodedImage));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: MyPadding(
        child: Center(
          child: Column(
            children: [
              GetBuilder<MyCountryCurrencyController>(
                builder: (myController) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(myController.myCountry),
                    Text(myController.myCurrency),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GetBuilder<TravelController>(
                builder: (travelController) =>
                    Text(travelController.travelLanguage),
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
              IconButton(
                  onPressed: () => getImage(),
                  icon: const Icon(Icons.camera_alt_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
