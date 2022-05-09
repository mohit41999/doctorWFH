// To parse this JSON data, do
//
//     final diseaseTreated = diseaseTreatedFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DiseaseTreated diseaseTreatedFromJson(String str) =>
    DiseaseTreated.fromJson(json.decode(str));

String diseaseTreatedToJson(DiseaseTreated data) => json.encode(data.toJson());

class DiseaseTreated {
  DiseaseTreated({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<DiseaseTreatedData> data;

  factory DiseaseTreated.fromJson(Map<String, dynamic> json) => DiseaseTreated(
        status: json["status"],
        message: json["message"],
        data: List<DiseaseTreatedData>.from(
            json["data"].map((x) => DiseaseTreatedData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DiseaseTreatedData {
  DiseaseTreatedData({
    required this.id,
    required this.diseaseName,
  });

  final String id;
  final String diseaseName;
  bool isSelected = false;

  factory DiseaseTreatedData.fromJson(Map<String, dynamic> json) =>
      DiseaseTreatedData(
        id: json["id"],
        diseaseName: json["disease_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "disease_name": diseaseName,
      };
}
