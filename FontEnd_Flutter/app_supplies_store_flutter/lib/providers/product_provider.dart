class Producta {
  final String ProductID;
  String? productName;
  int? price;
  int? stockQuantity;
  String? description;
  String? picture;
  bool? discontinued;
  String? storeID;
  String? categoryID;

  Producta({
    required this.ProductID,
    this.productName,
    this.description,
    this.discontinued,
    this.price,
    this.picture,
    this.categoryID,
    this.stockQuantity,
    this.storeID,
  });
}
