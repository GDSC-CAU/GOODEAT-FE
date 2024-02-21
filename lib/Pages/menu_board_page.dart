import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/menu_info_page.dart';
import 'package:goodeat_frontend/Pages/order_list_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/services/lang_currency.dart';
import 'package:goodeat_frontend/style.dart';
import 'package:goodeat_frontend/widgets/layout_widget.dart';
import 'package:goodeat_frontend/widgets/menu_widget.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class MenuBoardPage extends StatefulWidget {
  final String base64EncodedImage;
  const MenuBoardPage({super.key, required this.base64EncodedImage});

  @override
  State<MenuBoardPage> createState() => _MenuBoardPageState();
}

class _MenuBoardPageState extends State<MenuBoardPage> {
  late Future<List<MenuModel>> menuList;
  late MyCountryCurrencyController myCountryCurrencyController;
  late TravelController travelController;

  @override
  void initState() {
    super.initState();
    myCountryCurrencyController = Get.put(MyCountryCurrencyController());
    travelController = Get.put(TravelController());
    menuList = ApiService.postPictureAndGetMenu(
        originLanguageName: travelController.travelLanguage,
        userLanguageName: myCountryCurrencyController.myCountry,
        originCurrencyName: travelController.travelCurrency,
        userCurrencyName: myCountryCurrencyController.myCurrency,
        base64EncodedImage: widget.base64EncodedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BodySemiText(text: 'Profile Setting'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home_filled)),
          IconButton(
              onPressed: () => Get.to(() => const OrderListPage()),
              icon: const Icon(Icons.shopping_cart_rounded)),
        ],
      ),
      body: MyPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingText(text: 'Menu List', color: AppColor.primary),
            FutureBuilder<List<MenuModel>>(
              future: menuList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  return Expanded(child: buildMenuGrid(snapshot.data!));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuGrid(List<MenuModel> menuList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: menuList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () => Get.to(MenuInfoPage(menu: menuList[index])),
            child: MenuWidget(menu: menuList[index]));
      },
    );
  }
}
