class AddToCart {
  static List<Map<String, dynamic>> productCart = [];
  static void addProduct(int id, String name, int price, int qty, int total, String image) {
    productCart.add({
      "id": id,
      "name": name,
      "price": price,
      "qty": qty,
      "total": total,
      "image": image
    });
    print(productCart);
  }

  static int getSumPrice() {
    int sum = 0;
    for (var item in productCart) {
      int total = item["total"] as int;
      sum += total;
    }
    return sum;
  }
}
