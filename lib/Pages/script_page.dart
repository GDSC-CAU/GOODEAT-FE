import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/home_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/controller/order_list_controller.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
import 'package:goodeat_frontend/models/order_menu_model.dart';
import 'package:goodeat_frontend/models/script_model.dart';
import 'package:goodeat_frontend/services/lang_currency.dart';
import 'package:goodeat_frontend/widgets/bottom_button_widget.dart';
import 'package:goodeat_frontend/widgets/layout_widget.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class ScriptPage extends StatefulWidget {
  const ScriptPage({super.key});

  @override
  State<ScriptPage> createState() => _ScriptPageState();
}

class _ScriptPageState extends State<ScriptPage> {
  List<OrderMenuModel> orderMenuList =
      Get.find<OrderListController>().orderList;
  String originLanguageName = Get.find<TravelController>().travelLanguage;
  String userLanguageName = Get.find<MyCountryCurrencyController>().myCountry;
  late Future<ScriptModel> script;

  @override
  void initState() {
    super.initState();
    script = ApiService.postMenuListAndGetScript(
        orderMenuList = orderMenuList,
        originLanguageName = originLanguageName,
        userLanguageName = userLanguageName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BodySemiText(text: 'Order Script'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            icon: SvgPicture.asset('assets/images/icons/left.svg')),
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const HomePage()),
              icon: SvgPicture.asset('assets/images/icons/home.svg'))
        ],
      ),
      body: BackGround(
        child: FutureBuilder<ScriptModel>(
          future: script,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Column(
                children: [
                  HeadingText(text: 'Loading Script'),
                  BodyText(text: 'Please wait a moment.'),
                  const SizedBox(height: 20),
                  SvgPicture.asset('assets/images/icons/loadingmenu.svg'),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ],
              ));
            } else if (snapshot.hasError) {
              return MyPadding(
                  child: Center(
                      child: BodySemiText(text: 'Error: ${snapshot.error}')));
            } else if (!snapshot.hasData) {
              return MyPadding(
                  child:
                      Center(child: BodySemiText(text: 'No data available')));
            } else {
              return MyPadding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: SingleChildScrollView(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationZ(3.141592),
                            child: Column(
                              children: [
                                Container(height: 20),
                                BodyText(text: snapshot.data!.originScript),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationZ(3.1415926535),
                            child: HeadingSmallText(text: 'Transition Script')),
                        const Divider(),
                        HeadingSmallText(text: 'My Language Script'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: BodyText(text: snapshot.data!.userScript),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                        onTap: () => Get.offAll(() => const HomePage()),
                        child:
                            const BottomButtonWidget(labelText: 'Good Eat!')),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
