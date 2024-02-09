import 'package:get/get.dart';

class MyCountryCurrencyController extends GetxController {
  String _myCountry = '대한민국';
  String _myCurrency = '원';

  get myCountry => _myCountry;
  get myCurrency => _myCurrency;

  void modify(String myCountry, String myCurrency) {
    _myCountry = myCountry;
    _myCurrency = myCurrency;
    update();
  }
}
