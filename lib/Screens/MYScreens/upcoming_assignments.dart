import 'package:doctor/Screens/patient_booking_details.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/controller/upcoming_assignments_controller.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/title_column.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingAssignments extends StatefulWidget {
  final bool fromHome;
  const UpcomingAssignments({Key? key, this.fromHome = false})
      : super(key: key);

  @override
  _UpcomingAssignmentsState createState() => _UpcomingAssignmentsState();
}

class _UpcomingAssignmentsState extends State<UpcomingAssignments> {
  UpcomingAssignmentsController _con = UpcomingAssignmentsController();
  bool loading = true;

  @override
  void initState() {
    _con.getUpcomingAssignments().then((value) {
      setState(() {
        _con.data = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.fromHome)
          ? AppBar(
              title: commonAppBarTitleText(
                appbarText: 'Upcoming Appointments',
              ),
              centerTitle: false,
        titleSpacing: 0,
              leading: commonAppBarLeading(
                  iconData: Icons.arrow_back_ios_new,
                  onPressed: () {
                    Pop(context);
                  }),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: (loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (_con.data.data.isEmpty)
              ? Center(child: Text('No Upcoming Appointments'))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _con.data.data.length,
                  itemBuilder: (context, int index) {
                    var consultant = _con.data.data[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 10.0,
                          left: 10,
                          right: 10,
                          bottom: (index + 1 == _con.data.data.length)
                              ? navbarht + 20
                              : 10),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
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
                            SizedBox(
                              height: 130,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(120),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  _con.data.data[index]
                                                      .profileImage,
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
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
                                                value: consultant.bookingId,
                                              ),
                                              titleColumn(
                                                value: consultant.patientName,
                                                title: 'Patient Name',
                                              ),
                                              titleColumn(
                                                value: consultant.patientAge
                                                    .toString(),
                                                title: 'Age',
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
                                                // Text(
                                                //   consultant.status,
                                                //   style: GoogleFonts.lato(
                                                //       color: const Color(
                                                //           0xffD68100),
                                                //       fontSize: 10,
                                                //       fontWeight:
                                                //           FontWeight
                                                //               .bold),
                                                // ),
                                                Text(
                                                  consultant.fees,
                                                  style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xff252525),
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
                                        const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                    ))),
                                onPressed: () {
                                  Push(
                                      context,
                                      PatientBookingDetails(
                                          booking_id: consultant.bookingId),
                                      withnav: false);
                                },
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
    );
  }
}
