import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/sign_in_screen.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:flutter/material.dart';

class SignUpController {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email_Id = TextEditingController();
  TextEditingController mobile_number = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  String countrycode = '+91';

  void clearControllers() {
    firstname.clear();
    lastname.clear();
    email_Id.clear();
    mobile_number.clear();
    password.clear();
    confirmpassword.clear();
  }

  void Signup(BuildContext context) {
    PostData(PARAM_URL: 'signup.php', params: {
      'token': Token,
      'first_name': firstname.text,
      'last_name': lastname.text,
      'email': email_Id.text,
      'country_code': countrycode,
      'mobile_no': mobile_number.text,
      'password': password.text,
      'confirm_password': confirmpassword.text,
    }).then((value) {
      (value['status'])
          ? Push(context, SignInScreen())
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value['message']),
              duration: Duration(seconds: 1),
            ));
    });
  }
}
