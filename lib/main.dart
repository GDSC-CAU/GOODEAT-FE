import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/Pages/travel_lang_select_page.dart';
import 'package:goodeat_frontend/controller/my_country_currency_controller.dart';
import 'package:goodeat_frontend/controller/travel_controller.dart';
import 'package:goodeat_frontend/pages/home_page.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  runApp(const GoodEat());
}

class GoodEat extends StatelessWidget {
  const GoodEat({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'GOODEAT',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: CheckStorage(),
    );
  }
}

class CheckStorage extends StatefulWidget {
  const CheckStorage({Key? key}) : super(key: key);

  @override
  CheckStorageState createState() => CheckStorageState();
}

class CheckStorageState extends State<CheckStorage> {
  late FlutterSecureStorage secureStorage;

  @override
  void initState() {
    super.initState();
    secureStorage = const FlutterSecureStorage();
    _checkAndNavigate();
  }

  @override
  void dispose() {
    MyCountryCurrencyController().dispose();
    super.dispose();
  }

  Future<void> _checkAndNavigate() async {
    String? myCountry = await secureStorage.read(key: 'country');
    String? myCurrency = await secureStorage.read(key: 'currency');
    String? travelLanguage = await secureStorage.read(key: 'travelLanguage');
    String? travelCurrency = await secureStorage.read(key: 'travelCurrency');

    // if (myCountry != null && myCurrency != null) {
    //   //이미 정보가 있다면
    //   final controller = Get.put(MyCountryCurrencyController());
    //   controller.modify(myCountry, myCurrency);
    //   if (travelLanguage != null) {
    //     final travelController = Get.put(TravelController());
    //     travelController.modify(travelLanguage, travelCurrency!);
    //   }

    //   Get.off(() => const HomePage());
    // } else {
    //   Get.off(() => const TravelLanguageSelectPage(fromHomeScreen: false));
    // }
    Get.off(() => const TravelLanguageSelectPage(fromHomeScreen: false));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}
