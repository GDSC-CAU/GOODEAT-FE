import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:goodeat_frontend/models/currency_model.dart';
import 'package:goodeat_frontend/models/native_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseURL = dotenv.env['BASE_URL']!;
  static const String language = 'language';
  static const String currency = 'currency';

  //나라 리스트 받기
  static Future<List<NativeModel>> getLanguages() async {
    List<NativeModel> languageList = [];
    final url = Uri.parse('$baseURL/$language');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      const String errorMessage = '언어 리스트 받아오기를 실패하였습니다.';
      throw Exception(errorMessage);
    }
    final List<dynamic> responseList = jsonDecode(response.body);
    languageList =
        responseList.map((language) => NativeModel.fromJson(language)).toList();

    return languageList;
  }

  //화폐 리스트 받기
  static Future<List<CurrencyModel>> getCurrencies() async {
    List<CurrencyModel> currencyList = [];
    final url = Uri.parse('$baseURL/$currency');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      const String errorMessage = '화폐 리스트 받아오기를 실패하였습니다.';
      throw Exception(errorMessage);
    }
    final List<dynamic> responseList = jsonDecode(response.body);
    currencyList = responseList
        .map((currency) => CurrencyModel.fromJson(currency))
        .toList();

    return currencyList;
  }
}
