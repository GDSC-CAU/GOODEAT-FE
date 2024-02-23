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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              menu.userMenuName.length > 12
                  ? BodySemiText(
                      text: '${menu.userMenuName.substring(0, 10)}...')
                  : BodySemiText(text: menu.userMenuName),
              menu.originMenuName.length > 12
                  ? BodySmallText(
                      text: '${menu.originMenuName.substring(0, 10)}...')
                  : BodySmallText(text: menu.originMenuName),
            ],
          ),
          const SizedBox(height: 2),
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
