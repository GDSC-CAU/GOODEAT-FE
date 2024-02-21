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
      body: MyPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  BodySemiSmallText(text: 'Your passport to global flavors'),
                  const SizedBox(height: 20),
                  SvgPicture.asset('assets/images/logo.svg'),
                  const SizedBox(height: 20),
                  BodySemiText(text: 'Global food Order &'),
                  BodySemiText(text: 'Easy Assistance for Travelers'),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //카메라
                  GestureDetector(
                    onTap: () => getImage(),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 150,
                      decoration: ShapeDecoration(
                          color: AppColor.tertiary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Column(
                                children: [
                                  HeadingSmallText(
                                      text: 'Help food to order !'),
                                  Row(
                                    children: [
                                      HeadingSmallText(
                                          text: 'Have a great trip'),
                                      const Icon(Icons.camera_alt_sharp),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BodySemiSmallText(
                                      text: 'Change your trip destination'),
                                  const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: AppColor.primary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //여행 정보
                  GetBuilder<TravelController>(
                      builder: (travelController) => Column(
                            children: [
                              BodySmallText(text: 'Travel Language & Currency'),
                              BodySemiSmallText(
                                  text:
                                      '${travelController.travelLanguage} & ${travelController.travelCurrency}'),
                            ],
                          )),
                  //본인정보
                  GetBuilder<MyCountryCurrencyController>(
                      builder: (myController) => Column(
                            children: [
                              BodySmallText(text: 'My Profile'),
                              BodySemiSmallText(
                                  text:
                                      '${myController.myCountry} & ${myController.myCurrency}'),
                            ],
                          )),

                  GestureDetector(
                    onTap: () => Get.to(() =>
                        const TravelLanguageSelectPage(fromHomeScreen: true)),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 48,
                      decoration: ShapeDecoration(
                          color: AppColor.tertiary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.airplane_ticket_outlined,
                                color: AppColor.primary,
                              ),
                              const SizedBox(width: 10),
                              BodySemiText(
                                  text: 'Change your trip destination'),
                              const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: AppColor.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(
                        () => const NativeLanguageSelect(fromHomeScreen: true)),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 48,
                      decoration: ShapeDecoration(
                          color: AppColor.tertiary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              BodySemiText(text: 'Change your profile setting'),
                              const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: AppColor.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
