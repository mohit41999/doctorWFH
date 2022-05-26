import 'package:doctor/Screens/MYScreens/MyReviewRating.dart';
import 'package:doctor/Screens/MYScreens/MyWalletTabs/my_wallet_pg.dart';
import 'package:doctor/Screens/MYScreens/PatientQuestion.dart';
import 'package:doctor/Screens/MYScreens/manage_calendar.dart';
import 'package:doctor/Screens/MYScreens/my_booked_appointment.dart';
import 'package:doctor/Screens/MYScreens/upcoming_assignments.dart';
import 'package:doctor/Screens/ProfileSettings/profile_setting.dart';
import 'package:doctor/Screens/account_settings.dart';
import 'package:doctor/Screens/chats_screen.dart';
import 'package:doctor/Screens/completed_assignment.dart';
import 'package:doctor/Screens/KnowledgeForum/my_knowledge_forum.dart';

List<Map<dynamic, dynamic>> drawerList = [
  {
    'label': 'Profile Setting',
    'Screen': ProfileSetting(
      fromhome: false,
    ),
    'withnav': false,
  },
  {
    'label': 'Manage Calendar',
    'Screen': ManageCalendar(),
    'withnav': true,
  },
  {
    'label': 'My Chats',
    'Screen': ChatsScreen(
      fromhome: false,
    ),
    'withnav': true,
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
    'withnav': true,
  },
  {
    'label': 'My Knowledge Forum',
    'Screen': MyKnowledgeForum(),
    'withnav': true,
  },
  {
    'label': 'My Reviews',
    'Screen': MyReviewRatingsScreen(),
    'withnav': true,
  },
  {
    'label': 'Patient Questions',
    'Screen': PatientQuestionsScreen(),
    'withnav': true,
  },
  {
    'label': 'Billing Segment',
    'Screen': MyWalletPage(),
    'withnav': true,
  },
  {
    'label': 'Account Setting',
    'Screen': AccountSetting(),
    'withnav': true,
  },
  {
    'label': 'Logout',
    'Screen': 'null',
    'withnav': true,
  },
];
