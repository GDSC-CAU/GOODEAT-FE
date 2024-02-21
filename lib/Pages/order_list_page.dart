import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/controller/order_list_controller.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/models/order_menu_model.dart';
import 'package:goodeat_frontend/widgets/layout_widget.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final OrderListController controller = Get.put(OrderListController());

  void _showAmountDue(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //메인
              const Padding(
                padding: EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    MainText(text: 'Total'),
                    Divider(),
                    //가격
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CaptionText(text: 'Price'),
                        CaptionText(text: '가격처리')
                      ],
                    ),
                    //로컬
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CaptionText(text: 'Local Price'),
                        CaptionText(text: '가격처리')
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              //버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const CaptionText(text: 'Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Row(
                      children: [
                        CaptionText(text: 'Order'),
                        SizedBox(width: 10),
                        Icon(Icons.check),
                      ],
                    ),
                  ),
                ],
              ),
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Cart'),
      ),
      body: MyPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(text: 'Order List'),
            GetBuilder<OrderListController>(
              builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.orderList.length,
                    itemBuilder: (context, index) {
                      OrderMenuModel orderMenu = controller.orderList[index];
                      MenuModel menu = orderMenu.menu;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => controller
                                  .deleteMenu(controller.orderList[index]),
                              icon:
                                  SvgPicture.asset('assets/images/icons/x.svg'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //음식 사진 및 유저이름 및 유저가격
                                Row(
                                  children: [
                                    Image.network(
                                      menu.previewImageUrl,
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
                                        MainText(text: menu.userMenuName),
                                        CaptionText(
                                            text:
                                                menu.userPriceWithCurrencyUnit)
                                      ],
                                    ),
                                  ],
                                ),
                                //현지 음식 이름 및 가격
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    MainText(text: menu.originMenuName),
                                    CaptionText(
                                        text: menu.originPriceWithCurrencyUnit)
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
                                CaptionText(text: '${orderMenu.quantity}'),
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
            //하단 주문 버튼
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => _showAmountDue(context),
                  style: ElevatedButton.styleFrom(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MainText(text: 'Check Amount Due'),
                      const SizedBox(width: 10),
                      SvgPicture.asset('assets/images/icons/dollar.svg'),
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
