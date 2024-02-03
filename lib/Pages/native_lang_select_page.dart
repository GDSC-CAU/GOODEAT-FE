import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
