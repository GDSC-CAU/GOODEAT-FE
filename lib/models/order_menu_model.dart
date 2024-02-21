import 'package:goodeat_frontend/models/menu_model.dart';

class OrderMenuModel {
  final MenuModel menu;
  int quantity;

  OrderMenuModel({required this.menu, required this.quantity});
}
