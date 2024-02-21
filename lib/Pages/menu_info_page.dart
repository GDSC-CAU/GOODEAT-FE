import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/controller/order_list_controller.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/models/order_menu_model.dart';
import 'package:goodeat_frontend/style.dart';
import 'package:goodeat_frontend/widgets/bottom_button_widget.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class MenuInfoPage extends StatefulWidget {
  final MenuModel menu;
  const MenuInfoPage({super.key, required this.menu});

  @override
  State<MenuInfoPage> createState() => _MenuInfoPageState();
}

class _MenuInfoPageState extends State<MenuInfoPage> {
  int quantity = 1;

  final orderListController = Get.put(OrderListController(), permanent: true);

  bool isLessThanOne() {
    if (quantity > 1) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BodySemiText(text: 'Profile Setting'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                //음식 사진
                Image.network(
                  widget.menu.imageUrl,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                //음식 이름, 가격
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //음식 이름
                          HeadingSmallText(text: widget.menu.userMenuName),
                          BodySmallText(text: widget.menu.originMenuName),

                          const SizedBox(height: 20),
                          //음식 가격
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodySemiText(text: 'Price'),
                              BodySemiText(
                                  text: widget.menu.userPriceWithCurrencyUnit)
                            ],
                          ),
                          const SizedBox(height: 20),
                          //현지음식가격
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodySemiText(text: 'Local Price'),
                              BodySemiText(
                                  text: widget.menu.originPriceWithCurrencyUnit)
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      decoration: const BoxDecoration(color: AppColor.tertiary),
                    ),
                    //음식 설명 파트
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: BodySmallText(text: widget.menu.description),
                      ),
                    ),
                    Container(
                      height: 10,
                      decoration: const BoxDecoration(color: AppColor.tertiary),
                    ),
                    //Quantity 파트
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BodyText(text: 'Quantity'),
                          //수량 선택 위젯
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (!isLessThanOne()) {
                                      setState(() {
                                        quantity -= 1;
                                      });
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                      'assets/images/icons/minus.svg'),
                                  iconSize: 20,
                                ),
                                BodySmallText(text: '$quantity'),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity += 1;
                                    });
                                  },
                                  icon: SvgPicture.asset(
                                      'assets/images/icons/plus.svg'),
                                  iconSize: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      decoration: const BoxDecoration(color: AppColor.tertiary),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          final orderMenu =
              OrderMenuModel(menu: widget.menu, quantity: quantity);
          orderListController.addMenu(orderMenu);
          Get.back();
        },
        child: const ButtomButtonWidget(
          labelText: 'Add to Cart',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
