import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/controller/order_list_controller.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/models/order_menu_model.dart';
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
        title: AppBarText(text: widget.menu.userMenuName),
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
                          TitleText(text: widget.menu.userMenuName),
                          CaptionText(text: widget.menu.originMenuName),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MainText(text: 'Price'),
                              MainText(text: '${widget.menu.userPrice}')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MainText(text: 'Local Price'),
                              MainText(text: '${widget.menu.originPrice}')
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    //음식 설명 파트
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: CaptionText(text: widget.menu.description),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //Quantity 파트
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MainText(text: 'Quantity'),
                          //수량 선택 위젯
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Color(0xFF9AA5B6)),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
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
                                CaptionText(text: '$quantity'),
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
                  ],
                ),
              ],
            ),
            //카트 추가 버튼
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  final orderMenu =
                      OrderMenuModel(menu: widget.menu, quantity: quantity);

                  orderListController.addMenu(orderMenu);

                  Get.back();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF545F70),
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 2, color: Color(0xFF545F70)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainText(text: 'Add to Cart'),
                      SizedBox(width: 10),
                      Icon(Icons.shopping_cart_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
