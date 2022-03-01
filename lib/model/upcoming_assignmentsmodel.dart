// To parse this JSON data, do
//
//     final upcomingAssignmentsModel = upcomingAssignmentsModelFromJson(jsonString);

import 'dart:convert';

UpcomingAssignmentsModel upcomingAssignmentsModelFromJson(String str) =>
    UpcomingAssignmentsModel.fromJson(json.decode(str));

String upcomingAssignmentsModelToJson(UpcomingAssignmentsModel data) =>
    json.encode(data.toJson());

class UpcomingAssignmentsModel {
  UpcomingAssignmentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory UpcomingAssignmentsModel.fromJson(Map<String, dynamic> json) =>
      UpcomingAssignmentsModel(
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
    required this.appointmentDate,
    required this.appointmentTime,
    required this.patientId,
    required this.patientName,
    required this.patientAge,
    required this.profileImage,
    required this.fees,
    required this.location,
    required this.status,
    required this.revanue,
  });

  String bookingId;
  String appointmentDate;
  String appointmentTime;
  String patientId;
  String patientName;
  String patientAge;
  String profileImage;
  String fees;
  String location;
  String status;
  String revanue;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookingId: json["booking_id"],
        appointmentDate: json["appointment_date"],
        appointmentTime: json["appointment_time"],
        patientId: json["patient_id"],
        patientName: json["patient_name"],
        patientAge: json["patient Age"],
        profileImage: json["profile_image"],
        fees: json["fees"],
        location: json["location"],
        status: json["status"],
        revanue: json["revanue"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "appointment_date": appointmentDate,
        "appointment_time": appointmentTime,
        "patient_id": patientId,
        "patient_name": patientName,
        "patient Age": patientAge,
        "profile_image": profileImage,
        "fees": fees,
        "location": location,
        "status": status,
        "revanue": revanue,
      };
}
