import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:doctor/Screens/booking_appointment.dart';
import 'package:doctor/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/doctor_profile_row.dart';

class BookingAppointment extends StatefulWidget {
  const BookingAppointment({Key? key}) : super(key: key);

  @override
  _BookingAppointmentState createState() => _BookingAppointmentState();
}

class _BookingAppointmentState extends State<BookingAppointment> {
  Color textColor = Color(0xff161616);
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 260,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/pngs/Rectangle 69.png'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10),
                    child: Text(
                      'Dr. Daksh Kumar',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: appblueColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 272,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirmation',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: textColor.withOpacity(0.4),
                          thickness: 1,
                        ),
                        doctorProfileRow(
                          title: 'Confirmation',
                          value: '0751684320',
                        ),
                        doctorProfileRow(
                          title: 'Specialty',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Doctor Name',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Booking for',
                          value: 'offline/video appointment',
                        ),
                        doctorProfileRow(
                          title: 'Status of Booking',
                          value: 'Pending',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 143,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patient Details',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: textColor.withOpacity(0.4),
                          thickness: 1,
                        ),
                        doctorProfileRow(
                          title: 'Patient Name',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Location',
                          value: 'Lorem ipsum dolor sit amet.',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 549,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking Details',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: textColor.withOpacity(0.4),
                          thickness: 1,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: Text(
                                'Booked Service time',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Color(0xff161616).withOpacity(0.6)),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('-'),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'Start Time',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Color(0xff161616),
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '   29 Sep. 11:00 AM',
                                            style: GoogleFonts.montserrat(
                                                color: apptealColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'End Time',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Color(0xff161616),
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '     29 Sep. 12:00 AM',
                                            style: GoogleFonts.montserrat(
                                                color: apptealColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        doctorProfileRow(
                          title: 'Clinic Address',
                          value: 'Lorem ipsum dolor sit amet.',
                        ),
                        doctorProfileRow(
                          title: 'Total Amount',
                          value: '\$59',
                        ),
                        doctorProfileRow(
                          title: 'Admin Fees',
                          value: '\$10',
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: Text(
                                'Amount Status',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Color(0xff161616).withOpacity(0.6)),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('-'),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.65,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pending',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Color(0xff161616),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  commonBtn(
                                    s: 'Pay Now',
                                    bgcolor: appblueColor,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                    width: 153,
                                    height: 30,
                                    textSize: 12,
                                    borderRadius: 0,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: Text(
                                'Upload Document',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Color(0xff161616).withOpacity(0.6)),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('-'),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.65,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      'Document',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: apptealColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Image.asset(
                                      'assets/pngs/Icon feather-download.png')
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: Text(
                                'Download Report File',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Color(0xff161616).withOpacity(0.6)),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('-'),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.65,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      'Report',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: apptealColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Image.asset(
                                      'assets/pngs/Icon feather-download.png')
                                ],
                              ),
                            )
                          ],
                        ),
                        commonBtn(
                          s: 'Chat',
                          bgcolor: Colors.white,
                          textColor: apptealColor,
                          onPressed: () {},
                          height: 45,
                          borderRadius: 8,
                          borderColor: apptealColor,
                          borderWidth: 2,
                        ),
                        commonBtn(
                          s: 'Start Video',
                          bgcolor: appblueColor,
                          textColor: Colors.white,
                          onPressed: () {},
                          height: 45,
                          borderRadius: 8,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: appblueColor,
                      size: 20,
                    ),
                  ),
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
