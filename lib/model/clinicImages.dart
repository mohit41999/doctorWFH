// To parse this JSON data, do
//
//     final clinicImages = clinicImagesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ClinicImagesModel clinicImagesFromJson(String str) =>
    ClinicImagesModel.fromJson(json.decode(str));

String clinicImagesToJson(ClinicImagesModel data) => json.encode(data.toJson());

class ClinicImagesModel {
  ClinicImagesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<ClinicImagesModelData> data;

  factory ClinicImagesModel.fromJson(Map<String, dynamic> json) =>
      ClinicImagesModel(
        status: json["status"],
        message: json["message"],
        data: List<ClinicImagesModelData>.from(
            json["data"].map((x) => ClinicImagesModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ClinicImagesModelData {
  ClinicImagesModelData({
    required this.imageId,
    required this.image,
  });

  final String imageId;
  final String image;

  factory ClinicImagesModelData.fromJson(Map<String, dynamic> json) =>
      ClinicImagesModelData(
        imageId: json["image_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "image": image,
      };
}
