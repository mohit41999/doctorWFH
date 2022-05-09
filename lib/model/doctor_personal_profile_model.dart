// To parse this JSON data, do
//
//     final doctorPersonalProfile = doctorPersonalProfileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DoctorPersonalProfile doctorPersonalProfileFromJson(String str) =>
    DoctorPersonalProfile.fromJson(json.decode(str));

String doctorPersonalProfileToJson(DoctorPersonalProfile data) =>
    json.encode(data.toJson());

class DoctorPersonalProfile {
  DoctorPersonalProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory DoctorPersonalProfile.fromJson(Map<String, dynamic> json) =>
      DoctorPersonalProfile(
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
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.specialist,
    required this.specialistid,
    required this.education,
    required this.experience,
    required this.languageSpoken,
    required this.address,
    required this.aboutMe,
    required this.profileImage,
    required this.diseaseArray,
  });

  final String doctorId;
  final String firstName;
  final String lastName;
  final String email;
  final String specialist;
  final String specialistid;
  final String education;
  final String experience;
  final String languageSpoken;
  final String address;
  final String aboutMe;
  final String profileImage;
  final List<DiseaseArray> diseaseArray;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        doctorId: json["doctor_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        specialist: json["specialist"],
        specialistid: json["specialistid"],
        education: json["education"],
        experience: json["experience"],
        languageSpoken: json["language_spoken"],
        address: json["Address"],
        aboutMe: json["About_me"],
        profileImage: json["profile_image"],
        diseaseArray: List<DiseaseArray>.from(
            json["diseaseArray"].map((x) => DiseaseArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "specialist": specialist,
        "specialistid": specialistid,
        "education": education,
        "experience": experience,
        "language_spoken": languageSpoken,
        "Address": address,
        "About_me": aboutMe,
        "profile_image": profileImage,
        "diseaseArray": List<dynamic>.from(diseaseArray.map((x) => x.toJson())),
      };
}

class DiseaseArray {
  DiseaseArray({
    required this.diseaseId,
    required this.diseaseName,
  });

  final String diseaseId;
  final String diseaseName;

  factory DiseaseArray.fromJson(Map<String, dynamic> json) => DiseaseArray(
        diseaseId: json["disease_id"],
        diseaseName: json["disease_name"],
      );

  Map<String, dynamic> toJson() => {
        "disease_id": diseaseId,
        "disease_name": diseaseName,
      };
}
