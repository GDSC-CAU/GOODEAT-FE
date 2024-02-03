import 'package:get/get.dart';

class MyCountryCurrencyController extends GetxController {
  String _myCountry = '대한민국';
  String _myCurrency = '원';

  get myCounty => _myCountry;
  get myCurrency => _myCurrency;

  void modify(String myCounty, String myCurrency) {
    _myCountry = myCounty;
    _myCurrency = myCurrency;
    update();
  }
}
