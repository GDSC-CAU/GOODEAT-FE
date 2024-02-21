import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:goodeat_frontend/models/currency_model.dart';
import 'package:goodeat_frontend/models/menu_item_for_script.dart';
import 'package:goodeat_frontend/models/menu_model.dart';
import 'package:goodeat_frontend/models/native_model.dart';
import 'package:goodeat_frontend/models/order_menu_model.dart';
import 'package:goodeat_frontend/models/script_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseURL = dotenv.env['BASE_URL']!;
  static const String language = 'language';
  static const String currency = 'currency';
  static const String reconfigure = 'reconfigure';
  static const String script = 'script';

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

  //사진 보내고 메뉴 리스트 받기
  static Future<List<MenuModel>> postPictureAndGetMenu(
      {required String originLanguageName,
      required String userLanguageName,
      required String originCurrencyName,
      required String userCurrencyName,
      required String base64EncodedImage}) async {
    List<MenuModel> menuList = [];
    final body = {
      "originLanguageName": originLanguageName,
      "userLanguageName": userLanguageName,
      "originCurrencyName": originCurrencyName,
      "userCurrencyName": userCurrencyName,
      "base64EncodedImage": base64EncodedImage
    };
    final header = {'Content-Type': 'application/json; charset=UTF-8'};
    final url = Uri.parse('$baseURL/$reconfigure');
    final response =
        await http.post(url, body: jsonEncode(body), headers: header);

    if (response.statusCode != 200) {
      const String errorMessage = '메뉴판 리스트 받아오기를 실패하였습니다.';
      throw Exception(errorMessage);
    }
    final List<dynamic> responseList =
        jsonDecode(utf8.decode(response.bodyBytes));
    menuList = responseList.map((menu) => MenuModel.fromJson(menu)).toList();
    return menuList;
  }

  //주문 스크립트 받기
  static Future<ScriptModel> postMenuListAndGetScript(
      List<OrderMenuModel> orderMenuList,
      String originLanguageName,
      String userLanguageName) async {
    List<MenuItemForScript> menuItems = orderMenuList
        .map((orderMenu) => MenuItemForScript(
            originMenuName: orderMenu.menu.originMenuName,
            userMenuName: orderMenu.menu.userMenuName,
            quantity: orderMenu.quantity))
        .toList();

    final body = {
      'menuItems': menuItems.map((item) => item.toObject()).toList(),
      'originLanguageName': originLanguageName,
      'userLanguageName': userLanguageName,
    };

    final header = {'Content-Type': 'application/json; charset=UTF-8'};
    final url = Uri.parse('$baseURL/script');
    final response =
        await http.post(url, body: jsonEncode(body), headers: header);

    if (response.statusCode != 200) {
      const String errorMessage = '스크립트 받아오기를 실패하였습니다.';
      throw Exception(errorMessage);
    }
    final script =
        ScriptModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return script;
  }
}
