import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/menu_info_page.dart';
import 'package:goodeat_frontend/Pages/order_list_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/controller/order_list_controller.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/services/lang_currency.dart';
import 'package:goodeat_frontend/widgets/bottom_button_widget.dart';
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
  OrderListController orderListController =
      Get.put(OrderListController(), permanent: true);

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
    Get.find<OrderListController>().initCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BodySemiText(text: 'Menu List'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/images/icons/left.svg')),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const OrderListPage()),
              icon: SvgPicture.asset('assets/images/icons/cart.svg')),
        ],
      ),
      body: BackGround(
        child: FutureBuilder<List<MenuModel>>(
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
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return MyPadding(
                  child:
                      Center(child: BodySemiText(text: 'No data available')));
            } else {
              return Column(
                children: [
                  Expanded(child: buildMenuGrid(snapshot.data!)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const OrderListPage());
                    },
                    child: const BottomButtonWidget(
                      labelText: 'Go to Cart',
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildMenuGrid(List<MenuModel> menuList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
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
