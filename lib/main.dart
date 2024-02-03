import 'package:flutter/material.dart';

void main() {
  runApp(const GoodEat());
}

class GoodEat extends StatelessWidget {
  const GoodEat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'GOODEAT',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: NativeLanguageSelect1(),
    );
  }
}

class NativeLanguageSelect1 extends StatefulWidget {
  const NativeLanguageSelect1({super.key});

  @override
  State<NativeLanguageSelect1> createState() => _NativeLanguageSelect1State();
}

class _NativeLanguageSelect1State extends State<NativeLanguageSelect1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
