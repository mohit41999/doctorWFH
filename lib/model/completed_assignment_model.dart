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
    required this.ammountPaid,
    required this.patientId,
    required this.patientDocument,
    required this.invoice,
  });

  String bookingId;
  String appointmentDate;
  String ammountPaid;
  String patientId;
  String patientDocument;
  String invoice;

  factory CompletedAssignmentModelData.fromJson(Map<String, dynamic> json) =>
      CompletedAssignmentModelData(
        bookingId: json["booking_id"],
        appointmentDate: json["appointment_date"],
        ammountPaid: json["ammount_paid"],
        patientId: json["patient_id"],
        patientDocument: json["patient_document"],
        invoice: json["invoice"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "appointment_date": appointmentDate,
        "ammount_paid": ammountPaid,
        "patient_id": patientId,
        "patient_document": patientDocument,
        "invoice": invoice,
      };
}
