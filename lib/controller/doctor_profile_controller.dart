import 'package:doctor/API/api_constants.dart';
import 'package:doctor/model/doctor_clinic_profile.dart';
import 'package:doctor/model/doctor_personal_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProfileController {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  int speciality_id = 0;
  TextEditingController education = TextEditingController();
  TextEditingController languageSpoken = TextEditingController();
  TextEditingController totalexp = TextEditingController();
  TextEditingController address = TextEditingController();
  late PickedFile mediafile;

  Future<DoctorPersonalProfile> getDocPersonalProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_doctor_personal_details.php',
        params: {'token': Token, 'doctor_id': prefs.getString('user_id')});

    return DoctorPersonalProfile.fromJson(response);
  }

  Future<DoctorClinicProfile> getDocClinicProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_doctor_clinic.php',
        params: {'token': Token, 'doctor_id': prefs.getString('user_id')});

    return DoctorClinicProfile.fromJson(response);
  }

  // Future updateDoctorProfile ()async{
  //
  //   var response = await PostData(PARAM_URL: PARAM_URL, params: params)
  //
  //
  // }
}
