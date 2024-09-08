import 'dart:convert';

ItemDetailsModel itemDetailsModelFromJson(String str) =>
    ItemDetailsModel.fromJson(json.decode(str));

String itemDetailsModelToJson(ItemDetailsModel data) =>
    json.encode(data.toJson());

class ItemDetailsModel {
  final int totalCount;
  final List<Item> items;

  ItemDetailsModel({
    required this.totalCount,
    required this.items,
  });

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailsModel(
      totalCount: json["totalCount"],
      items: List<Item>.from(
          json["items"].map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  final String projectNo;
  final String portName;
  final String typeOfCallName; // Changed from TypeOfCallName to String
  final String vesselName;
  final String customerName;
  final DateTime? projectPortCallEta; // Nullable
  final int status;
  final String id;

  Item({
    required this.projectNo,
    required this.portName,
    required this.typeOfCallName, // Changed from TypeOfCallName to String
    required this.vesselName,
    required this.customerName,
    this.projectPortCallEta, // Nullable
    required this.status,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      projectNo: json["projectNo"] ?? '', // Default empty string if null
      portName: json["portName"] ?? '', // Default empty string if null
      typeOfCallName: json["typeOfCallName"] ?? '', // Default empty string if null
      vesselName: json["vesselName"] ?? '', // Default empty string if null
      customerName: json["customerName"] ?? '', // Default empty string if null
      projectPortCallEta: json["projectPortCallEta"] != null
          ? DateTime.tryParse(json["projectPortCallEta"])
          : null, // Handle null case
      status: json["status"] ?? 0, // Default to 0 if null
      id: json["id"] ?? '', // Default empty string if null
    );
  }

  Map<String, dynamic> toJson() => {
        "projectNo": projectNo,
        "portName": portName,
        "typeOfCallName": typeOfCallName, // No conversion needed
        "vesselName": vesselName,
        "customerName": customerName,
        "projectPortCallEta": projectPortCallEta?.toIso8601String() ?? '', // Handle null case
        "status": status,
        "id": id,
      };
}
