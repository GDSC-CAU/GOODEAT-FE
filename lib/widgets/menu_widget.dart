import 'package:flutter/material.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/widgets/text_widgets.dart';

class MenuWidget extends StatelessWidget {
  final MenuModel menu;
  const MenuWidget({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.grey[300]!), // Added border for separation
        borderRadius: BorderRadius.circular(
            10), // Added border radius for rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 이미지 표시
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              menu.imageUrl,
              height: 130,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          // 메뉴 이름 표시
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodySemiText(text: menu.userMenuName),
              BodySmallText(text: menu.originMenuName),
            ],
          ),
          // 가격 표시
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BodySemiSmallText(text: menu.userPriceWithCurrencyUnit),
              BodySmallText(text: menu.originPriceWithCurrencyUnit),
            ],
          ),
        ],
      ),
    );
  }
}
