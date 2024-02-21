class MenuItemForScript {
  final String originMenuName, userMenuName;
  final int quantity;

  MenuItemForScript(
      {required this.originMenuName,
      required this.userMenuName,
      required this.quantity});

  Map<String, dynamic> toObject() {
    return {
      'originMenuName': originMenuName,
      'userMenuName': userMenuName,
      'quantity': quantity,
    };
  }
}
