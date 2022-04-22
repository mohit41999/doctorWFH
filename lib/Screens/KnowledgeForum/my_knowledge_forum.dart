import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/KnowledgeForum/add_knowledge_forum.dart';
import 'package:doctor/Screens/KnowledgeForum/knowledge_description_screen.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/model/my_knowledge_forum_model.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/Screens/MYScreens/MyReviewRating.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyKnowledgeForum extends StatefulWidget {
  const MyKnowledgeForum({Key? key}) : super(key: key);

  @override
  _MyKnowledgeForumState createState() => _MyKnowledgeForumState();
}

class _MyKnowledgeForumState extends State<MyKnowledgeForum> {
  late MyKnowledgeForumModel data;
  bool loading = true;
  Future<MyKnowledgeForumModel> getMyForums() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(PARAM_URL: 'my_knowledge_forum.php', params: {
      'token': Token,
      'doctor_id': prefs.getString('user_id'),
    });

    return MyKnowledgeForumModel.fromJson(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyForums().then((value) {
      setState(() {
        data = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: commonAppBarTitleText(appbarText: 'My Knowledge Forum'),
          backgroundColor: appAppBarColor,
          elevation: 0,
          leading: Builder(
              builder: (context) => commonAppBarLeading(
                  iconData: Icons.arrow_back_ios_new,
                  onPressed: () {
                    Navigator.pop(context);
                  })),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: commonBtn(
                    s: 'Add Knowledge Forum',
                    bgcolor: appblueColor,
                    textColor: Colors.white,
                    borderRadius: 5,
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddKnowledgeForum()))
                          .then((value) {
                        getMyForums().then((value) {
                          setState(() {
                            data = value;
                            print('hello');
                          });
                        });
                      });
                    }),
              ),
              (loading)
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: data.data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Push(
                                context,
                                KnowledgeDescription(
                                    forum_id: data.data[index].forumId));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8.0,
                                left: 8,
                                right: 8,
                                bottom: (index + 1 == data.data.length)
                                    ? navbarht + 20
                                    : 8),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.data[index].knowledgeTitle,
                                          style: GoogleFonts.lato(
                                              color: Color(0xff252525),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data.data[index].date.day.toString() +
                                              '/' +
                                              data.data[index].date.month
                                                  .toString() +
                                              '/' +
                                              data.data[index].date.year
                                                  .toString(),
                                          style: GoogleFonts.lato(
                                              color: apptealColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
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
        ));
  }
}
