import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/title_column.dart';

class CompletedAssignment extends StatefulWidget {
  const CompletedAssignment({Key? key}) : super(key: key);

  @override
  _CompletedAssignmentState createState() => _CompletedAssignmentState();
}

class _CompletedAssignmentState extends State<CompletedAssignment> {
  TextStyle valueStyle = GoogleFonts.montserrat(
      fontSize: 10, color: Color(0xff252525).withOpacity(0.5));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'Completed Assignment'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, int) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(2, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 130,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: titleColumn(
                                            title: 'Booking Id',
                                            value: '99563281201'),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Prescription',
                                          style: valueStyle,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.eye,
                                              size: 15,
                                              color: appblueColor,
                                            ),
                                            Image.asset(
                                                'assets/pngs/Icon feather-download.png')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: titleColumn(
                                            title: 'Booking Id',
                                            value: '99563281201'),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child:
                                            Text('Invoice', style: valueStyle),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.eye,
                                              size: 15,
                                              color: appblueColor,
                                            ),
                                            Image.asset(
                                                'assets/pngs/Icon feather-download.png')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: titleColumn(
                                            title: 'Booking Id',
                                            value: '99563281201'),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child:
                                            Text('Document', style: valueStyle),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.eye,
                                              size: 15,
                                              color: appblueColor,
                                            ),
                                            Image.asset(
                                                'assets/pngs/Icon feather-download.png')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          appblueColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ))),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             MyMedicineOrders()));
                              },
                              child: Text(
                                'Chat With Patient',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
