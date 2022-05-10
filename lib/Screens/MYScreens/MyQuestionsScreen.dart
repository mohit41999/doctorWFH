import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/give_answer_answer.dart';
import 'package:doctor/helper/helperfunctions.dart';
import 'package:doctor/model/ask_question_list_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/Screens/MYScreens/MyReviewRating.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientQuestionsScreen extends StatefulWidget {
  const PatientQuestionsScreen({Key? key}) : super(key: key);

  @override
  _PatientQuestionsScreenState createState() => _PatientQuestionsScreenState();
}

class _PatientQuestionsScreenState extends State<PatientQuestionsScreen> {
  TextEditingController searchController = TextEditingController();
  late AskQuestionModel patientQuestions;
  Future<AskQuestionModel> getPatientQuestions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(PARAM_URL: 'get_ask_question.php', params: {
      'token': Token,
      'doctor_id': preferences.getString('user_id'),
    });
    return AskQuestionModel.fromJson(response);
  }

  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPatientQuestions().then((value) {
      setState(() {
        patientQuestions = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              minHeight: 10,
                              maxHeight: 60,
                              maxWidth: double.maxFinite),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(2, 5),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              // validator: validator,
                              // maxLength: maxLength,
                              // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                              enableSuggestions: true,
                              controller: searchController,
                              onChanged: (v) {
                                setState(() {});
                              },

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
                                  labelStyle: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.6)),
                                  hintStyle: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.6)),
                                  fillColor: Colors.white,
                                  hintText: 'Search',
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: patientQuestions.data.length,
                                itemBuilder: (context, index) {
                                  return (searchController.text.isEmpty)
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GiveAnswerScreen(
                                                            question_id:
                                                                patientQuestions
                                                                    .data[index]
                                                                    .questionId)));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0,
                                                left: 8,
                                                right: 8,
                                                bottom: (index + 1 ==
                                                        patientQuestions
                                                            .data.length)
                                                    ? navbarht + 20
                                                    : 8),
                                            child: Card(
                                              elevation: 5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          patientQuestions
                                                              .data[index]
                                                              .question,
                                                          style: GoogleFonts.lato(
                                                              color: Color(
                                                                  0xff252525),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          '  ${patientQuestions.data[index].createdDate.day}/${patientQuestions.data[index].createdDate.month}/${patientQuestions.data[index].createdDate.year}',
                                                          style: GoogleFonts.lato(
                                                              color:
                                                                  apptealColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Category:- ',
                                                          style: GoogleFonts.lato(
                                                              color: Color(
                                                                  0xff252525),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          patientQuestions
                                                                  .data[index]
                                                                  .category_name ??
                                                              '',
                                                          style: GoogleFonts.lato(
                                                              color: Color(
                                                                  0xff252525),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      patientQuestions
                                                          .data[index]
                                                          .description,
                                                      style: GoogleFonts.lato(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : (patientQuestions.data[index].question
                                                  .toLowerCase()
                                                  .replaceAll(' ', '')
                                                  .contains(searchController
                                                      .text
                                                      .toLowerCase()
                                                      .replaceAll(' ', '')) ||
                                              patientQuestions
                                                  .data[index].description
                                                  .toLowerCase()
                                                  .replaceAll(' ', '')
                                                  .contains(searchController
                                                      .text
                                                      .toLowerCase()
                                                      .replaceAll(' ', '')))
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GiveAnswerScreen(
                                                                question_id:
                                                                    patientQuestions
                                                                        .data[
                                                                            index]
                                                                        .questionId)));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: (index + 1 ==
                                                            patientQuestions
                                                                .data.length)
                                                        ? navbarht + 20
                                                        : 8),
                                                child: Card(
                                                  elevation: 5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              patientQuestions
                                                                  .data[index]
                                                                  .question,
                                                              style: GoogleFonts.lato(
                                                                  color: Color(
                                                                      0xff252525),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              '  ${patientQuestions.data[index].createdDate.day}/${patientQuestions.data[index].createdDate.month}/${patientQuestions.data[index].createdDate.year}',
                                                              style: GoogleFonts.lato(
                                                                  color:
                                                                      apptealColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Category:- ',
                                                              style: GoogleFonts.lato(
                                                                  color: Color(
                                                                      0xff252525),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              patientQuestions
                                                                      .data[
                                                                          index]
                                                                      .category_name ??
                                                                  '',
                                                              style: GoogleFonts.lato(
                                                                  color: Color(
                                                                      0xff252525),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          patientQuestions
                                                              .data[index]
                                                              .description,
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 12),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container();
                                }),
                            SizedBox(
                              height: navbarht + 20,
                            ),
                            SizedBox(
                              height: navbarht + 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
