class MenuModel {
  final String description, imageUrl, originMenuName, userMenuName;
  final double originPrice, userPrice;

  MenuModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        imageUrl = json['imageUrl'],
        originMenuName = json['originMenuName'],
        userMenuName = json['userMenuName'],
        originPrice = json['originPrice'],
        userPrice = json['userPrice'];
}
