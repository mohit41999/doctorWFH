import 'package:doctor/Screens/biometric_authenticate.dart';
import 'package:doctor/controller/sign_in_controller.dart';
import 'package:doctor/firebase/AuthenticatioHelper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doctor/Screens/Home.dart';
import 'package:doctor/Screens/MYScreens/MyPrescriprions.dart';
import 'package:doctor/Screens/sign_up.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/general_screen.dart';
import 'package:doctor/widgets/bottombar.dart';

import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/enter_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController _con = SignInController();
  bool password = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
        title: commonAppBarTitle(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In',
                style: GoogleFonts.montserrat(
                    fontSize: 30,
                    color: appblueColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Please Sign In to your account !!!',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: apptealColor,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              EnterField('Email ID', 'Email ID', _con.email),
              SizedBox(
                height: 20,
              ),
              EnterField(
                'Password',
                'Password',
                _con.password,
                obscure: password,
                widget: IconButton(
                    onPressed: () {
                      setState(() {
                        (password) ? password = false : password = true;
                      });
                    },
                    icon: (password)
                        ? Icon(FontAwesomeIcons.eyeSlash)
                        : Icon(FontAwesomeIcons.eye)),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Forgot Password ?',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.montserrat(color: appblueColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Remember Me',
                textAlign: TextAlign.right,
                style: GoogleFonts.montserrat(color: Color(0xff515151)),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'or Sign In with Fingerprint or Face',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.montserrat(color: apptealColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/pngs/Icon ionic-md-finger-print.png',
                      height: 90),
                  Image.asset('assets/pngs/Icon material-face.png', height: 90),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              commonBtn(
                  s: 'Sign In',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {
                    //Push(context, GeneralScreen2());
                    {
                      AuthenticationHelper()
                          .signIn(
                              email: _con.email.text,
                              password: _con.password.text)
                          .then((result) {
                        if (result == null) {
                          _con.SignIn(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                              style: TextStyle(fontSize: 16),
                            ),
                          ));
                        }
                      });

                      //Push(context, GeneralScreen2());
                      // Push(context, GeneralScreen());
                    }
                    // _con.SignIn(context);
                  }),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an DCP account ?',
                      style: TextStyle(color: Color(0xff515151), fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Sign up',
                            style: TextStyle(color: apptealColor, fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                                // navigate to desired screen
                              })
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
