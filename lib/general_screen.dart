import 'dart:ui';

import 'package:doctor/Screens/MYScreens/my_revenue.dart';
import 'package:doctor/Screens/my_booking_request.dart';
import 'package:doctor/Screens/search_screen.dart';
import 'package:doctor/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/cupertino.dart';
import 'Screens/DoctorScreens/doctor_profile.dart';
import 'Screens/Home.dart';
import 'Screens/LabProfile.dart';
import 'Screens/MedicineProfile.dart';
import 'Utils/colorsandstyles.dart';
import 'controller/NavigationController.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  List<Widget> _buildScreens() {
    return [HomeScreen(), MyRevenue(), MedicineProfile(), LabProfile()];
  }

  int _selected_index = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBody: true,
      //resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildScreens().elementAt(_selected_index),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
                color: Colors.grey.shade200.withOpacity(0.5),
                border: BorderDirectional(
                    top: BorderSide(color: Colors.white, width: 2))),
            width: MediaQuery.of(context).size.width,
            child: FABBottomAppBar(
              centerItemText: 'Search',
              selectedColor: appblueColor,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: (int index) {
                setState(() {
                  _selected_index = index;
                });
              },
              items: [
                FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
                FABBottomAppBarItem(
                    iconData: FontAwesomeIcons.calendarCheck, text: 'Revenue'),
                FABBottomAppBarItem(iconData: Icons.chat, text: 'Chats'),
                FABBottomAppBarItem(iconData: Icons.person, text: 'Profile'),
              ],
              color: Colors.black,
              // backgroundColor: Colors.purple,
            ),
          ),
        ),
      ),
      // bottomNavigationBar: ClipRRect(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //     child: Container(
      //       height: 64,
      //       width: MediaQuery.of(context).size.width,
      //       child: FABBottomAppBar(
      //         centerItemText: 'Search',
      //         backgroundColor: Colors.transparent,
      //         selectedColor: appblueColor,
      //         notchedShape: CircularNotchedRectangle(),
      //         onTabSelected: (int index) {
      //           setState(() {
      //             _selected_index = index;
      //           });
      //         },
      //         items: [
      //           FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
      //           FABBottomAppBarItem(iconData: Icons.search, text: 'Doctor'),
      //           FABBottomAppBarItem(
      //               iconData: Icons.account_circle, text: 'Medicine'),
      //           FABBottomAppBarItem(iconData: Icons.more_horiz, text: 'Lab'),
      //         ],
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: FittedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            clipBehavior: Clip.antiAlias,
            // clipBehavior: Clip.hardEdge,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.5),
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: FloatingActionButton(
                  //isExtended: true,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Push(context, MyBookingRequest());
                  },
                  child: Icon(
                    Icons.date_range_outlined,
                    size: 30,
                    color: appblueColor,
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar:
    );
  }
}
