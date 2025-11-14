class ProductModel {
  String name;
  int stock;
  double price;

  ProductModel({
    required this.name,
    required this.stock,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "stock": stock,
      "price": price,
    };
  }

  factory ProductModel.fromMap(Map map) {
    return ProductModel(
      name: map["name"] ?? "Unknown",
      stock: map["stock"] ?? 0,
      price: (map["price"] ?? 0.0).toDouble(),
    );
  }
}
