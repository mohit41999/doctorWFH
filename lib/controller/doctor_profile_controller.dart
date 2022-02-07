import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Utils/progress_view.dart';
import 'package:doctor/model/doctor_clinic_profile.dart';
import 'package:doctor/model/doctor_personal_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProfileController {
  XFile? mediaFile = null;
  late String profileImage;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  var speciality_id;
  TextEditingController education = TextEditingController();
  TextEditingController languageSpoken = TextEditingController();
  TextEditingController totalexp = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController about_me = TextEditingController();
  // late PickedFile mediafile;\

  Future submit(BuildContext context) async {
    var loader = await ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    Map<String, String> bodyparams = {
      'token': Token,
      'doctor_id': user_id!,
      'first_name': firstname.text,
      'last_name': lastname.text,
      'specialistid': speciality_id,
      'education': education.text,
      'language_spoken': languageSpoken.text,
      'experience': totalexp.text,
      'address': address.text,
      "about_me": about_me.text,
    };

    var response = (mediaFile == null)
        ? await PostData(
            PARAM_URL: 'update_doctor_personal_details.php', params: bodyparams)
        : await PostDataWithImage(
            PARAM_URL: 'update_doctor_personal_details.php',
            params: bodyparams,
            imagePath: mediaFile!.path,
            imageparamName: 'image');

    loader.dismiss();
    if (response['status']) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
    }
  }

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
