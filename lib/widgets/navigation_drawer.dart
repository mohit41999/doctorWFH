import 'package:doctor/Utils/drawerList.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/colorsandstyles.dart';
import 'package:google_fonts/google_fonts.dart';

import 'commonAppBarLeading.dart';

class commonDrawer extends StatefulWidget {
  const commonDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<commonDrawer> createState() => _commonDrawerState();
}

class _commonDrawerState extends State<commonDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xffF1F1F1),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/pngs/Rectangle 51.png'),
                          fit: BoxFit.cover)),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: drawerList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20),
                          child: GestureDetector(
                            child: Text(
                              drawerList[index]['label'],
                              style: GoogleFonts.montserrat(
                                  color: appblueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              (drawerList[index]['Screen'].toString() == 'null')
                                  ? {print('blablabla')}
                                  : Push(context, drawerList[index]['Screen']);
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 8),
                  child: commonAppBarLeading(
                      iconData: Icons.arrow_back_ios_new,
                      onPressed: () {
                        Navigator.pop(context);
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
