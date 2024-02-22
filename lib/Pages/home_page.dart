import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/menu_board_page.dart';
import 'package:goodeat_frontend/Pages/travel_lang_select_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
import 'package:goodeat_frontend/pages/native_lang_select_page.dart';
import 'package:goodeat_frontend/style.dart';
import 'package:goodeat_frontend/widgets/layout_widget.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';
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
      body: BackGround(
        child: MyPadding(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //로고
              SvgPicture.asset('assets/images/home/logo.svg'),

              //카메라
              IconButton(
                  onPressed: () => getImage(),
                  icon: SvgPicture.asset('assets/images/home/camera.svg')),

              // 여행지
              GestureDetector(
                onTap: () => Get.to(
                    () => const TravelLanguageSelectPage(fromHomeScreen: true)),
                child: Container(
                  width: 285,
                  color: AppColor.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Where to?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.primary,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                              letterSpacing: -0.28,
                            ),
                          ),
                          const SizedBox(height: 15),
                          //여행 정보
                          GetBuilder<TravelController>(
                              builder: (travelController) => BodySemiSmallText(
                                  text:
                                      '${travelController.travelLanguage} · ${travelController.travelCurrency}')),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '🌍 Change your trip destination >',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                            letterSpacing: -0.28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 유저 프로필
              GestureDetector(
                onTap: () => Get.to(
                    () => const NativeLanguageSelect(fromHomeScreen: true)),
                child: Container(
                  width: 285,
                  color: AppColor.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'My Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.primary,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                              letterSpacing: -0.28,
                            ),
                          ),
                          const SizedBox(height: 15),
                          //여행 정보
                          GetBuilder<MyCountryCurrencyController>(
                              builder: (travelController) => BodySemiSmallText(
                                  text:
                                      '${travelController.myCountry} · ${travelController.myCurrency}')),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '👤 Change your profile setting >',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                            letterSpacing: -0.28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //로고
              SvgPicture.asset('assets/images/home/bottom.svg')
            ],
          ),
        ),
      ),
    );
  }
}
