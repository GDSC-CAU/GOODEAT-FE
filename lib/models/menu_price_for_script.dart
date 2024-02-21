class MenuPriceForScript {
  final double originPrice, userPrice;
  final int quantity;

  MenuPriceForScript(
      {required this.originPrice,
      required this.userPrice,
      required this.quantity});

  Map<String, dynamic> toObject() {
    return {
      'originPrice': originPrice,
      'userPrice': userPrice,
      'quantity': quantity,
    };
  }
}
