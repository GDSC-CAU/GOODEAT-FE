import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
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
      body: FooterView(
        footer: Footer(
            backgroundColor: Colors.white,
            child: OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text('Add to Cart'),
            )),
        children: [
          Image.network(
            widget.menu.imageUrl,
            height: 150,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
