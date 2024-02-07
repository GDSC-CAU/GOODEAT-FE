import 'package:get/get.dart';

class TravelController extends GetxController {
  String _travel = 'null';

  get travel => _travel;

  void modify(String travel) {
    _travel = travel;
    update();
  }
}
