import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/AGORA/video_call.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/firebase/notification_handling.dart';
import 'package:doctor/model/view_booking_details.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/doctor_profile_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientBookingDetails extends StatefulWidget {
  final String booking_id;
  const PatientBookingDetails({Key? key, required this.booking_id})
      : super(key: key);

  @override
  _PatientBookingDetailsState createState() => _PatientBookingDetailsState();
}

class _PatientBookingDetailsState extends State<PatientBookingDetails> {
  Color textColor = Color(0xff161616);
  bool loading = true;
  TextEditingController _controller = TextEditingController();
  late ViewBookingDetails patientdetails;
  Future<ViewBookingDetails> getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_patient_view_booking_details.php',
        params: {
          'token': Token,
          'doctor_id': prefs.getString('user_id'),
          'booking_id': widget.booking_id
        });

    return ViewBookingDetails.fromJson(response);
  }

  @override
  void initState() {
    // TODO: implement initState

    getDetails().then((value) {
      setState(() {
        patientdetails = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 260,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(patientdetails
                                    .data.patientPersonal.patientImage),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: Text(
                            patientdetails.data.patientPersonal.patientName
                                .toUpperCase(),
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
                              doctorProfileRow(
                                title: 'Booking ID',
                                value: patientdetails
                                    .data.bookingDetails.bookingId,
                              ),
                              doctorProfileRow(
                                title: 'Status',
                                value: patientdetails
                                    .data.bookingDetails.bookingStatus,
                              ),
                              doctorProfileRow(
                                title: 'Booking Date',
                                value: patientdetails
                                    .data.bookingDetails.bookingDate,
                              ),
                              doctorProfileRow(
                                title: 'Booking Status',
                                value: patientdetails
                                    .data.bookingDetails.bookingStatus,
                              ),
                              doctorProfileRow(
                                title: 'Fees',
                                value: patientdetails.data.bookingDetails.fees,
                              ),
                              doctorProfileRow(
                                title: 'Payment Status',
                                value: patientdetails
                                    .data.bookingDetails.paymentStatus,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 350,
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
                                title: 'Email',
                                value: patientdetails
                                    .data.patientPersonal.patientEmail,
                              ),
                              doctorProfileRow(
                                title: 'Contact no.',
                                value: patientdetails
                                    .data.patientPersonal.patientNo,
                              ),
                              doctorProfileRow(
                                title: 'Address',
                                value: patientdetails
                                    .data.patientPersonal.patientAddress,
                              ),
                              doctorProfileRow(
                                title: 'Age',
                                value: patientdetails
                                    .data.patientPersonal.patientAge,
                              ),
                              doctorProfileRow(
                                title: 'Blood Group',
                                value: patientdetails
                                    .data.patientPersonal.patientBloodGroup,
                              ),
                              doctorProfileRow(
                                title: 'Gender',
                                value: patientdetails
                                    .data.patientPersonal.patientGender,
                              ),
                              doctorProfileRow(
                                title: 'Marital Status',
                                value: patientdetails
                                    .data.patientPersonal.patientMaritalStatus,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 600,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LifeStyle And Clinical Details',
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
                                title: 'Alcohol Consumption',
                                value: patientdetails
                                    .data.patientLifestyle.patientAlchol,
                              ),
                              doctorProfileRow(
                                title: 'Smoking Consumption',
                                value: patientdetails
                                    .data.patientLifestyle.patientSmoking,
                              ),
                              doctorProfileRow(
                                title: 'Workout',
                                value: patientdetails
                                    .data.patientLifestyle.patientWorkoutLevel,
                              ),
                              doctorProfileRow(
                                title: 'Sports',
                                value: patientdetails.data.patientLifestyle
                                    .patientSportsInvolvement,
                              ),
                              Divider(),
                              doctorProfileRow(
                                title: 'Allergies',
                                value: patientdetails
                                    .data.patientMedical.patientAllergies,
                              ),
                              doctorProfileRow(
                                title: 'Chronic Diseases',
                                value: patientdetails
                                    .data.patientMedical.patientChronicDisease,
                              ),
                              doctorProfileRow(
                                title: 'Medication',
                                value: patientdetails
                                    .data.patientMedical.patientMedication,
                              ),
                              doctorProfileRow(
                                title: 'Injury',
                                value: patientdetails
                                    .data.patientMedical.patientSurgeryInjury,
                              ),

                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Container(
                              //       width:
                              //           MediaQuery.of(context).size.width / 5,
                              //       child: Text(
                              //         'Amount Status',
                              //         style: GoogleFonts.montserrat(
                              //             fontSize: 12,
                              //             color: Color(0xff161616)
                              //                 .withOpacity(0.6)),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 15,
                              //     ),
                              //     Text('-'),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Container(
                              //       width: MediaQuery.of(context).size.width /
                              //           1.65,
                              //       child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             'Pending',
                              //             style: GoogleFonts.montserrat(
                              //                 fontSize: 12,
                              //                 color: Color(0xff161616),
                              //                 fontWeight: FontWeight.bold),
                              //           ),
                              //           commonBtn(
                              //             s: 'Pay Now',
                              //             bgcolor: appblueColor,
                              //             textColor: Colors.white,
                              //             onPressed: () {},
                              //             width: 153,
                              //             height: 30,
                              //             textSize: 12,
                              //             borderRadius: 0,
                              //           )
                              //         ],
                              //       ),
                              //     )
                              //   ],
                              // ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Container(
                              //       width:
                              //           MediaQuery.of(context).size.width / 5,
                              //       child: Text(
                              //         'Upload Document',
                              //         style: GoogleFonts.montserrat(
                              //             fontSize: 12,
                              //             color: Color(0xff161616)
                              //                 .withOpacity(0.6)),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 15,
                              //     ),
                              //     Text('-'),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Container(
                              //       width: MediaQuery.of(context).size.width /
                              //           1.65,
                              //       child: Row(
                              //         children: [
                              //           Padding(
                              //             padding: const EdgeInsets.only(
                              //                 right: 10.0),
                              //             child: Text(
                              //               'Document',
                              //               style: GoogleFonts.montserrat(
                              //                   fontSize: 12,
                              //                   color: apptealColor,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //           ),
                              //           Image.asset(
                              //               'assets/pngs/Icon feather-download.png')
                              //         ],
                              //       ),
                              //     )
                              //   ],
                              // ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Container(
                              //       width:
                              //           MediaQuery.of(context).size.width / 5,
                              //       child: Text(
                              //         'Download Report File',
                              //         style: GoogleFonts.montserrat(
                              //             fontSize: 12,
                              //             color: Color(0xff161616)
                              //                 .withOpacity(0.6)),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 15,
                              //     ),
                              //     Text('-'),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Container(
                              //       width: MediaQuery.of(context).size.width /
                              //           1.65,
                              //       child: Row(
                              //         children: [
                              //           Padding(
                              //             padding: const EdgeInsets.only(
                              //                 right: 10.0),
                              //             child: Text(
                              //               'Report',
                              //               style: GoogleFonts.montserrat(
                              //                   fontSize: 12,
                              //                   color: apptealColor,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //           ),
                              //           Image.asset(
                              //               'assets/pngs/Icon feather-download.png')
                              //         ],
                              //       ),
                              //     )
                              //   ],
                              // ),
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
                                onPressed: () {
                                  FirebaseNotificationHandling()
                                      .sendNotification(
                                          user_id: patientdetails
                                              .data.patientPersonal.patientId)
                                      .then((value) {
                                    if (!value['status']) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: value['message']));
                                    } else {
                                      Push(
                                          context,
                                          VideoCallPage(
                                            channelName: value['data']
                                                ['Channel Name'],
                                          ));
                                    }
                                  });
                                },
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
