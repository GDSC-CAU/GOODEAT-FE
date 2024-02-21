class TotalPriceModel {
  final String totalPriceWithOriginCurrencyUnit, totalPriceWithUserCurrencyUnit;

  TotalPriceModel.fromJson(Map<String, dynamic> json)
      : totalPriceWithOriginCurrencyUnit =
            json['totalPriceWithOriginCurrencyUnit'],
        totalPriceWithUserCurrencyUnit = json['totalPriceWithUserCurrencyUnit'];
}
