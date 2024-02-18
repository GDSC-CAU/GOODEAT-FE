import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class MenuInfoPage extends StatefulWidget {
  final MenuModel menu;
  const MenuInfoPage({super.key, required this.menu});

  @override
  State<MenuInfoPage> createState() => _MenuInfoPageState();
}

class _MenuInfoPageState extends State<MenuInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Menu Detail'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainText(text: 'Quantity'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //카트 추가 버튼
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 48,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: ShapeDecoration(
                  color: const Color(0xFF545F70),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Color(0xFF545F70)),
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
    );
  }
}
