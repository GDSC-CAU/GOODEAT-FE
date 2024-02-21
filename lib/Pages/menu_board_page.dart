import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/menu_info_page.dart';
import 'package:goodeat_frontend/Pages/order_list_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/services/lang_currency.dart';
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
        title: BodySemiText(text: 'Menu List'),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/images/icons/left.svg')),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const OrderListPage()),
              icon: SvgPicture.asset('assets/images/icons/cart.svg')),
        ],
      ),
      body: FutureBuilder<List<MenuModel>>(
        future: menuList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeadingText(text: 'Loading Menu'),
                BodyText(text: 'Reconfiguring menu by OCR analyzing.'),
                BodyText(text: 'Please wait a moment.'),
                SvgPicture.asset('assets/images/icons/loadingmenu.svg'),
                const CircularProgressIndicator(),
              ],
            ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data available');
          } else {
            return MyPadding(child: buildMenuGrid(snapshot.data!));
          }
        },
      ),
    );
  }

  Widget buildMenuGrid(List<MenuModel> menuList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 5,
        childAspectRatio: 1 / 2,
      ),
      itemCount: menuList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () => Get.to(() => MenuInfoPage(menu: menuList[index])),
            child: MenuWidget(menu: menuList[index]));
      },
    );
  }
}
