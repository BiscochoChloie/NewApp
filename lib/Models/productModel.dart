class Product {
  int id;
  String name;
  String imageLink;
  String price;

  Product({
    required this.id,
    required this.name,
    required this.imageLink,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        imageLink: json["image_link"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_link": imageLink,
        "price": price,
      };
}
