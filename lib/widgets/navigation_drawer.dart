import 'package:doctor/Screens/sign_in_screen.dart';
import 'package:doctor/Utils/drawerList.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/controller/doctor_profile_controller.dart';
import 'package:doctor/firebase/AuthenticatioHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/colorsandstyles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'commonAppBarLeading.dart';

class commonDrawer extends StatefulWidget {
  const commonDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<commonDrawer> createState() => _commonDrawerState();
}

class _commonDrawerState extends State<commonDrawer> {
  Future<void> _ackAlert(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout!'),
          content: const Text('Are you sure want to logout'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                AuthenticationHelper().signOut();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                preferences.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false);
              },
            )
          ],
        );
      },
    );
  }

  late String profilepic;
  bool loading = true;
  Future initialize() async {
    DoctorProfileController().getDocPersonalProfile().then((value) {
      setState(() {
        profilepic = value.data.profileImage;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xffF1F1F1),
        child: Stack(
          children: [
            Column(
              children: [
                (loading)
                    ? Container(
                        height: 250,
                        child: Center(child: CircularProgressIndicator()))
                    : Container(
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(profilepic),
                                fit: BoxFit.cover)),
                      ),
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: drawerList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Text(
                                  drawerList[index]['label'],
                                  style: GoogleFonts.montserrat(
                                      color: appblueColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  if (drawerList[index]['label'].toString() ==
                                      'Logout') {
                                    _ackAlert(context);
                                  } else {
                                    Navigator.pop(context);
                                    Push(context, drawerList[index]['Screen']);
                                  }
                                },
                              ),
                              (index == drawerList.length - 1)
                                  ? SizedBox(
                                      height: 100,
                                    )
                                  : Container()
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 8),
                  child: commonAppBarLeading(
                      iconData: Icons.arrow_back_ios_new,
                      onPressed: () {
                        Navigator.pop(context);
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
