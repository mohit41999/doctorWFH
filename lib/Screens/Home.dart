import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/MYScreens/MyQuestionsScreen.dart';
import 'package:doctor/Screens/MYScreens/MyReviewRating.dart';
import 'package:doctor/Screens/MYScreens/my_online_consultants.dart';
import 'package:doctor/Screens/completed_assignment.dart';
import 'package:doctor/Screens/patient_booking_details.dart';

import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/model/Upcoming%20Appointments.dart';
import 'package:doctor/model/completed_assignment_model.dart';
import 'package:doctor/model/doctor_rating_model.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/navigation_drawer.dart';
import 'package:doctor/widgets/title_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Placemark> address = [];
  late Position position;
  Future getcity() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print(placemarks);
      setState(() {
        address = placemarks;
      });
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: commonAppBarTitle(),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Builder(
              builder: (context) => commonAppBarLeading(
                  iconData: Icons.menu,
                  onPressed: () {
                    setState(() {
                      Scaffold.of(context).openDrawer();
                    });
                  }),
            )),
        drawer: commonDrawer(),
        body: ListView(
          controller: _controller,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Revenue',
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: appblueColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                    )),
                    Expanded(
                        flex: 5,
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('data'),
                              Text(
                                'data',
                                style: GoogleFonts.montserrat(
                                    color: appblueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: commonBtn(
                s: 'Bookings',
                bgcolor: appblueColor,
                textColor: Colors.white,
                onPressed: () {},
                height: 40,
                textSize: 14,
                borderRadius: 10,
              ),
            ),
            Container(
              color: Colors.white,
              child: TabBar(
                labelPadding: EdgeInsets.only(right: 4, left: 0),
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: appblueColor),
                    insets: EdgeInsets.all(-1)),
                controller: _tabController,
                labelColor: appblueColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Completed',
                  ),
                  Tab(
                    text: 'Upcoming',
                  ),
                  // Tab(
                  //   text: 'Lifestyle',
                  // ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 0,
              color: Colors.grey.withOpacity(0.5),
            ),
            SizedBox(
              height: 10,
            ),
            // tab bar view here
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  completed(),
                  Upcoming(),
                  // Lifestyle()
                  // second tab bar view widget
                ],
              ),
            ),

            Center(
              child: Wrap(children: [
                commonBtn(
                  s: 'View All',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _tabController.index == 0
                        ? Push(context, CompletedAssignment())
                        : Push(context, MyOnlineConsultants());
                  },
                  height: 30,
                  width: 90,
                  textSize: 11,
                  borderRadius: 4,
                ),
              ]),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: commonBtn(
                s: 'Reviews',
                bgcolor: appblueColor,
                textColor: Colors.white,
                onPressed: () {},
                height: 40,
                textSize: 14,
                borderRadius: 10,
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: DocReview()),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Wrap(children: [
                commonBtn(
                  s: 'View All',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Push(context, MyReviewRatingsScreen());
                  },
                  height: 30,
                  width: 90,
                  textSize: 11,
                  borderRadius: 4,
                ),
              ]),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: commonBtn(
                s: 'Question And Answer',
                bgcolor: appblueColor,
                textColor: Colors.white,
                onPressed: () {},
                height: 40,
                textSize: 14,
                borderRadius: 10,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                  controller: _controller,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Lorem ipsum dolor sit amet, consetetur. ?',
                                    style: GoogleFonts.lato(
                                        color: Color(0xff252525),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '  27/09/2021',
                                    style: GoogleFonts.lato(
                                        color: apptealColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea.',
                                style: GoogleFonts.lato(fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Wrap(children: [
                commonBtn(
                  s: 'View All',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Push(context, MyQuestionsScreen());
                  },
                  height: 30,
                  width: 90,
                  textSize: 11,
                  borderRadius: 4,
                ),
              ]),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ));
  }
}

class completed extends StatefulWidget {
  const completed({Key? key}) : super(key: key);

  @override
  _completedState createState() => _completedState();
}

class _completedState extends State<completed> {
  late CompletedAssignmentModel completedAssignment;
  bool loading = true;

  Future<CompletedAssignmentModel> getcompleted() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    late Map<String, dynamic> response;
    await PostData(PARAM_URL: 'completed_assignment.php', params: {
      'token': Token,
      'doctor_id': preferences.getString('user_id')
    }).then((value) {
      response = value;
    });
    return CompletedAssignmentModel.fromJson(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcompleted().then((value) {
      setState(() {
        completedAssignment = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: completedAssignment.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 105,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  titleColumn(
                                      title: 'Booking ID',
                                      value: completedAssignment
                                          .data[index].bookingId),
                                  titleColumn(
                                      title: 'Booking of', value: 'value'),
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  titleColumn(
                                      title: 'Order Date',
                                      value: completedAssignment
                                          .data[index].appointmentDate),
                                  titleColumn(
                                      title: 'Booking Time',
                                      value: completedAssignment
                                          .data[index].appointment_time),
                                ],
                              )),
                              Expanded(
                                  child: Center(
                                      child: commonBtn(
                                s: 'View',
                                bgcolor: appblueColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  Push(
                                      context,
                                      PatientBookingDetails(
                                          booking_id: completedAssignment
                                              .data[index].bookingId));
                                },
                                width: 85,
                                height: 30,
                                textSize: 11,
                                borderRadius: 4,
                              ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}

class Upcoming extends StatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  Future<UpcomingAppointments> getupcoming() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    late Map<String, dynamic> response;
    await PostData(PARAM_URL: 'get_upcoming_booking.php', params: {
      'token': Token,
      'doctor_id': preferences.getString('user_id')
    }).then((value) {
      response = value;
    });
    return UpcomingAppointments.fromJson(response);
  }

  late UpcomingAppointments upcomingAppointments;
  bool upcomingloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getupcoming().then((value) {
      setState(() {
        upcomingAppointments = value;
        upcomingloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (upcomingloading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: upcomingAppointments.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 105,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  titleColumn(
                                      title: 'Booking ID',
                                      value: upcomingAppointments
                                          .data[index].bookingId),
                                  titleColumn(
                                      title: 'Booking of', value: 'value'),
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  titleColumn(
                                      title: 'Order Date',
                                      value: upcomingAppointments
                                          .data[index].appointmentDate),
                                  titleColumn(
                                      title: 'Booking Time',
                                      value: upcomingAppointments
                                          .data[index].appointmentTime),
                                ],
                              )),
                              Expanded(
                                  child: Center(
                                      child: commonBtn(
                                s: 'View',
                                bgcolor: appblueColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  Push(
                                      context,
                                      PatientBookingDetails(
                                        booking_id: upcomingAppointments
                                            .data[index].bookingId,
                                      ));
                                },
                                width: 85,
                                height: 30,
                                textSize: 11,
                                borderRadius: 4,
                              ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}

class DocReview extends StatefulWidget {
  const DocReview({Key? key}) : super(key: key);

  @override
  _DocReviewState createState() => _DocReviewState();
}

class _DocReviewState extends State<DocReview> {
  bool loading = true;
  late DoctorRatings doctorRatings;
  Future<DoctorRatings> getdocReview() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    late Map<String, dynamic> response;
    await PostData(PARAM_URL: 'get_rating_reviews.php', params: {
      'token': Token,
      'doctor_id': preferences.getString('user_id')
    }).then((value) {
      response = value;
    });
    return DoctorRatings.fromJson(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdocReview().then((value) {
      setState(() {
        doctorRatings = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Center(child: CircularProgressIndicator())
        : (doctorRatings.data.length == 0)
            ? Text('No Reviews Yet')
            : ListView.builder(
                itemCount: doctorRatings.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(),
                              title: Text(doctorRatings.data[index].userName),
                              subtitle: RatingBarIndicator(
                                rating: double.parse(
                                    doctorRatings.data[index].rating),
                                itemCount: 5,
                                itemSize: 15.0,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                              trailing: Text(
                                doctorRatings.data[index].date,
                                style: GoogleFonts.lato(
                                    color: apptealColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              doctorRatings.data[index].review,
                              style: GoogleFonts.lato(fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
  }
}
