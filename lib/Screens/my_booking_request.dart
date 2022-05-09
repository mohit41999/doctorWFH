import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/title_column.dart';
import 'package:flutter/material.dart';
import 'package:doctor/Screens/Home.dart';
import 'package:doctor/Screens/text_page.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';

class MyBookingRequest extends StatelessWidget {
  const MyBookingRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Messsages(context),
      appBar: AppBar(
        title: commonAppBarTitleText(appbarText: 'My Booking Request'),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
    );
  }
}

Widget Messsages(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: (index + 1 == 4) ? navbarht + 20 : 10,
                    top: 10.0),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 105,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: titleColumn(
                                      title: 'Booking Id', value: '9956328')),
                              Expanded(
                                child: titleColumn(
                                    title: 'Order Date', value: '27/09/2021'),
                              ),
                              commonBtn(
                                s: 'Accept',
                                bgcolor: appblueColor,
                                textColor: Colors.white,
                                onPressed: () {},
                                width: 85,
                                height: 30,
                                textSize: 11,
                                borderRadius: 4,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: titleColumn(
                                    title: 'Booking of',
                                    value: 'video consult'),
                              ),
                              Expanded(
                                  child: titleColumn(
                                      title: 'Booking Time', value: '02:30')),
                              commonBtn(
                                s: 'Cancel',
                                bgcolor: Colors.white,
                                textColor: Color(0xff161616),
                                onPressed: () {},
                                borderColor: Color(0xff161616),
                                borderWidth: 2,
                                width: 85,
                                height: 30,
                                textSize: 11,
                                borderRadius: 4,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ],
    ),
  );
}
