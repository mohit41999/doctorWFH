// To parse this JSON data, do
//
//     final doctorRatings = doctorRatingsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DoctorRatings doctorRatingsFromJson(String str) =>
    DoctorRatings.fromJson(json.decode(str));

String doctorRatingsToJson(DoctorRatings data) => json.encode(data.toJson());

class DoctorRatings {
  DoctorRatings({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory DoctorRatings.fromJson(Map<String, dynamic> json) => DoctorRatings(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.reviewId,
    required this.patientId,
    required this.userName,
    required this.review,
    required this.rating,
    required this.date,
    required this.profileImage,
  });

  String reviewId;
  String patientId;
  String userName;
  String review;
  String rating;
  String date;
  String profileImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        reviewId: json["review_id"],
        patientId: json["patient_id"],
        userName: json["userName"],
        review: json["review"],
        rating: json["rating"],
        date: json["date"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "patient_id": patientId,
        "userName": userName,
        "review": review,
        "rating": rating,
        "date": date,
        "profile_image": profileImage,
      };
}
