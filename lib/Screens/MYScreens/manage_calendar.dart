import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:doctor/Screens/MYScreens/my_booked_appointment.dart';
import 'package:doctor/Screens/MedicineProfile.dart';
import 'package:doctor/Screens/ProductDetails.dart';
import 'package:doctor/Screens/Products.dart';
import 'package:doctor/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/title_column.dart';

class ManageCalendar extends StatefulWidget {
  const ManageCalendar({Key? key}) : super(key: key);

  @override
  _ManageCalendarState createState() => _ManageCalendarState();
}

class _ManageCalendarState extends State<ManageCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(FontAwesomeIcons.filter),
      //   backgroundColor: apptealColor,
      //   elevation: 20,
      //   splashColor: apptealColor,
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'Manage Calendar'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, int) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 10.0,
                        left: 10,
                        right: 10,
                        bottom: (int + 1 == 10) ? navbarht + 20 : 10),
                    child: Container(
                      height: 170,
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
                            height: 130,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/pngs/Ellipse 651.png',
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            titleColumn(
                                              title: 'Booking Id',
                                              value: '9956328',
                                            ),
                                            titleColumn(
                                              value: 'Lorem ipsum.',
                                              title: 'Doctor Name',
                                            ),
                                            titleColumn(
                                              value: 'Gujarat',
                                              title: 'Location',
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Pending',
                                                style: GoogleFonts.lato(
                                                    color: Color(0xffD68100),
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '\$199',
                                                style: GoogleFonts.poppins(
                                                    color: Color(0xff252525),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        )
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
                              onPressed: () {},
                              child: Text(
                                'View Booking Details',
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
          )
        ],
      ),
    );
  }
}
