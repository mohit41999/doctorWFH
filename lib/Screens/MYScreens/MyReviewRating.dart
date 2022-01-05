import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyReviewRatingsScreen extends StatefulWidget {
  const MyReviewRatingsScreen({Key? key}) : super(key: key);

  @override
  _MyReviewRatingsScreenState createState() => _MyReviewRatingsScreenState();
}

class _MyReviewRatingsScreenState extends State<MyReviewRatingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: commonAppBarTitleText(appbarText: 'My Reviews And Ratings'),
          backgroundColor: appAppBarColor,
          elevation: 0,
          leading: Builder(
              builder: (context) => commonAppBarLeading(
                  iconData: Icons.arrow_back_ios_new,
                  onPressed: () {
                    Navigator.pop(context);
                  })),
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(),
                              title: Text('Doctor Name'),
                              subtitle: RatingBarIndicator(
                                rating: 5,
                                itemCount: 5,
                                itemSize: 15.0,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                              trailing: Text(
                                '27/09/2021',
                                style: GoogleFonts.lato(
                                    color: apptealColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea.',
                              style: GoogleFonts.lato(fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
