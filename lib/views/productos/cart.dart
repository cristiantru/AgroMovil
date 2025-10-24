class Cart {
  static final List<Map<String, dynamic>> items = [];

  static void addItem(Map<String, dynamic> product) {
    final index = items.indexWhere((item) => item["name"] == product["name"]);
    if (index >= 0) {
      items[index]["quantity"] += product["quantity"];
    } else {
      items.add(product);
    }
  }

  static double getTotal() {
    return items.fold(0, (sum, item) => sum + item["price"] * item["quantity"]);
  }

  static void clear() {
    items.clear();
  }
}
