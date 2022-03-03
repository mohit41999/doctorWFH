import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctor/widgets/title_column.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRevenue extends StatefulWidget {
  const MyRevenue({Key? key}) : super(key: key);

  @override
  _MyRevenueState createState() => _MyRevenueState();
}

class _MyRevenueState extends State<MyRevenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: commonAppBarTitleText(
          appbarText: 'My Revenue',
        ),
        centerTitle: true,
        backgroundColor: appAppBarColor,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            height: 50,
            child: Center(
              child: Text(
                'Transaction History',
                style: GoogleFonts.montserrat(
                    color: appblueColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                      bottom: (index + 1 == 15) ? navbarht + 20 : 10,
                      top: 10.0),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8),
                      child: Container(
                        height: 86,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  titleColumn(
                                      title: 'Transaction Id',
                                      value: '99563281201'),
                                  titleColumn(
                                      title: 'Order Id / Service Id',
                                      value: '1543679284'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  titleColumn(
                                      title: 'Transaction Date',
                                      value: '27/09/2021'),
                                  titleColumn(
                                      title: 'Transaction Amount',
                                      value: '\$199'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}
