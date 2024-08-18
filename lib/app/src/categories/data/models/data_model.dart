class DataModel {
  int id;
  String name;
  String image;

  DataModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map["id"],
      image: map["image"],
      name: map["name"],
    );
  }
}
