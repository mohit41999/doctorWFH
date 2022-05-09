import 'package:doctor/API/api_constants.dart';
import 'package:doctor/model/doctor_rating_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyReviewRatingsScreen extends StatefulWidget {
  const MyReviewRatingsScreen({Key? key}) : super(key: key);

  @override
  _MyReviewRatingsScreenState createState() => _MyReviewRatingsScreenState();
}

class _MyReviewRatingsScreenState extends State<MyReviewRatingsScreen> {
  bool loading = true;
  late DoctorRatings doctorRatings;
  Future<DoctorRatings> getdocReview() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    late Map<String, dynamic> response;
    await PostData(PARAM_URL: 'get_rating_reviews.php', params: {
      'token': Token,
      'doctor_id': preferences.getString('user_id')
    }).then((value) {
      response = value;
    });
    return DoctorRatings.fromJson(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdocReview().then((value) {
      setState(() {
        doctorRatings = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
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
        body: (loading)
            ? Center(child: CircularProgressIndicator())
            : (doctorRatings.data.length == 0)
                ? Text('No Reviews Yet')
                : ListView.builder(
                    itemCount: doctorRatings.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: 8.0,
                            left: 8,
                            right: 8,
                            bottom: (index + 1 == doctorRatings.data.length)
                                ? navbarht + 20
                                : 8),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                    doctorRatings.data[index].profileImage,
                                  )),
                                  title:
                                      Text(doctorRatings.data[index].userName),
                                  subtitle: RatingBarIndicator(
                                    rating: double.parse(
                                        doctorRatings.data[index].rating),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  trailing: Text(
                                    doctorRatings.data[index].date,
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
                                  doctorRatings.data[index].review,
                                  style: GoogleFonts.lato(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
  }
}
