class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;
  String description;
  List<dynamic> images;
  bool inFavorites;
  bool inCart;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map["id"] as int,
      name: map["name"] as String,
      description: map["description"] as String,
      image: map["image"] as String,
      price: map["price"] as dynamic,
      oldPrice: map["old_price"] as dynamic,
      discount: map["discount"] as int,
      images: map["images"] as List<dynamic>,
      inFavorites: map["in_favorites"] as bool,
      inCart: map["in_cart"] as bool,
    );
  }
}
