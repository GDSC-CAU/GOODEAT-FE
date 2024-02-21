import 'package:get/get.dart';

class TravelController extends GetxController {
  String _travelLanguage = 'Korean';
  String _travelCurrency = 'South Korean won';

  get travelLanguage => _travelLanguage;
  get travelCurrency => _travelCurrency;

  void modify(String travelLanguage, String travelCurrency) {
    _travelLanguage = travelLanguage;
    _travelCurrency = travelCurrency;
    update();
  }
}
