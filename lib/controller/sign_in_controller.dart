import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/biometric_authenticate.dart';
import 'package:doctor/Screens/sign_in_screen.dart';
import 'package:doctor/Utils/progress_view.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/firebase/fcm.dart';
import 'package:doctor/Screens/general_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void clearControllers() {
    email.clear();

    password.clear();
  }

  login(BuildContext context, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', value['data']['id']);
    FireBaseSetup().storefcmToken();
    print(prefs.getString('user_id'));

    Push(context, BiometricAuthenticate());
  }

  Future<void> SignIn(BuildContext context) async {
    var loader = ProgressView(context);
    loader.show();
    var response = await PostData(PARAM_URL: 'login.php', params: {
      'token': Token,
      'email': email.text,
      'password': password.text,
    });
    loader.dismiss();
    if (response['status']) {
      login(context, response);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response['message']),
        duration: Duration(seconds: 1),
      ));
    }
  }
}
