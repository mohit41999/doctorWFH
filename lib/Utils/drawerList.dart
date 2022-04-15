import 'package:doctor/Screens/MYScreens/MyQuestionsScreen.dart';
import 'package:doctor/Screens/MYScreens/MyReviewRating.dart';
import 'package:doctor/Screens/MYScreens/MyWalletTabs/my_wallet_pg.dart';
import 'package:doctor/Screens/MYScreens/manage_calendar.dart';
import 'package:doctor/Screens/MYScreens/my_booked_appointment.dart';
import 'package:doctor/Screens/MYScreens/upcoming_assignments.dart';
import 'package:doctor/Screens/ProfileSettings/profile_setting.dart';
import 'package:doctor/Screens/account_settings.dart';
import 'package:doctor/Screens/chats_screen.dart';
import 'package:doctor/Screens/completed_assignment.dart';

List<Map<dynamic, dynamic>> drawerList = [
  {
    'label': 'Profile Setting',
    'Screen': ProfileSetting(
      fromhome: false,
    ),
  },
  {
    'label': 'Manage Calendar',
    'Screen': ManageCalendar(),
  },
  {
    'label': 'My Chats',
    'Screen': ChatsScreen(
      fromhome: false,
    ),
  },
  // {
  //   'label': 'My Booking Request',
  //   'Screen': MyBookingRequest(),
  // },
  // {
  //   'label': 'My Booked Appointment',
  //   'Screen': MyBookedAppointment(),
  // },
  // {
  //   'label': 'Upcoming Appointments',
  //   'Screen': UpcomingAssignments(),
  // },
  // {
  //   'label': 'Completed Assignment',
  //   'Screen': CompletedAssignment(),
  // },
  {
    'label': 'Booking Appointments',
    'Screen': MyBookedAppointment(),
  },
  {
    'label': 'My Reviews',
    'Screen': MyReviewRatingsScreen(),
  },
  {
    'label': 'My Questions',
    'Screen': MyQuestionsScreen(),
  },
  {
    'label': 'Billing Segment',
    'Screen': MyWalletPage(),
  },
  {
    'label': 'Account Setting',
    'Screen': AccountSetting(),
  },
  {
    'label': 'Logout',
    'Screen': 'null',
  },
];
