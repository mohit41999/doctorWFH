import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Utils/progress_view.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/helper/helperfunctions.dart';
import 'package:doctor/model/ask_question_list_model.dart';
import 'package:doctor/model/question_description_model.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/title_enter_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/Screens/MYScreens/MyReviewRating.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiveAnswerScreen extends StatefulWidget {
  final String question_id;
  const GiveAnswerScreen({Key? key, required this.question_id})
      : super(key: key);

  @override
  _GiveAnswerScreenState createState() => _GiveAnswerScreenState();
}

class _GiveAnswerScreenState extends State<GiveAnswerScreen> {
  var user_id;
  TextEditingController answerController = TextEditingController();
  late QuestionDescriptionAnswerModel questionsDescriptions;
  Future<QuestionDescriptionAnswerModel> getQuestionsDescription() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('user_id');
    var response =
        await PostData(PARAM_URL: 'get_question_answers.php', params: {
      'token': Token,
      'doctor_id': preferences.getString('user_id'),
      'question_id': widget.question_id
    });
    return QuestionDescriptionAnswerModel.fromJson(response);
  }

  Future submitAnswer() async {
    if (answerController.text.isEmpty) {
      setState(() {
        giveAnswer = false;
      });
    } else {
      var loader = ProgressView(context);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      loader.show();
      var response =
          await PostData(PARAM_URL: 'add_question_answer.php', params: {
        'token': Token,
        'doctor_id': preferences.getString('user_id'),
        'question_id': widget.question_id,
        'answer': answerController.text
      });
      loader.dismiss();
      if (response['status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Answer Submitted Successfully'),
          backgroundColor: apptealColor,
        ));
        setState(() {
          giveAnswer = false;
          answerController.clear();
          getQuestionsDescription().then((value) {
            setState(() {
              questionsDescriptions = value;
            });
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Try again later'),
          backgroundColor: Colors.red,
        ));
        setState(() {
          giveAnswer = false;
        });
      }
    }
  }

  Future report(String answer_id) async {
    var loader = ProgressView(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loader.show();
    var response;
    try {
      response = await PostData(PARAM_URL: "report_answer.php", params: {
        'token': Token,
        'doctor_id': prefs.getString('user_id'),
        'answer_id': answer_id
      });

      loader.dismiss();
      if (response['status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Reported Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Try again later'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      loader.dismiss();
      print(e);
    }
    return response;
  }

  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestionsDescription().then((value) {
      setState(() {
        questionsDescriptions = value;
        loading = false;
      });
    });
  }

  bool giveAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'Patient Questions'),
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
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Question'),
                              Text(
                                questionsDescriptions.data[0].questoin,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Question Description'),
                              Text(
                                questionsDescriptions.data[0].description,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                questionsDescriptions.data[0].answers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                    left: 8,
                                    right: 8,
                                    bottom: 8,
                                  ),
                                  child: Card(
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                questionsDescriptions.data[0]
                                                    .answers[index].doctorName,
                                                style: GoogleFonts.lato(
                                                    color: Color(0xff252525),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '  ${questionsDescriptions.data[0].answers[index].date.day}/${questionsDescriptions.data[0].answers[index].date.month}/${questionsDescriptions.data[0].answers[index].date.year}',
                                                style: GoogleFonts.lato(
                                                    color: apptealColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            questionsDescriptions
                                                .data[0].answers[index].answer,
                                            style:
                                                GoogleFonts.lato(fontSize: 12),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  questionsDescriptions.data[0]
                                                      .answers[index].answerId,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 12),
                                                ),
                                              ),
                                              (user_id ==
                                                      questionsDescriptions
                                                          .data[0]
                                                          .answers[index]
                                                          .doctor_id)
                                                  ? SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        reportDialog(
                                                            questionsDescriptions
                                                                .data[0]
                                                                .answers[index]
                                                                .answerId);
                                                      },
                                                      child: Text(
                                                        'Report',
                                                        style: GoogleFonts.lato(
                                                            fontSize: 12,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: navbarht + 20,
                        )
                      ],
                    ),
                  ),
                ),
                (giveAnswer)
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minHeight: 10, maxHeight: 150),
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  controller: answerController,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: null,

                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  // validator: validator,
                                  // maxLength: maxLength,
                                  // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                                  enableSuggestions: true,

                                  decoration: InputDecoration(
                                    enabled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: new BorderSide(
                                            color: Colors.transparent)),
                                    border: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: new BorderSide(
                                            color: Colors.transparent)),
                                    // enabledBorder: InputBorder.none,
                                    // errorBorder: InputBorder.none,
                                    // disabledBorder: InputBorder.none,
                                    filled: true,
                                    //labelText: labelText,

                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle: TextStyle(
                                        fontSize: 12, color: Colors.grey),

                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: commonBtn(
                                s: 'GiveAnswer',
                                borderRadius: 10,
                                bgcolor: apptealColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    submitAnswer();
                                  });
                                }),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: commonBtn(
                            s: 'GiveAnswer',
                            borderRadius: 10,
                            bgcolor: apptealColor,
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                giveAnswer = true;
                              });
                            }),
                      ),
                SizedBox(
                  height: navbarht + 20,
                )
              ],
            ),
    );
  }

  Future reportDialog(String answer_id) async {
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are you sure you want to report ?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonBtn(
                        width: 100,
                        s: 'No',
                        bgcolor: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          Pop(context);
                        }),
                    commonBtn(
                        width: 100,
                        s: 'Yes',
                        bgcolor: Colors.green,
                        textColor: Colors.white,
                        onPressed: () async {
                          await report(answer_id);
                          questionsDescriptions =
                              await getQuestionsDescription();

                          Pop(context);
                          setState(() {});
                        }),
                  ],
                )
              ],
            ));
  }
}
