// To parse this JSON data, do
//
//     final doctorPersonalProfile = doctorPersonalProfileFromJson(jsonString);

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

  bool status;
  String message;
  Data data;

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
    required this.specialist,
    required this.education,
    required this.experience,
    required this.languageSpoken,
    required this.address,
    required this.specialistid,
    required this.profileImage,
    required this.About_me,
  });

  String doctorId;
  String firstName;
  String lastName;
  dynamic specialist;
  String education;
  String experience;
  String languageSpoken;
  String address;
  String profileImage;
  String specialistid;
  String About_me;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        doctorId: json["doctor_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        specialist: json["specialist"],
        education: json["education"],
        experience: json["experience"],
        languageSpoken: json["language_spoken"],
        address: json["Address"],
        specialistid: json["specialistid"],
        profileImage: json["profile_image"],
        About_me: json["About_me"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "first_name": firstName,
        "last_name": lastName,
        "specialist": specialist,
        "specialistid": specialistid,
        "education": education,
        "experience": experience,
        "language_spoken": languageSpoken,
        "Address": address,
        "profile_image": profileImage,
        "About_me": About_me,
      };
}
