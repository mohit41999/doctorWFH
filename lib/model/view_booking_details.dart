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
  ViewBookingDetailsData data;

  factory ViewBookingDetails.fromJson(Map<String, dynamic> json) =>
      ViewBookingDetails(
        status: json["status"],
        message: json["message"],
        data: ViewBookingDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ViewBookingDetailsData {
  ViewBookingDetailsData({
    required this.bookingDetails,
    required this.patientPersonal,
    required this.patientMedical,
    required this.patientLifestyle,
    required this.relativeInformatoin,
  });

  BookingDetails bookingDetails;
  PatientPersonal patientPersonal;
  PatientMedical patientMedical;
  PatientLifestyle patientLifestyle;
  RelativeInformatoin relativeInformatoin;

  factory ViewBookingDetailsData.fromJson(Map<String, dynamic> json) =>
      ViewBookingDetailsData(
        bookingDetails: BookingDetails.fromJson(json["Booking Details"]),
        patientPersonal: PatientPersonal.fromJson(json["Patient Personal"]),
        patientMedical: PatientMedical.fromJson(json["Patient Medical"]),
        patientLifestyle: PatientLifestyle.fromJson(json["Patient Lifestyle"]),
        relativeInformatoin:
            RelativeInformatoin.fromJson(json["Relative Informatoin"]),
      );

  Map<String, dynamic> toJson() => {
        "Booking Details": bookingDetails.toJson(),
        "Patient Personal": patientPersonal.toJson(),
        "Patient Medical": patientMedical.toJson(),
        "Patient Lifestyle": patientLifestyle.toJson(),
        "Relative Informatoin": relativeInformatoin.toJson(),
      };
}

class BookingDetails {
  BookingDetails({
    required this.bookingId,
    required this.bookingTime,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.bookingDate,
    required this.bookingStatus,
    required this.bookingFor,
    required this.paymentStatus,
    required this.fees,
  });

  String bookingId;
  String bookingTime;
  String appointmentTime;
  String appointmentDate;
  String bookingDate;
  String bookingStatus;
  String bookingFor;
  String paymentStatus;
  String fees;

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        bookingId: json["Booking ID"],
        bookingTime: json["Booking Time"],
        bookingDate: json["Booking Date"],
        appointmentDate: json["Appointment Date"],
        appointmentTime: json["Appointment Time"],
        bookingStatus: json["Booking Status"],
        bookingFor: json["Booking For"],
        paymentStatus: json["Payment Status"],
        fees: json["Fees"],
      );

  Map<String, dynamic> toJson() => {
        "Booking ID": bookingId,
        "Booking Time": bookingTime,
        "Booking Date": bookingDate,
        "Appointment Date": appointmentDate,
        "Appointment Time": appointmentTime,
        "Booking Status": bookingStatus,
        "Booking For": bookingFor,
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
    required this.patientComments,
    required this.patientDocument,
    required this.patientImage,
  });

  String patientId;
  String patientName;
  String patientEmail;
  String patientNo;
  String patientAge;
  String patientGender;
  String patientAddress;
  String patientBloodGroup;
  String patientMaritalStatus;
  String patientComments;
  String patientDocument;
  String patientImage;

  factory PatientPersonal.fromJson(Map<String, dynamic> json) =>
      PatientPersonal(
        patientId: json["Patient Id"],
        patientName: json["Patient Name"],
        patientEmail: json["Patient Email"],
        patientNo: json["Patient No"],
        patientAge: json["Patient Age"],
        patientGender: json["Patient Gender"],
        patientAddress: json["Patient Address"],
        patientBloodGroup: json["Patient Blood group"],
        patientMaritalStatus: json["Patient Marital Status"],
        patientComments: json["Patient Comments"],
        patientDocument: json["Patient Document"],
        patientImage: json["Patient Image"],
      );

  Map<String, dynamic> toJson() => {
        "Patient Id": patientId,
        "Patient Name": patientName,
        "Patient Email": patientEmail,
        "Patient No": patientNo,
        "Patient Age": patientAge,
        "Patient Gender": patientGender,
        "Patient Address": patientAddress,
        "Patient Blood group": patientBloodGroup,
        "Patient Marital Status": patientMaritalStatus,
        "Patient Comments": patientComments,
        "Patient Document": patientDocument,
        "Patient Image": patientImage,
      };
}

class RelativeInformatoin {
  RelativeInformatoin({
    required this.relativeName,
    required this.relativeAge,
    required this.relativeGender,
    required this.relativeBloodGroup,
    required this.relativeMaritalStatus,
    required this.relation,
  });

  String relativeName;
  String relativeAge;
  String relativeGender;
  String relativeBloodGroup;
  String relativeMaritalStatus;
  String relation;

  factory RelativeInformatoin.fromJson(Map<String, dynamic> json) =>
      RelativeInformatoin(
        relativeName: json["Relative Name"],
        relativeAge: json["Relative Age"],
        relativeGender: json["Relative Gender"],
        relativeBloodGroup: json["Relative Blood group"],
        relativeMaritalStatus: json["Relative Marital Status"],
        relation: json["Relation"],
      );

  Map<String, dynamic> toJson() => {
        "Relative Name": relativeName,
        "Relative Age": relativeAge,
        "Relative Gender": relativeGender,
        "Relative Blood group": relativeBloodGroup,
        "Relative Marital Status": relativeMaritalStatus,
        "Relation": relation,
      };
}
