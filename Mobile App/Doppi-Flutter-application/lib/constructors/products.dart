
class Product {
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.time,
    required this.photo,
    required this.weight,
    required this.status,
    required this.organization,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String name;
  String category;
  String price;
  String time;
  String photo;
  String weight;
  String status;
  String organization;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
}