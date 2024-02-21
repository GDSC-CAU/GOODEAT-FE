import 'package:get/get.dart';
import 'package:goodeat_frontend/models/order_menu_model.dart';

class OrderListController extends GetxController {
  final List<OrderMenuModel> _orderList = [];

  get orderList => _orderList;

  void addMenu(OrderMenuModel menu) {
    _orderList.add(menu);
    update();
  }

  void deleteMenu(OrderMenuModel menu) {
    _orderList.remove(menu);
    update();
  }

  void miunsQuantity(OrderMenuModel menu) {
    final index = _orderList.indexOf(menu);
    if (index != -1) {
      if (_orderList[index].quantity > 1) {
        _orderList[index].quantity -= 1;
        update();
      }
    }
  }

  void plusQuantity(OrderMenuModel menu) {
    final index = _orderList.indexOf(menu);
    if (index != -1) {
      _orderList[index].quantity += 1;
      update();
    }
  }
}
