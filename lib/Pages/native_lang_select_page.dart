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
  String selectedCurrency = 'United States Dollar'; // test code
  late Future<List<NativeModel>> countries;
  late Future<List<CurrencyModel>> currencies;

  //컨트롤러
  final controller = Get.put(MyCountryCurrencyController());

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  TextEditingController searchLanguageController = TextEditingController();
  TextEditingController searchCurrencyController = TextEditingController();

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
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchLanguageController,
                      decoration: const InputDecoration(
                        labelText: 'Search Country',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // 검색어 입력 시 setState를 호출하여 화면을 다시 그리도록 함
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var country = snapshot.data![index];
                        // 검색어로 필터링
                        if (country.native.toLowerCase().contains(
                            searchLanguageController.text.toLowerCase())) {
                          return ListTile(
                            title: Text(country.native),
                            onTap: () {
                              setState(() {
                                selectedCountry = country.native;
                              });
                              Get.back();
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
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
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchCurrencyController,
                    decoration: const InputDecoration(
                      labelText: 'Search Currency',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var currency = snapshot.data![index];
                      // 검색어로 필터링
                      if (currency.currency.toLowerCase().contains(
                          searchCurrencyController.text.toLowerCase())) {
                        return ListTile(
                          title: Text(currency.currency),
                          onTap: () {
                            setState(() {
                              selectedCurrency = currency.currency;
                            });
                            Get.back();
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ]);
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
