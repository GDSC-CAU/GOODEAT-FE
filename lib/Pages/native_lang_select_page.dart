import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/models/currency_model.dart';
import 'package:goodeat_frontend/models/native_model.dart';
import 'package:goodeat_frontend/pages/home_page.dart';
import 'package:goodeat_frontend/services/lang_currency.dart';

class NativeLanguageSelect extends StatefulWidget {
  const NativeLanguageSelect({super.key, required this.fromHomeScreen});
  final bool fromHomeScreen;

  @override
  State<NativeLanguageSelect> createState() => _NativeLanguageSelectState();
}

class _NativeLanguageSelectState extends State<NativeLanguageSelect> {
  String selectedCountry = 'English'; //test code
  String selectedCurrency = '원'; // test code

  //List<String> countries = ['대한민국', '미국', '일본', '중국', '영국']; //test code
  late Future<List<NativeModel>> countries;
  //List<String> currencies = ['원', '달러', '엔', '위안', '파운드']; //test code
  late Future<List<CurrencyModel>> currencies;

  //컨트롤러
  final controller = Get.put(MyCountryCurrencyController());

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    countries = ApiService.getLanguages();
    currencies = ApiService.getCurrencies();
    // _myCountry와 _myCurrency를 초기화
    selectedCountry = controller.myCountry;
    selectedCurrency = controller.myCurrency;
  }

  void _showCountrySelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<NativeModel>>(
          future: countries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data available');
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data!
                      .map(
                        (country) => ListTile(
                          title: Text(country.native),
                          onTap: () {
                            setState(() {
                              selectedCountry = country.native;
                            });
                            Get.back();
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            }
          },
        );
      },
    );
  }

  void _showCurrencySelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<CurrencyModel>>(
          future: currencies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data available');
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data!
                      .map(
                        (currency) => ListTile(
                          title: Text(currency.currency),
                          onTap: () {
                            setState(() {
                              selectedCurrency = currency.currency;
                            });
                            Get.back();
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            }
          },
        );
      },
    );
  }

  void _submitCountryAndCurrency(BuildContext context) async {
    //기기 DB에 저장

    await secureStorage.write(key: 'country', value: selectedCountry);
    await secureStorage.write(key: 'currency', value: selectedCurrency);

    //controller를 통해 저장
    controller.modify(selectedCountry, selectedCurrency);

    if (widget.fromHomeScreen) {
      //홈페이지에서 push하여 재설정일 경우
      Get.back();
    } else {
      //처음 들어온 경우
      Get.off(() => const HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.fromHomeScreen ? true : false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showCountrySelection(context),
              child: Text('선택된 나라: $selectedCountry'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showCurrencySelection(context),
              child: Text('선택된 화폐: $selectedCurrency'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async => _submitCountryAndCurrency(context),
                child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}
