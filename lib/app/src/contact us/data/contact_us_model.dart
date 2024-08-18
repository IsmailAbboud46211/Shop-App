class ContactUsModel {
  bool status;
  dynamic message;
  Data data;

  ContactUsModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ContactUsModel.fromJson({required Map<String, dynamic> map}) {
    return ContactUsModel(
      status: map["status"] as bool,
      data: Data.fromJson(map["data"]),
      message: null,
    );
  }
}

class Data {
  int? currentPage;
  List<Datum>data=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    total = json["total"] as int?;
    currentPage = json["currentPage"] as int?;
    if (json['data'] != null) {
      data = <Datum>[];
      json['data'].forEach((v) {
        data.add(Datum.fromJson(v));
      });
    }
    firstPageUrl = json["firstPageUrl"] as String?;
    from = json["from"] as int?;
    lastPage = json["lastPage"] as int?;
    lastPageUrl = json["lastPageUrl"] as String?;
    nextPageUrl = json["nextPageUrl"] as dynamic;
    path = json["path"] as String?;
    perPage = json["perPage"] as int?;
    prevPageUrl = json["prevPageUrl"] as String?;
    to = json["to"] as int?;
  }
}

class Datum {
  int id;
  int type;
  String value;
  String image;

  Datum({
    required this.id,
    required this.type,
    required this.value,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"] as int,
      type: json["type"] as int,
      image: json["image"] as String,
      value: json["value"] as String,
    );
  }
}
