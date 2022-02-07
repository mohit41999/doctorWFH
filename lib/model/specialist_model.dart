// To parse this JSON data, do
//
//     final specialist = specialistFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SpecialistModel specialistFromJson(String str) =>
    SpecialistModel.fromJson(json.decode(str));

String specialistToJson(SpecialistModel data) => json.encode(data.toJson());

class SpecialistModel {
  SpecialistModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<SpecialistModelData> data;

  factory SpecialistModel.fromJson(Map<String, dynamic> json) =>
      SpecialistModel(
        status: json["status"],
        message: json["message"],
        data: List<SpecialistModelData>.from(
            json["data"].map((x) => SpecialistModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SpecialistModelData {
  SpecialistModelData({
    required this.specialistId,
    required this.specialistName,
  });

  String specialistId;
  String specialistName;

  factory SpecialistModelData.fromJson(Map<String, dynamic> json) =>
      SpecialistModelData(
        specialistId: json["specialist_id"],
        specialistName: json["specialist_name"],
      );

  Map<String, dynamic> toJson() => {
        "specialist_id": specialistId,
        "specialist_name": specialistName,
      };
}
