// To parse this JSON data, do
//
//     final upcomingAppointments = upcomingAppointmentsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpcomingAppointments upcomingAppointmentsFromJson(String str) =>
    UpcomingAppointments.fromJson(json.decode(str));

String upcomingAppointmentsToJson(UpcomingAppointments data) =>
    json.encode(data.toJson());

class UpcomingAppointments {
  UpcomingAppointments({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory UpcomingAppointments.fromJson(Map<String, dynamic> json) =>
      UpcomingAppointments(
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
  });

  String bookingId;
  String appointmentDate;
  String appointmentTime;
  String patientId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookingId: json["booking_id"],
        appointmentDate: json["appointment_date"],
        appointmentTime: json["appointment_time"],
        patientId: json["patient_id"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "appointment_date": appointmentDate,
        "appointment_time": appointmentTime,
        "patient_id": patientId,
      };
}
