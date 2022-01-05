import 'package:doctor/API/api_constants.dart';
import 'package:doctor/model/my_online_consultants_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOnlineConsultantsController {
  late MyOnlineConsultantsModel data;
  Future<MyOnlineConsultantsModel> getOnlineConsultants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'my_online_consultants.php',
        params: {'token': Token, 'doctor_id': prefs.getString('user_id')});
    return MyOnlineConsultantsModel.fromJson(response);
  }
}
