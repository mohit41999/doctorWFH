import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctor/Screens/ProfileSettings/personal_tab.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';

import 'lifestyle_tab.dart';
import 'clinical_tab.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSetting extends StatefulWidget {
  final bool fromhome;

  const ProfileSetting({Key? key, required this.fromhome}) : super(key: key);
  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: commonAppBarTitleText(appbarText: 'Profile Setting'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: (widget.fromhome)
            ? Container()
            : Builder(
                builder: (context) => commonAppBarLeading(
                    iconData: Icons.arrow_back_ios_new,
                    onPressed: () {
                      Navigator.pop(context);
                    })),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
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
                    text: 'Personal',
                  ),
                  Tab(
                    text: 'Clinical',
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
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  Personal(),
                  Clinical(),
                  // Lifestyle()
                  // second tab bar view widget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
