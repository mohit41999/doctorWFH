import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/Screens/filter_screen.dart';

import 'package:doctor/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/row_text_icon.dart';

import 'doctor_profile_1.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () {
            Push(context, FilterScreen());
          },
          backgroundColor: apptealColor,
          child: Icon(
            FontAwesomeIcons.filter,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        title: commonAppBarTitle(),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Color(0xff161616).withOpacity(0.6),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Enter Doctor name, specialty, symptom',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Color(0xff161616).withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: (index + 1 == 10)
                        ? EdgeInsets.only(
                            left: 10, right: 10, bottom: 50, top: 10)
                        : const EdgeInsets.all(10.0),
                    child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(2, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 150,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 50,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Dr. Daksh Kumar', style: KHeader),
                                        Text('Hair Transplat Surgeon',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                        rowTextIcon(
                                          text: '17 yrs of exp. overall',
                                          asset: 'assets/pngs/Group.png',
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: rowTextIcon(
                                                text: 'Location',
                                                asset:
                                                    'assets/pngs/Group 1182.png',
                                              ),
                                            ),
                                            Expanded(
                                              child: rowTextIcon(
                                                text: '95%',
                                                asset:
                                                    'assets/pngs/Icon awesome-thumbs-up.png',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: rowTextIcon(
                                                text: 'Available Today',
                                                asset:
                                                    'assets/pngs/Path 2062.png',
                                              ),
                                            ),
                                            Expanded(
                                              child: rowTextIcon(
                                                text: '125',
                                                asset:
                                                    'assets/pngs/Icon awesome-star.png',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          appblueColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ))),
                              onPressed: () {
                                Push(context, DoctorProfile1());
                              },
                              child: Text(
                                'Book An Appointment',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
