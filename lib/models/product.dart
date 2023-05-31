class Product {
  String id;
  int quantity;
  String categoryID;
  int price;
  String name;
  String description;
  Product(
      {required this.id,
      required this.name,
      required this.categoryID,
      required this.price,
      required this.quantity,
      required this.description});
}
