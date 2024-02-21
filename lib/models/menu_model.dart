class MenuModel {
  final String description,
      previewImageUrl,
      imageUrl,
      originMenuName,
      userMenuName,
      originPriceWithCurrencyUnit,
      userPriceWithCurrencyUnit;
  final double originPrice, userPrice;

  MenuModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        previewImageUrl = json['previewImageUrl'],
        imageUrl = json['imageUrl'],
        originMenuName = json['originMenuName'],
        userMenuName = json['userMenuName'],
        originPrice = json['originPrice'],
        originPriceWithCurrencyUnit = json['originPriceWithCurrencyUnit'],
        userPrice = json['userPrice'],
        userPriceWithCurrencyUnit = json['userPriceWithCurrencyUnit'];
}
