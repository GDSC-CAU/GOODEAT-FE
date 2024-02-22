import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/script_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/controller/order_list_controller.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/models/order_menu_model.dart';
import 'package:goodeat_frontend/models/total_price_model.dart';
import 'package:goodeat_frontend/services/lang_currency.dart';
import 'package:goodeat_frontend/style.dart';
import 'package:goodeat_frontend/widgets/bottom_button_widget.dart';
import 'package:goodeat_frontend/widgets/layout_widget.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  Future<TotalPriceModel> getPrice() async {
    List<OrderMenuModel> orderMenuList =
        Get.find<OrderListController>().orderList;
    String originLanguageName =
        Get.find<MyCountryCurrencyController>().myCurrency;
    String userLanguageName = Get.find<TravelController>().travelCurrency;
    TotalPriceModel price = await ApiService.postOrderAndGetRecipt(
        orderMenuList, originLanguageName, userLanguageName);
    return price;
  }

  void showAmountDue(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => FutureBuilder(
        future: getPrice(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeadingText(text: 'Loading Amount Due'),
                BodyText(text: 'Please wait a moment.'),
                const CircularProgressIndicator(),
              ],
            ));
          } else if (snapshot.hasError) {
            return MyPadding(
                child: Center(
                    child: BodySemiText(text: 'Error: ${snapshot.error}')));
          } else if (!snapshot.hasData) {
            return MyPadding(
                child: Center(child: BodySemiText(text: 'No data available')));
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //메인
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodySemiText(text: 'Total'),
                        const Divider(),
                        //가격
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodySemiSmallText(text: 'Price'),
                            BodySemiSmallText(
                                text: snapshot
                                    .data!.totalPriceWithUserCurrencyUnit)
                          ],
                        ),
                        const SizedBox(height: 15),
                        //로컬

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodySemiSmallText(text: 'Local Price'),
                            BodySemiSmallText(
                                text: snapshot
                                    .data!.totalPriceWithOriginCurrencyUnit)
                          ],
                        ),
                      ],
                    ),
                  ),

                  //버튼들
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const BottomSmallButtonWidget(
                          labelText: 'Cancle',
                          textColor: AppColor.primary,
                          backgroundColor: AppColor.tertiary,
                        ),
                      ),
                      GestureDetector(
                          onTap: () => Get.to(() => const ScriptPage()),
                          child: const BottomSmallButtonWidget(
                              labelText: 'Order')),
                    ],
                  ),
                ]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BodySemiText(text: 'Cart'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/images/icons/left.svg')),
      ),
      body: MyPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BodySemiText(text: 'Order List'),
            GetBuilder<OrderListController>(
              builder: (controller) {
                return controller.isEmptyOrderList()
                    ? MyPadding(
                        child: Center(
                            child: Column(
                        children: [
                          HeadingSmallText(text: 'Empty'),
                          BodySemiSmallText(
                              text: 'Please Add Menu You Want To Eat')
                        ],
                      )))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: controller.orderList.length,
                          itemBuilder: (context, index) {
                            OrderMenuModel orderMenu =
                                controller.orderList[index];
                            MenuModel menu = orderMenu.menu;

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(top: BorderSide())),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () => controller.deleteMenu(
                                        controller.orderList[index]),
                                    icon: SvgPicture.asset(
                                        'assets/images/icons/x.svg'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //음식 사진 및 유저이름 및 유저가격
                                      Row(
                                        children: [
                                          Image.network(
                                            menu.imageUrl,
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(width: 10),
                                          //유저 음식 이름 및 가격
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              menu.userMenuName.length > 12
                                                  ? BodyText(
                                                      text:
                                                          '${menu.userMenuName.substring(0, 10)}...')
                                                  : BodyText(
                                                      text: menu.userMenuName),
                                              BodySmallText(
                                                  text: menu
                                                      .userPriceWithCurrencyUnit)
                                            ],
                                          ),
                                        ],
                                      ),
                                      //현지 음식 이름 및 가격
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          menu.originMenuName.length > 12
                                              ? BodyText(
                                                  text:
                                                      '${menu.originMenuName.substring(0, 10)}...')
                                              : BodyText(
                                                  text: menu.originMenuName),
                                          BodySmallText(
                                              text: menu
                                                  .originPriceWithCurrencyUnit)
                                        ],
                                      ),
                                    ],
                                  ),
                                  //수량 체크
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.miunsQuantity(orderMenu);
                                        },
                                        icon: SvgPicture.asset(
                                            'assets/images/icons/minus.svg'),
                                        iconSize: 20,
                                      ),
                                      BodySmallText(
                                          text: '${orderMenu.quantity}'),
                                      IconButton(
                                        onPressed: () {
                                          controller.plusQuantity(orderMenu);
                                        },
                                        icon: SvgPicture.asset(
                                            'assets/images/icons/plus.svg'),
                                        iconSize: 20,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => showAmountDue(context),
        child: const BottomButtonWidget(
          labelText: 'Check Amount Due',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
