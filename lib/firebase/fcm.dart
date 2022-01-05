import 'package:doctor/API/api_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseSetup {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late String fcm_token;
  Future storefcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    messaging.getToken().then((value) {
      fcm_token = value!;
      print(fcm_token);
      if (prefs.getString('user_id') == null) {
      } else {
        PostData(PARAM_URL: 'add_fcm_token.php', params: {
          'token': Token,
          'doctor_id': prefs.getString('user_id'),
          'fcm_token': value
        });
      }
    });
  }

  Future getfcm(String user_id) async {
    var response = await PostData(
        PARAM_URL: 'get_fcm_token.php',
        params: {'token': Token, 'user_id': user_id});
    return response;
  }
}
