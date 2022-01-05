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
  List<MyOnlineConsultantsModelData> data;

  factory MyOnlineConsultantsModel.fromJson(Map<String, dynamic> json) =>
      MyOnlineConsultantsModel(
        status: json["status"],
        message: json["message"],
        data: List<MyOnlineConsultantsModelData>.from(json["data"].map((x) => MyOnlineConsultantsModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyOnlineConsultantsModelData {
  MyOnlineConsultantsModelData({
    required this.bookingId,
    required this.patientName,
    required this.bookingTime,
    required this.bookingDate,
    required this.fees,
    required this.location,
    required this.status,
  });

  String bookingId;
  String patientName;
  String bookingTime;
  String bookingDate;
  String fees;
  String location;
  String status;

  factory MyOnlineConsultantsModelData.fromJson(Map<String, dynamic> json) => MyOnlineConsultantsModelData(
        bookingId: json["Booking ID"],
        patientName: json["Patient Name"],
        bookingTime: json["booking Time"],
        bookingDate: json["booking Date"],
        fees: json["Fees"],
        location: json["Location"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Booking ID": bookingId,
        "Patient Name": patientName,
        "booking Time": bookingTime,
        "booking Date": bookingDate,
        "Fees": fees,
        "Location": location,
        "Status": status,
      };
}
