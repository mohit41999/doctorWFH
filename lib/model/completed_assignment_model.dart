// To parse this JSON data, do
//
//     final completedAssignmentModel = completedAssignmentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CompletedAssignmentModel completedAssignmentModelFromJson(String str) =>
    CompletedAssignmentModel.fromJson(json.decode(str));

String completedAssignmentModelToJson(CompletedAssignmentModel data) =>
    json.encode(data.toJson());

class CompletedAssignmentModel {
  CompletedAssignmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<CompletedAssignmentModelData> data;

  factory CompletedAssignmentModel.fromJson(Map<String, dynamic> json) =>
      CompletedAssignmentModel(
        status: json["status"],
        message: json["message"],
        data: List<CompletedAssignmentModelData>.from(
            json["data"].map((x) => CompletedAssignmentModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CompletedAssignmentModelData {
  CompletedAssignmentModelData({
    required this.bookingId,
    required this.appointmentDate,
    required this.appointment_time,
    required this.ammountPaid,
    required this.patientId,
    required this.patientDocument,
    required this.invoice,
    required this.coupon_discount,
    required this.consultancy_fees,
  });

  String bookingId;
  String appointmentDate;
  String appointment_time;
  String ammountPaid;
  String patientId;
  String patientDocument;
  String invoice;
  String consultancy_fees;
  String coupon_discount;

  factory CompletedAssignmentModelData.fromJson(Map<String, dynamic> json) =>
      CompletedAssignmentModelData(
        bookingId: json["booking_id"],
        consultancy_fees: json["consultancy_fees"],
        coupon_discount: json["coupon_discount"],
        appointment_time: json["appointment_time"],
        appointmentDate: json["appointment_date"],
        ammountPaid: json["ammount_paid"],
        patientId: json["patient_id"],
        patientDocument: json["patient_document"],
        invoice: json["invoice"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "coupon_discount": coupon_discount,
        "consultancy_fees": consultancy_fees,
        "appointment_date": appointmentDate,
        "appointment_time": appointment_time,
        "ammount_paid": ammountPaid,
        "patient_id": patientId,
        "patient_document": patientDocument,
        "invoice": invoice,
      };
}
