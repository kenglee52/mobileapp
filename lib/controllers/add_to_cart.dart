class AddToCart {
  static List<Map<String, dynamic>> productCart = [];
  static void addProduct(int id, String name, int price, int qty, int total, String image, int stock, int categoryID, int unitID, int importPrice, String manufacture, String expiry, String description) {
    productCart.add({
      "id": id,
      "name": name,
      "price": price,
      "qty": qty,
      "total": total,
      "image": image,
      "stock": stock,
      "category": categoryID,
      "unit": unitID,
      "importPrice": importPrice,
      "manufacture": manufacture,
      "expiry":expiry,
      "description": description
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
