import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/MYScreens/MyQuestionsScreen.dart';
import 'package:doctor/Screens/MYScreens/MyReviewRating.dart';
import 'package:doctor/Screens/MYScreens/upcoming_assignments.dart';
import 'package:doctor/Screens/completed_assignment.dart';
import 'package:doctor/Screens/patient_booking_details.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/model/Upcoming%20Appointments.dart';
import 'package:doctor/model/completed_assignment_model.dart';
import 'package:doctor/model/doctor_rating_model.dart';
import 'package:doctor/model/upcoming_assignmentsmodel.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/navigation_drawer.dart';
import 'package:doctor/widgets/title_column.dart';
import 'package:flutter/material.dart';

class MyBookedAppointment extends StatefulWidget {
  const MyBookedAppointment({Key? key}) : super(key: key);

  @override
  _MyBookedAppointmentState createState() => _MyBookedAppointmentState();
}

class _MyBookedAppointmentState extends State<MyBookedAppointment>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _controller = ScrollController();
  late CompletedAssignmentModel completedAssignment;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
        body: Column(
          children: [
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
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  CompletedAssignment(),
                  UpcomingAssignments()
                  // Lifestyle()
                  // second tab bar view widget
                ],
              ),
            ),

            SizedBox(
              height: navbarht + 20,
            ),
          ],
        ));
  }
}

// class completed extends StatefulWidget {
//   final ScrollController scrollController;
//   const completed({Key? key, required this.scrollController}) : super(key: key);
//
//   @override
//   _completedState createState() => _completedState();
// }
//
// class _completedState extends State<completed> {
//   late CompletedAssignmentModel completedAssignment;
//   bool loading = true;
//
//   Future<CompletedAssignmentModel> getcompleted() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     late Map<String, dynamic> response;
//     await PostData(PARAM_URL: 'completed_assignment.php', params: {
//       'token': Token,
//       'doctor_id': preferences.getString('user_id')
//     }).then((value) {
//       response = value;
//     });
//     return CompletedAssignmentModel.fromJson(response);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getcompleted().then((value) {
//       setState(() {
//         completedAssignment = value;
//         loading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return (loading)
//         ? Center(
//             child: CircularProgressIndicator(),
//           )
//         : Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: ListView.builder(
//                 // physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 controller: widget.scrollController,
//                 itemCount: completedAssignment.data.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Material(
//                       elevation: 4,
//                       borderRadius: BorderRadius.circular(8),
//                       child: Container(
//                         height: 105,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 18.0,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Expanded(
//                                   child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   titleColumn(
//                                       title: 'Booking ID',
//                                       value: completedAssignment
//                                           .data[index].bookingId),
//                                   titleColumn(
//                                       title: 'Booking of',
//                                       value: 'Video Consult'),
//                                 ],
//                               )),
//                               Expanded(
//                                   child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   titleColumn(
//                                       title: 'Order Date',
//                                       value: completedAssignment
//                                           .data[index].appointmentDate),
//                                   titleColumn(
//                                       title: 'Booking Time',
//                                       value: completedAssignment
//                                           .data[index].appointment_time),
//                                 ],
//                               )),
//                               Expanded(
//                                   child: Center(
//                                       child: commonBtn(
//                                 s: 'View',
//                                 bgcolor: appblueColor,
//                                 textColor: Colors.white,
//                                 onPressed: () {
//                                   Push(
//                                       context,
//                                       PatientBookingDetails(
//                                           booking_id: completedAssignment
//                                               .data[index].bookingId));
//                                 },
//                                 width: 85,
//                                 height: 30,
//                                 textSize: 11,
//                                 borderRadius: 4,
//                               ))),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           );
//   }
// }
//
// class Upcoming extends StatefulWidget {
//   final ScrollController scrollController;
//   const Upcoming({Key? key, required this.scrollController}) : super(key: key);
//
//   @override
//   _UpcomingState createState() => _UpcomingState();
// }
//
// class _UpcomingState extends State<Upcoming> {
//   Future<UpcomingAppointments> getupcoming() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     late Map<String, dynamic> response;
//     await PostData(PARAM_URL: 'get_upcoming_booking.php', params: {
//       'token': Token,
//       'doctor_id': preferences.getString('user_id')
//     }).then((value) {
//       response = value;
//     });
//     return UpcomingAppointments.fromJson(response);
//   }
//
//   late UpcomingAppointments upcomingAppointments;
//   bool upcomingloading = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getupcoming().then((value) {
//       setState(() {
//         upcomingAppointments = value;
//         upcomingloading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return (upcomingloading)
//         ? Center(
//             child: CircularProgressIndicator(),
//           )
//         : Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: (upcomingAppointments.data.length == 0)
//                 ? Center(child: Text('No upcoming appointments'))
//                 : ListView.builder(
//                     controller: widget.scrollController,
//                     // physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: upcomingAppointments.data.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Material(
//                           elevation: 4,
//                           borderRadius: BorderRadius.circular(8),
//                           child: Container(
//                             height: 105,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 18.0,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Expanded(
//                                       child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       titleColumn(
//                                           title: 'Booking ID',
//                                           value: upcomingAppointments
//                                               .data[index].bookingId),
//                                       titleColumn(
//                                           title: 'Booking of',
//                                           value: 'Video Consult'),
//                                     ],
//                                   )),
//                                   Expanded(
//                                       child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       titleColumn(
//                                           title: 'Order Date',
//                                           value: upcomingAppointments
//                                               .data[index].appointmentDate),
//                                       titleColumn(
//                                           title: 'Booking Time',
//                                           value: upcomingAppointments
//                                               .data[index].appointmentTime),
//                                     ],
//                                   )),
//                                   Expanded(
//                                       child: Center(
//                                           child: commonBtn(
//                                     s: 'View',
//                                     bgcolor: appblueColor,
//                                     textColor: Colors.white,
//                                     onPressed: () {
//                                       Push(
//                                           context,
//                                           PatientBookingDetails(
//                                             booking_id: upcomingAppointments
//                                                 .data[index].bookingId,
//                                           ));
//                                     },
//                                     width: 85,
//                                     height: 30,
//                                     textSize: 11,
//                                     borderRadius: 4,
//                                   ))),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//           );
//   }
// }
