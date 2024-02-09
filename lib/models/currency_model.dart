class CurrencyModel {
  final String currency;

  CurrencyModel.fromJson(Map<String, dynamic> json)
      : currency = json['currencyName'];
}
