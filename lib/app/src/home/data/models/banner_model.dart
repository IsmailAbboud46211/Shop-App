class BannerModel {
  int id;
  String image;

  BannerModel({
    required this.id,
    required this.image,
  });

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map["id"] as int,
      image: map["image"] as String,
    );
  }
}
