import 'package:get/get.dart';

class MyCountryCurrencyController extends GetxController {
  String _myCountry = 'English';
  String _myCurrency = 'United States Dollar';

  get myCountry => _myCountry;
  get myCurrency => _myCurrency;

  void modify(String myCountry, String myCurrency) {
    _myCountry = myCountry;
    _myCurrency = myCurrency;
    update();
  }
}
