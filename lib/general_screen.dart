import 'dart:ui';

import 'package:doctor/Screens/MYScreens/my_revenue.dart';
import 'package:doctor/Screens/ProfileSettings/profile_setting.dart';
import 'package:doctor/Screens/chats_screen.dart';
import 'package:doctor/Screens/my_booking_request.dart';
import 'package:doctor/Screens/search_screen.dart';
import 'package:doctor/firebase/notification_handling.dart';
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
    return [
      HomeScreen(),
      MyRevenue(),
      MyBookingRequest(),
      ChatsScreen(),
      ProfileSetting(
        fromhome: true,
      )
    ];
  }

  int _selected_index = 0;

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  void initState() {
    FirebaseNotificationHandling().setupFirebase(context);
    //     // TODO: implement initState
    super.initState();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        opacity: 0.8,
        icon: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
            child: Icon(CupertinoIcons.home)),
        title: ("Home"),
        activeColorPrimary: appblueColor,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        opacity: 0.8,
        icon: Icon(FontAwesomeIcons.calendarCheck),
        title: ("Revenue"),
        activeColorPrimary: appblueColor,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
          opacity: 0.8,
          icon: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(100),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400.withOpacity(0.2),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 30,
                    width: 50,
                    child: Icon(
                      Icons.event_outlined,
                      size: 30,
                    ))),
          ),
          // FittedBox(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(50),
          //     clipBehavior: Clip.antiAlias,
          //     // clipBehavior: Clip.hardEdge,
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Colors.grey.shade200.withOpacity(0.5),
          //           border: Border.all(color: Colors.white, width: 2),
          //           borderRadius: BorderRadius.circular(100),
          //         ),
          //         child: FloatingActionButton(
          //           //isExtended: true,
          //           backgroundColor: Colors.transparent,
          //           onPressed: () {
          //             // pushNewScreen(
          //             //   context,
          //             //   screen: SearchScreen(),
          //             //   withNavBar: true, // OPTIONAL VALUE. True by default.
          //             //   pageTransitionAnimation:
          //             //       PageTransitionAnimation.cupertino,
          //             // );
          //
          //             // Push(context, SearchScreen());
          //           },
          //           child: Icon(
          //             Icons.search,
          //             size: 40,
          //             color: appblueColor,
          //           ),
          //           elevation: 0,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          inactiveColorPrimary: Colors.black,
          activeColorSecondary: appblueColor,
          activeColorPrimary: Colors.transparent),
      PersistentBottomNavBarItem(
        opacity: 0.8,
        icon: Icon(Icons.question_answer_rounded),
        title: ("Chats"),
        activeColorPrimary: appblueColor,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        opacity: 0.8,
        title: ("Profile"),
        activeColorPrimary: appblueColor,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  Future<bool> setpage(BuildContext) async {
    if (_controller.index == 0) {
      return true;
    } else {
      setState(() {
        _controller.index = 0;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PersistentTabView(
        context,

        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        controller: _controller,
        screens: _buildScreens(),
        navBarHeight: navbarht,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.grey.shade400, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(0.0),
            colorBehindNavBar: Colors.grey.shade200),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
        onWillPop: setpage,
        // Choose the nav bar style with this property.
      ),
    );
    //   WillPopScope(
    //   onWillPop: () async {
    //     if (_selected_index == 0) {
    //       return true;
    //     } else {
    //       setState(() {
    //         _selected_index = 0;
    //       });
    //     }
    //     return false;
    //   },
    //   child: Scaffold(
    //     extendBody: true,
    //     //resizeToAvoidBottomInset: false,
    //     //backgroundColor: Colors.white,
    //     body: Stack(
    //       children: [
    //         _buildScreens().elementAt(_selected_index),
    //       ],
    //     ),
    //     bottomNavigationBar: ClipRRect(
    //       child: BackdropFilter(
    //         filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
    //         child: Container(
    //           height: 70,
    //           decoration: BoxDecoration(
    //               color: Colors.grey.shade200.withOpacity(0.5),
    //               border: BorderDirectional(
    //                   top: BorderSide(color: Colors.white, width: 2))),
    //           width: MediaQuery.of(context).size.width,
    //           child: FABBottomAppBar(
    //             centerItemText: 'Search',
    //             selectedColor: appblueColor,
    //             notchedShape: CircularNotchedRectangle(),
    //             onTabSelected: (int index) {
    //               setState(() {
    //                 _selected_index = index;
    //               });
    //             },
    //             items: [
    //               FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
    //               FABBottomAppBarItem(
    //                   iconData: FontAwesomeIcons.calendarCheck,
    //                   text: 'Revenue'),
    //               FABBottomAppBarItem(iconData: Icons.chat, text: 'Chats'),
    //               FABBottomAppBarItem(iconData: Icons.person, text: 'Profile'),
    //             ],
    //             color: Colors.black,
    //             // backgroundColor: Colors.purple,
    //           ),
    //         ),
    //       ),
    //     ),
    //     // bottomNavigationBar: ClipRRect(
    //     //   child: BackdropFilter(
    //     //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    //     //     child: Container(
    //     //       height: 64,
    //     //       width: MediaQuery.of(context).size.width,
    //     //       child: FABBottomAppBar(
    //     //         centerItemText: 'Search',
    //     //         backgroundColor: Colors.transparent,
    //     //         selectedColor: appblueColor,
    //     //         notchedShape: CircularNotchedRectangle(),
    //     //         onTabSelected: (int index) {
    //     //           setState(() {
    //     //             _selected_index = index;
    //     //           });
    //     //         },
    //     //         items: [
    //     //           FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
    //     //           FABBottomAppBarItem(iconData: Icons.search, text: 'Doctor'),
    //     //           FABBottomAppBarItem(
    //     //               iconData: Icons.account_circle, text: 'Medicine'),
    //     //           FABBottomAppBarItem(iconData: Icons.more_horiz, text: 'Lab'),
    //     //         ],
    //     //         color: Colors.black,
    //     //       ),
    //     //     ),
    //     //   ),
    //     // ),
    //     floatingActionButton: Container(
    //       height: 60,
    //       width: 60,
    //       child: FittedBox(
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.circular(50),
    //           clipBehavior: Clip.antiAlias,
    //           // clipBehavior: Clip.hardEdge,
    //           child: BackdropFilter(
    //             filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 color: Colors.grey.shade200.withOpacity(0.5),
    //                 border: Border.all(color: Colors.white, width: 2),
    //                 borderRadius: BorderRadius.circular(100),
    //               ),
    //               child: FloatingActionButton(
    //                 //isExtended: true,
    //                 backgroundColor: Colors.transparent,
    //                 onPressed: () {
    //                   Push(context, MyBookingRequest());
    //                 },
    //                 child: Icon(
    //                   Icons.date_range_outlined,
    //                   size: 30,
    //                   color: appblueColor,
    //                 ),
    //                 elevation: 0,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //
    //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //     // bottomNavigationBar:
    //   ),
    // );
  }
}
