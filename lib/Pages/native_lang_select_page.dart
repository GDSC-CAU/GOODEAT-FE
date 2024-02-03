import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/pages/home_page.dart';

class NativeLanguageSelect extends StatefulWidget {
  const NativeLanguageSelect({super.key});

  @override
  State<NativeLanguageSelect> createState() => _NativeLanguageSelect1State();
}

class _NativeLanguageSelect1State extends State<NativeLanguageSelect> {
  String selectedCountry = '대한민국'; //test code
  String selectedCurrency = '원'; // test code

  List<String> countries = ['대한민국', '미국', '일본', '중국', '영국']; //test code
  List<String> currencies = ['원', '달러', '엔', '위안', '파운드']; //test code

  //컨트롤러
  final controller = Get.put(MyCountryCurrencyController());

  void _showCurrencySelection(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: countries
              .map(
                (country) => ListTile(
                  title: Text(country),
                  onTap: () {
                    setState(() {
                      selectedCountry = country;
                    });
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: currencies
              .map(
                (currency) => ListTile(
                  title: Text(currency),
                  onTap: () {
                    setState(() {
                      selectedCurrency = currency;
                    });
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }

  void _submitCountryAndCurrency(BuildContext context) {
    //기기 DB에 저장
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    secureStorage.write(key: 'country', value: selectedCountry);
    secureStorage.write(key: 'currency', value: selectedCurrency);

    //controller를 통해 저장
    controller.modify(selectedCountry, selectedCurrency);

    Get.off(() => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showCurrencySelection(context),
              child: Text('선택된 나라: $selectedCountry'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showCurrencyPicker(context),
              child: Text('선택된 화폐: $selectedCurrency'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => _submitCountryAndCurrency(context),
                child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}
