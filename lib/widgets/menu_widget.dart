import 'package:flutter/material.dart';
import 'package:goodeat_frontend/models/menu_model.dart';

class MenuWidget extends StatelessWidget {
  final MenuModel menu;
  const MenuWidget({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 표시
            Image.network(
              menu.imageUrl,
              height: 50,
              width: 100,
              fit: BoxFit.cover,
            ),
            // 메뉴 이름 표시
            Text(
              menu.userMenuName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              menu.originMenuName,
              style: const TextStyle(fontSize: 12),
            ),
            // 가격 표시
            Text(menu.userPrice.toString()),
            Text(
              '${menu.originPrice}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
