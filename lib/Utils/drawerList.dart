import 'package:doctor/Screens/MYScreens/manage_calendar.dart';
import 'package:doctor/Screens/MYScreens/my_booked_appointment.dart';
import 'package:doctor/Screens/MYScreens/my_online_consultants.dart';
import 'package:doctor/Screens/completed_assignment.dart';
import 'package:doctor/Screens/MYScreens/MyQuestionsScreen.dart';
import 'package:doctor/Screens/MYScreens/MyReviewRating.dart';
import 'package:doctor/Screens/MYScreens/MyWalletTabs/my_wallet_pg.dart';
import 'package:doctor/Screens/ProfileSettings/profile_setting.dart';
import 'package:doctor/Screens/account_settings.dart';
import 'package:doctor/Screens/my_booking_request.dart';

List<Map<dynamic, dynamic>> drawerList = [
  {
    'label': 'Profile Setting',
    'Screen': ProfileSetting(),
  },
  {
    'label': 'Manage Calendar',
    'Screen': ManageCalendar(),
  },
  {
    'label': 'My Booking Request',
    'Screen': MyBookingRequest(),
  },
  {
    'label': 'My Booked Appointment',
    'Screen': MyBookedAppointment(),
  },
  {
    'label': 'My Online Consultants',
    'Screen': MyOnlineConsultants(),
  },
  {
    'label': 'Completed Assignment',
    'Screen': CompletedAssignment(),
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
  // {
  //   'label': 'My Prescriptions',
  //   'Screen': MyPrescriptionsScreen(),
  // },
  {
    'label': 'Account Setting',
    'Screen': AccountSetting(),
  },
  {
    'label': 'Logout',
    'Screen': 'null',
  },
];
