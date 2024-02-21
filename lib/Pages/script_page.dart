import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/home_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/controller/order_list_controller.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
import 'package:goodeat_frontend/models/order_menu_model.dart';
import 'package:goodeat_frontend/models/script_model.dart';
import 'package:goodeat_frontend/services/lang_currency.dart';
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
        title: const AppBarText(text: 'Order Script'),
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const HomePage()),
              icon: const Icon(Icons.home)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<ScriptModel>(
            future: script,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No data available');
              } else {
                return Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(3.14),
                        child: Container(
                          color: Colors.grey,
                          child: Container(
                            margin: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingSmallText(text: 'Transition Script'),
                                const SizedBox(height: 20),
                                BodyText(text: snapshot.data!.originScript),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AspectRatio(
                      aspectRatio: 2,
                      child: Container(
                        margin: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingSmallText(text: 'My Language Script'),
                            const SizedBox(height: 20),
                            BodyText(text: snapshot.data!.originScript),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
