// To parse this JSON data, do
//
//     final myOnlineConsultantsModel = myOnlineConsultantsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyOnlineConsultantsModel myOnlineConsultantsModelFromJson(String str) =>
    MyOnlineConsultantsModel.fromJson(json.decode(str));

String myOnlineConsultantsModelToJson(MyOnlineConsultantsModel data) =>
    json.encode(data.toJson());

class MyOnlineConsultantsModel {
  MyOnlineConsultantsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory MyOnlineConsultantsModel.fromJson(Map<String, dynamic> json) =>
      MyOnlineConsultantsModel(
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
    required this.bookingId,
    required this.patientName,
    required this.patientAge,
    required this.profilePic,
    required this.bookingTime,
    required this.bookingDate,
    required this.fees,
    required this.location,
    required this.status,
  });

  String bookingId;
  String patientName;
  String patientAge;
  String profilePic;
  String bookingTime;
  String bookingDate;
  String fees;
  String location;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookingId: json["Booking ID"],
        patientName: json["Patient Name"],
        patientAge: json["Patient Age"],
        profilePic: json["Profile Pic"],
        bookingTime: json["booking Time"],
        bookingDate: json["booking Date"],
        fees: json["Fees"],
        location: json["Location"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Booking ID": bookingId,
        "Patient Name": patientName,
        "Patient Age": patientAge,
        "Profile Pic": profilePic,
        "booking Time": bookingTime,
        "booking Date": bookingDate,
        "Fees": fees,
        "Location": location,
        "Status": status,
      };
}
