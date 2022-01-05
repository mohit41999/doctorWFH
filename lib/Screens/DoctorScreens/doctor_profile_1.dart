import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:doctor/Screens/booking_appointment.dart';
import 'package:doctor/Utils/colorsandstyles.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/doctor_profile_row.dart';
import 'package:doctor/widgets/enter_field.dart';

class DoctorProfile1 extends StatefulWidget {
  const DoctorProfile1({Key? key}) : super(key: key);

  @override
  _DoctorProfile1State createState() => _DoctorProfile1State();
}

class _DoctorProfile1State extends State<DoctorProfile1> {
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
                  height: 325,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Details',
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
                          title: 'Specialty',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Education Details',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Language Spoken',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Experience',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'About Me',
                          value:
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et.',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 468,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clinic Info',
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
                          title: 'Clinic Name',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Location of clinic',
                          value: 'Lorem ipsum.',
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: Text(
                                'Uploaded Images',
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
                                height: 80,
                                width: MediaQuery.of(context).size.width / 1.65,
                                child: ListView.builder(
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/pngs/doctorprofile.png',
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      );
                                    }))
                          ],
                        ),
                        doctorProfileRow(
                          title: 'From to To Days',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Open-Close Time',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Offline Consultancy Fees',
                          value: 'Lorem ipsum.',
                        ),
                        doctorProfileRow(
                          title: 'Doctor’s availability status',
                          value: 'Available',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                    color: Colors.white,
                    height: 329,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              'Ratings',
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: textColor.withOpacity(0.4),
                            thickness: 1,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 8),
                                  child: Card(
                                    elevation: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            radius: 30,
                                          ),
                                          title: Text('Username'),
                                          subtitle: Row(
                                            children: [
                                              Icon(Icons.star,
                                                  size: 14,
                                                  color: apptealColor),
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                                color: apptealColor,
                                              ),
                                              Icon(Icons.star,
                                                  size: 14,
                                                  color: apptealColor),
                                              Icon(Icons.star,
                                                  size: 14,
                                                  color: apptealColor),
                                              Icon(Icons.star,
                                                  size: 14,
                                                  color: apptealColor),
                                            ],
                                          ),
                                          trailing: Text(
                                            '27/09/2021',
                                            style: GoogleFonts.lato(
                                                color: apptealColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea.',
                                            style:
                                                GoogleFonts.lato(fontSize: 12),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 755,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Schedule Video Consultancy Appointment',
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
                          title: 'Doctor\'s Availability Status',
                          value: 'Available',
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: Text(
                                'Uploaded Images',
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
                                height: 70,
                                width: MediaQuery.of(context).size.width / 1.65,
                                child: ListView.builder(
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Container(
                                          width: 92,
                                          decoration: BoxDecoration(
                                            color: Color(0xffF6F6F6),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  '9:00-9:30\nAM',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Divider(
                                                  height: 5,
                                                  thickness: 1,
                                                  color: Color(0xff161616)
                                                      .withOpacity(0.2),
                                                ),
                                                Text('\$59',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: apptealColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }))
                          ],
                        ),
                        Container(
                          height: 54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 18,
                                    color: apptealColor,
                                  )),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Today',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '09 slots',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: apptealColor,
                                  )),
                            ],
                          ),
                        ),
                        Divider(
                          color: textColor.withOpacity(0.4),
                          thickness: 1,
                        ),
                        Text(
                          'Morning',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 34,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: commonBtn(
                                  s: '10:00 AM',
                                  bgcolor: Colors.white,
                                  textColor: apptealColor,
                                  onPressed: () {},
                                  textSize: 12,
                                  width: 100,
                                  borderRadius: 0,
                                  borderWidth: 1,
                                  borderColor: apptealColor,
                                ),
                              );
                            },
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Text(
                          'Afternoon',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 34,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: commonBtn(
                                  s: '10:00 AM',
                                  bgcolor: Colors.white,
                                  textColor: apptealColor,
                                  onPressed: () {},
                                  height: 34,
                                  textSize: 12,
                                  width: 100,
                                  borderRadius: 0,
                                  borderWidth: 1,
                                  borderColor: apptealColor,
                                ),
                              );
                            },
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Text(
                          'Evening',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 34,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: commonBtn(
                                  s: '10:00 AM',
                                  bgcolor: Colors.white,
                                  textColor: apptealColor,
                                  onPressed: () {},
                                  height: 34,
                                  width: 100,
                                  textSize: 12,
                                  borderRadius: 0,
                                  borderWidth: 1,
                                  borderColor: apptealColor,
                                ),
                              );
                            },
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Text(
                          'Enter Comments',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        EnterField(
                          'Enter Comments',
                          'Enter Comments',
                          _controller,
                        ),
                        Text(
                          'Upload Report File',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        commonBtn(
                          s: 'Choose report',
                          height: 40,
                          textSize: 14,
                          bgcolor: Color(0xff161616).withOpacity(0.3),
                          textColor: Color(0xff161616),
                          onPressed: () {},
                          borderRadius: 0,
                        )
                      ],
                    ),
                  ),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: commonBtn(
            s: 'Book an Appointment',
            bgcolor: appblueColor,
            textColor: Colors.white,
            borderRadius: 8,
            onPressed: () {
              Push(context, BookingAppointment());
            }),
      ),
    );
  }
}
