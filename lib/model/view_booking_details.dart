// To parse this JSON data, do
//
//     final viewBookingDetails = viewBookingDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ViewBookingDetails viewBookingDetailsFromJson(String str) =>
    ViewBookingDetails.fromJson(json.decode(str));

String viewBookingDetailsToJson(ViewBookingDetails data) =>
    json.encode(data.toJson());

class ViewBookingDetails {
  ViewBookingDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory ViewBookingDetails.fromJson(Map<String, dynamic> json) =>
      ViewBookingDetails(
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
    required this.bookingDetails,
    required this.patientPersonal,
    required this.patientMedical,
    required this.patientLifestyle,
  });

  BookingDetails bookingDetails;
  PatientPersonal patientPersonal;
  PatientMedical patientMedical;
  PatientLifestyle patientLifestyle;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingDetails: BookingDetails.fromJson(json["Booking Details"]),
        patientPersonal: PatientPersonal.fromJson(json["Patient Personal"]),
        patientMedical: PatientMedical.fromJson(json["Patient Medical"]),
        patientLifestyle: PatientLifestyle.fromJson(json["Patient Lifestyle"]),
      );

  Map<String, dynamic> toJson() => {
        "Booking Details": bookingDetails.toJson(),
        "Patient Personal": patientPersonal.toJson(),
        "Patient Medical": patientMedical.toJson(),
        "Patient Lifestyle": patientLifestyle.toJson(),
      };
}

class BookingDetails {
  BookingDetails({
    required this.bookingId,
    required this.bookingTime,
    required this.bookingDate,
    required this.bookingStatus,
    required this.paymentStatus,
    required this.fees,
  });

  String bookingId;
  String bookingTime;
  String bookingDate;
  String bookingStatus;
  String paymentStatus;
  String fees;

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        bookingId: json["Booking ID"],
        bookingTime: json["Booking Time"],
        bookingDate: json["Booking Date"],
        bookingStatus: json["Booking Status"],
        paymentStatus: json["Payment Status"],
        fees: json["Fees"],
      );

  Map<String, dynamic> toJson() => {
        "Booking ID": bookingId,
        "Booking Time": bookingTime,
        "Booking Date": bookingDate,
        "Booking Status": bookingStatus,
        "Payment Status": paymentStatus,
        "Fees": fees,
      };
}

class PatientLifestyle {
  PatientLifestyle({
    required this.patientSmoking,
    required this.patientAlchol,
    required this.patientWorkoutLevel,
    required this.patientSportsInvolvement,
  });

  String patientSmoking;
  String patientAlchol;
  String patientWorkoutLevel;
  String patientSportsInvolvement;

  factory PatientLifestyle.fromJson(Map<String, dynamic> json) =>
      PatientLifestyle(
        patientSmoking: json["Patient Smoking"],
        patientAlchol: json["Patient Alchol"],
        patientWorkoutLevel: json["Patient Workout level"],
        patientSportsInvolvement: json["Patient Sports Involvement"],
      );

  Map<String, dynamic> toJson() => {
        "Patient Smoking": patientSmoking,
        "Patient Alchol": patientAlchol,
        "Patient Workout level": patientWorkoutLevel,
        "Patient Sports Involvement": patientSportsInvolvement,
      };
}

class PatientMedical {
  PatientMedical({
    required this.patientAllergies,
    required this.patientMedication,
    required this.patientSurgeryInjury,
    required this.patientChronicDisease,
  });

  String patientAllergies;
  String patientMedication;
  String patientSurgeryInjury;
  String patientChronicDisease;

  factory PatientMedical.fromJson(Map<String, dynamic> json) => PatientMedical(
        patientAllergies: json["Patient Allergies"],
        patientMedication: json["Patient medication"],
        patientSurgeryInjury: json["Patient Surgery Injury"],
        patientChronicDisease: json["Patient Chronic Disease"],
      );

  Map<String, dynamic> toJson() => {
        "Patient Allergies": patientAllergies,
        "Patient medication": patientMedication,
        "Patient Surgery Injury": patientSurgeryInjury,
        "Patient Chronic Disease": patientChronicDisease,
      };
}

class PatientPersonal {
  PatientPersonal({
    required this.patientId,
    required this.patientName,
    required this.patientEmail,
    required this.patientNo,
    required this.patientAge,
    required this.patientGender,
    required this.patientAddress,
    required this.patientBloodGroup,
    required this.patientMaritalStatus,
    required this.patientImage,
  });

  String patientName;
  String patientId;
  String patientEmail;
  String patientNo;
  String patientAge;
  String patientGender;
  String patientAddress;
  String patientBloodGroup;
  String patientMaritalStatus;
  String patientImage;

  factory PatientPersonal.fromJson(Map<String, dynamic> json) =>
      PatientPersonal(
        patientName: json["Patient Name"],
        patientId: json["Patient Id"],
        patientEmail: json["Patient Email"],
        patientNo: json["Patient No"],
        patientAge: json["Patient Age"],
        patientGender: json["Patient Gender"],
        patientAddress: json["Patient Address"],
        patientBloodGroup: json["Patient Blood group"],
        patientMaritalStatus: json["Patient Marital Status"],
        patientImage: json["Patient Image"],
      );

  Map<String, dynamic> toJson() => {
        "Patient Name": patientName,
        "Patient Email": patientEmail,
        "Patient Id": patientId,
        "Patient No": patientNo,
        "Patient Age": patientAge,
        "Patient Gender": patientGender,
        "Patient Address": patientAddress,
        "Patient Blood group": patientBloodGroup,
        "Patient Marital Status": patientMaritalStatus,
        "Patient Image": patientImage,
      };
}
