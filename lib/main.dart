import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goodeat_frontend/pages/native_lang_select_page.dart';

void main() {
  runApp(const GoodEat());
}

class GoodEat extends StatelessWidget {
  const GoodEat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'GOODEAT',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: NativeLanguageSelect(fromHomeScreen: false),
    );
  }
}
