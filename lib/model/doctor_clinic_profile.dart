// To parse this JSON data, do
//
//     final doctoClinicProfile = doctoClinicProfileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DoctorClinicProfile doctoClinicProfileFromJson(String str) =>
    DoctorClinicProfile.fromJson(json.decode(str));

String doctoClinicProfileToJson(DoctorClinicProfile data) =>
    json.encode(data.toJson());

class DoctorClinicProfile {
  DoctorClinicProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory DoctorClinicProfile.fromJson(Map<String, dynamic> json) =>
      DoctorClinicProfile(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.doctorId,
    required this.clinicName,
    required this.clinicLocation,
    required this.openTime,
    required this.closeTime,
    required this.oflineConsultancyFees,
    required this.doctorAvailabilityStatus,
    required this.fromToDays,
  });

  String doctorId;
  String clinicName;
  String clinicLocation;
  String openTime;
  String closeTime;
  String oflineConsultancyFees;
  String doctorAvailabilityStatus;
  String fromToDays;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        doctorId: json["doctor_id"],
        clinicName: json["clinic_name"],
        clinicLocation: json["clinic_location"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
        oflineConsultancyFees: json["ofline_consultancy_fees"],
        doctorAvailabilityStatus: json["doctor_availability_status"],
        fromToDays: json["from_to_days"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "clinic_name": clinicName,
        "clinic_location": clinicLocation,
        "open_time": openTime,
        "close_time": closeTime,
        "ofline_consultancy_fees": oflineConsultancyFees,
        "doctor_availability_status": doctorAvailabilityStatus,
        "from_to_days": fromToDays,
      };
}
