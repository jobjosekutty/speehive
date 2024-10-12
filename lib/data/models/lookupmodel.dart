// // To parse this JSON data, do
// //
// //     final lookUpModel = lookUpModelFromJson(jsonString);

// import 'dart:convert';

// LookUpModel lookUpModelFromJson(String str) => LookUpModel.fromJson(json.decode(str));

// String lookUpModelToJson(LookUpModel data) => json.encode(data.toJson());

// class LookUpModel {
//     int? totalCount;
//     List<Item>? items;

//     LookUpModel({
//         this.totalCount,
//         this.items,
//     });

//     factory LookUpModel.fromJson(Map<String, dynamic> json) => LookUpModel(
//         totalCount: json["totalCount"],
//         items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "totalCount": totalCount,
//         "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
//     };
// }

// class Item {
//     String? taskItemName;
//     String? projectDetailProjectNo;
//     String? userProfileName;
//     DateTime? plannedOn;
//     DateTime? startedOn;
//     DateTime? endedOn;
//     DateTime? completedOn;
//     int? status;
//     dynamic remark;
//     bool? isSopReport;
//     dynamic comment;
//     String? sopReportId;
//     bool? isBillable;
//     bool? showInPortal;
//     bool? isCritical;
//     int? reportType;
//     ExtraProperties? extraProperties;
//     String? id;

//     Item({
//         this.taskItemName,
//         this.projectDetailProjectNo,
//         this.userProfileName,
//         this.plannedOn,
//         this.startedOn,
//         this.endedOn,
//         this.completedOn,
//         this.status,
//         this.remark,
//         this.isSopReport,
//         this.comment,
//         this.sopReportId,
//         this.isBillable,
//         this.showInPortal,
//         this.isCritical,
//         this.reportType,
//         this.extraProperties,
//         this.id,
//     });

//     factory Item.fromJson(Map<String, dynamic> json) => Item(
//         taskItemName: json["taskItemName"],
//         projectDetailProjectNo: json["projectDetailProjectNo"],
//         userProfileName: json["userProfileName"],
//         plannedOn: json["plannedOn"] == null ? null : DateTime.parse(json["plannedOn"]),
//         startedOn: json["startedOn"] == null ? null : DateTime.parse(json["startedOn"]),
//         endedOn: json["endedOn"] == null ? null : DateTime.parse(json["endedOn"]),
//         completedOn: json["completedOn"] == null ? null : DateTime.parse(json["completedOn"]),
//         status: json["status"],
//         remark: json["remark"],
//         isSopReport: json["isSopReport"],
//         comment: json["comment"],
//         sopReportId: json["sopReportId"],
//         isBillable: json["isBillable"],
//         showInPortal: json["showInPortal"],
//         isCritical: json["isCritical"],
//         reportType: json["reportType"],
//         extraProperties: json["extraProperties"] == null ? null : ExtraProperties.fromJson(json["extraProperties"]),
//         id: json["id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "taskItemName": taskItemName,
//         "projectDetailProjectNo": projectDetailProjectNo,
//         "userProfileName": userProfileName,
//         "plannedOn": plannedOn?.toIso8601String(),
//         "startedOn": startedOn?.toIso8601String(),
//         "endedOn": endedOn?.toIso8601String(),
//         "completedOn": completedOn?.toIso8601String(),
//         "status": status,
//         "remark": remark,
//         "isSopReport": isSopReport,
//         "comment": comment,
//         "sopReportId": sopReportId,
//         "isBillable": isBillable,
//         "showInPortal": showInPortal,
//         "isCritical": isCritical,
//         "reportType": reportType,
//         "extraProperties": extraProperties?.toJson(),
//         "id": id,
//     };
// }

// class ExtraProperties {
//     ExtraProperties();

//     factory ExtraProperties.fromJson(Map<String, dynamic> json) => ExtraProperties(
//     );

//     Map<String, dynamic> toJson() => {
//     };
// }


import 'dart:convert';

LookUpModel lookUpModelFromJson(String str) => LookUpModel.fromJson(json.decode(str));

String lookUpModelToJson(LookUpModel data) => json.encode(data.toJson());

class LookUpModel {
    int? totalCount;
    List<Items>? items;

    LookUpModel({
        this.totalCount,
        this.items,
    });

    factory LookUpModel.fromJson(Map<String, dynamic> json) => LookUpModel(
        totalCount: json["totalCount"],
        items: json["items"] == null ? [] : List<Items>.from(json["items"]!.map((x) => Items.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Items {
    String? taskItemName;
    String? projectDetailProjectNo;
    String? userProfileName;
    DateTime? plannedOn;
    DateTime? startedOn;
    DateTime? endedOn;
    DateTime? completedOn;
    int? status;
    dynamic remark;
    bool? isSopReport;
    dynamic comment;
    String? sopReportId;
    bool? isBillable;
    bool? showInPortal;
    bool? isCritical;
    int? reportType;
    ExtraProperties? extraProperties;
    String? id;

    Items({
        this.taskItemName,
        this.projectDetailProjectNo,
        this.userProfileName,
        this.plannedOn,
        this.startedOn,
        this.endedOn,
        this.completedOn,
        this.status,
        this.remark,
        this.isSopReport,
        this.comment,
        this.sopReportId,
        this.isBillable,
        this.showInPortal,
        this.isCritical,
        this.reportType,
        this.extraProperties,
        this.id,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        taskItemName: json["taskItemName"],
        projectDetailProjectNo: json["projectDetailProjectNo"],
        userProfileName: json["userProfileName"],
        plannedOn: json["plannedOn"] == null ? null : DateTime.parse(json["plannedOn"]),
        startedOn: json["startedOn"] == null ? null : DateTime.parse(json["startedOn"]),
        endedOn: json["endedOn"] == null ? null : DateTime.parse(json["endedOn"]),
        completedOn: json["completedOn"] == null ? null : DateTime.parse(json["completedOn"]),
        status: json["status"],
        remark: json["remark"],
        isSopReport: json["isSopReport"],
        comment: json["comment"],
        sopReportId: json["sopReportId"],
        isBillable: json["isBillable"],
        showInPortal: json["showInPortal"],
        isCritical: json["isCritical"],
        reportType: json["reportType"],
        extraProperties: json["extraProperties"] == null ? null : ExtraProperties.fromJson(json["extraProperties"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "taskItemName": taskItemName,
        "projectDetailProjectNo": projectDetailProjectNo,
        "userProfileName": userProfileName,
        "plannedOn": plannedOn?.toIso8601String(),
        "startedOn": startedOn?.toIso8601String(),
        "endedOn": endedOn?.toIso8601String(),
        "completedOn": completedOn?.toIso8601String(),
        "status": status,
        "remark": remark,
        "isSopReport": isSopReport,
        "comment": comment,
        "sopReportId": sopReportId,
        "isBillable": isBillable,
        "showInPortal": showInPortal,
        "isCritical": isCritical,
        "reportType": reportType,
        "extraProperties": extraProperties?.toJson(),
        "id": id,
    };
}

class ExtraProperties {
    ExtraProperties();

    factory ExtraProperties.fromJson(Map<String, dynamic> json) => ExtraProperties(
    );

    Map<String, dynamic> toJson() => {
    };
}

