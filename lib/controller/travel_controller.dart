import 'package:get/get.dart';

class TravelController extends GetxController {
  String _travel = 'null';
  String _travelLanguage = 'null';
  String _travelCurrency = 'null';

  get travel => _travel;
  get travelLanguage => _travelLanguage;
  get travelCurrency => _travelCurrency;

  void modify(String travel, String travelLanguage, String travelCurrency) {
    _travel = travel;
    _travelLanguage = travelLanguage;
    _travelCurrency = travelCurrency;
    update();
  }
}
