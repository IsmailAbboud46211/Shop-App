class SearchModel {
  SearchData? data;
  SearchModel({
    required this.data,
  });
  SearchModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? SearchData.fromJson(json['data']) : null;
  }
}

class SearchData {
  int? currentPage;
  List<SearchProduct>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  SearchData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SearchProduct>[];
      json['data'].forEach((v) {
        data!.add(SearchProduct.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class SearchProduct {
  int id;
  dynamic price;
  List<dynamic> images;
  String image;
  String name;
  String description;

  SearchProduct({
    required this.id,
    required this.price,
    required this.images,
    required this.image,
    required this.name,
    required this.description,
  });

  factory SearchProduct.fromJson(Map<String, dynamic> json) {
    return SearchProduct(
      id: json["id"] as int,
      price: json["price"] as dynamic,
      images: json["images"] as List<dynamic>,
      image: json["image"] as String,
      name: json["name"] as String,
      description: json["description"] as String,
    );
  }
}
