import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/AGORA/video_call.dart';
import 'package:doctor/Screens/pdf.dart';
import 'package:doctor/Screens/text_page.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/Utils/progress_view.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/firebase/notification_handling.dart';
import 'package:doctor/helper/constants.dart';
import 'package:doctor/helper/helperfunctions.dart';
import 'package:doctor/model/view_booking_details.dart';
import 'package:doctor/services/database.dart';
import 'package:doctor/views/chat.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/doctor_profile_row.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientBookingDetails extends StatefulWidget {
  final String booking_id;
  const PatientBookingDetails({Key? key, required this.booking_id})
      : super(key: key);

  @override
  _PatientBookingDetailsState createState() => _PatientBookingDetailsState();
}

class _PatientBookingDetailsState extends State<PatientBookingDetails> {
  Color textColor = Color(0xff161616);
  List patientReports = [];
  bool loading = true;
  TextEditingController _controller = TextEditingController();
  late ViewBookingDetails patientdetails;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  DatabaseMethods databaseMethods = DatabaseMethods();

  sendMessage(String userName) async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    List<String> users = [Constants.myName, userName];
    print('oo');
    print(Constants.myName);
    String chatRoomId = getChatRoomId(Constants.myName, userName);
    print('aa');
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                )));
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails('channel id', 'channel name',
        channelDescription: 'channel description',
        priority: Priority.high,
        importance: Importance.max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess
            ? 'File has been downloaded successfully!'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
        DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile(String pdfUrl) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    Dio dio = Dio();

    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }
      var savepath = dirloc + convertCurrentDateTimeToString() + ".pdf";

      try {
        FileUtils.mkdir([dirloc]);
        var response = await dio.download(pdfUrl, savepath,
            onReceiveProgress: (receivedBytes, totalBytes) {
          print('here 1');
          setState(() {
            downloading = true;
            progress =
                ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
            print(progress);
          });
          print('here 2');
        });
        result['isSuccess'] = response.statusCode == 200;
        result['filePath'] = savepath;
      } catch (e) {
        print('catch catch catch');
        result['error'] = e.toString();
        print(e);
      } finally {
        await _showNotification(result);
      }

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        path = savepath;
      });
      print(path);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Download Complete'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonBtn(
                          height: 40,
                          borderRadius: 5,
                          width: 90,
                          textSize: 12,
                          s: 'Close',
                          bgcolor: apptealColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Pop(context);
                          }),
                      commonBtn(
                          height: 40,
                          textSize: 12,
                          borderRadius: 5,
                          width: 90,
                          s: 'Open',
                          bgcolor: appblueColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                            Push(context, OpenPdf(url: path));
                          })
                    ],
                  ),
                ],
              ));
      print('here give alert-->completed');
    } else {
      setState(() {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile(pdfUrl);
        };
      });
    }
  }

  void _onSelectNotification(String? json) async {
    final obj = jsonDecode(json!);

    if (obj['isSuccess']) {
      print(obj['filePath'] + 'lllll');
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    getPatientReports().then((value) {
      setState(() {
        (value['data'] == null)
            ? patientReports = []
            : patientReports = value['data'];
      });
    });
    getDetails().then((value) {
      setState(() {
        patientdetails = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // patientReports.forEach((element) {
    //   if (element['reportfile'].toString() == '') {
    //     patientReports.remove(element);
    //   }
    // });
    return Scaffold(
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : (downloading)
              ? Center(
                  child: Container(
                    height: 120.0,
                    width: 200.0,
                    child: Card(
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Downloading File: $progress',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 260,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(patientdetails
                                        .data.patientPersonal.patientImage),
                                    fit: BoxFit.cover)),
                          ),
                          // Container(
                          //   height: 50,
                          //   width: double.infinity,
                          //   color: Colors.white,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 20.0, top: 10),
                          //     child: Text(
                          //       patientdetails.data.patientPersonal.patientName
                          //           .toUpperCase(),
                          //       style: GoogleFonts.montserrat(
                          //           fontSize: 20,
                          //           color: appblueColor,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 12,
                          // ),
                          (patientdetails.data.bookingDetails.bookingFor ==
                                  'Relative')
                              ? Container(
                                  height: 350,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Patient Details',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              color: textColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: textColor.withOpacity(0.4),
                                          thickness: 1,
                                        ),
                                        doctorProfileRow(
                                          title: 'Name',
                                          value: patientdetails.data
                                              .relativeInformatoin.relativeName
                                              .toUpperCase(),
                                        ),
                                        doctorProfileRow(
                                          title: 'Age',
                                          value: patientdetails.data
                                              .relativeInformatoin.relativeAge,
                                        ),
                                        // doctorProfileRow(
                                        //   title: 'Contact no.',
                                        //   value: patientdetails
                                        //       .data.patientPersonal.patientNo,
                                        // ),
                                        // doctorProfileRow(
                                        //   title: 'Address',
                                        //   value: patientdetails
                                        //       .data.relativeInformatoin.,
                                        // ),
                                        doctorProfileRow(
                                          title: 'Blood Group',
                                          value: patientdetails
                                              .data
                                              .relativeInformatoin
                                              .relativeBloodGroup,
                                        ),
                                        doctorProfileRow(
                                          title: 'Gender',
                                          value: patientdetails
                                              .data
                                              .relativeInformatoin
                                              .relativeGender,
                                        ),
                                        doctorProfileRow(
                                          title: 'Marital Status',
                                          value: patientdetails
                                              .data
                                              .relativeInformatoin
                                              .relativeMaritalStatus,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 350,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Patient Details',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              color: textColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: textColor.withOpacity(0.4),
                                          thickness: 1,
                                        ),
                                        doctorProfileRow(
                                          title: 'Name',
                                          value: patientdetails
                                              .data.patientPersonal.patientName
                                              .toUpperCase(),
                                        ),
                                        doctorProfileRow(
                                          title: 'Age',
                                          value: patientdetails
                                              .data.patientPersonal.patientAge,
                                        ),
                                        // doctorProfileRow(
                                        //   title: 'Contact no.',
                                        //   value: patientdetails
                                        //       .data.patientPersonal.patientNo,
                                        // ),
                                        doctorProfileRow(
                                          title: 'Address',
                                          value: patientdetails.data
                                              .patientPersonal.patientAddress,
                                        ),
                                        doctorProfileRow(
                                          title: 'Blood Group',
                                          value: patientdetails
                                              .data
                                              .patientPersonal
                                              .patientBloodGroup,
                                        ),
                                        doctorProfileRow(
                                          title: 'Gender',
                                          value: patientdetails.data
                                              .patientPersonal.patientGender,
                                        ),
                                        doctorProfileRow(
                                          title: 'Marital Status',
                                          value: patientdetails
                                              .data
                                              .patientPersonal
                                              .patientMaritalStatus,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 400,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Booking Details',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    color: textColor.withOpacity(0.4),
                                    thickness: 1,
                                  ),
                                  doctorProfileRow(
                                    title: 'Booking ID',
                                    value: patientdetails
                                        .data.bookingDetails.bookingId,
                                  ),
                                  doctorProfileRow(
                                    title: 'Status',
                                    value: patientdetails
                                        .data.bookingDetails.bookingStatus,
                                  ),
                                  doctorProfileRow(
                                    title: 'Appointment Date',
                                    value: patientdetails
                                        .data.bookingDetails.appointmentDate,
                                  ),
                                  doctorProfileRow(
                                    title: 'Appointment Time',
                                    value: patientdetails
                                        .data.bookingDetails.appointmentTime,
                                  ),
                                  doctorProfileRow(
                                    title: 'Booking Date',
                                    value: patientdetails
                                        .data.bookingDetails.bookingDate,
                                  ),
                                  doctorProfileRow(
                                    title: 'Booking Time',
                                    value: patientdetails
                                        .data.bookingDetails.bookingTime,
                                  ),
                                  doctorProfileRow(
                                    title: 'Appointment Status',
                                    value: patientdetails
                                        .data.bookingDetails.bookingStatus,
                                  ),
                                  (patientdetails
                                              .data.bookingDetails.bookingFor ==
                                          'Relative')
                                      ? doctorProfileRow(
                                          title: 'Booking For',
                                          value: patientdetails
                                              .data.bookingDetails.bookingFor,
                                        )
                                      : const SizedBox(
                                          height: 0,
                                        ),
                                  doctorProfileRow(
                                    title: 'Fees',
                                    value:
                                        patientdetails.data.bookingDetails.fees,
                                  ),
                                  doctorProfileRow(
                                    title: 'Payment Status',
                                    value: patientdetails
                                        .data.bookingDetails.paymentStatus,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            height: 200,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Patient Document And Comments',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    color: textColor.withOpacity(0.4),
                                    thickness: 1,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          // width: MediaQuery.of(context).size.width / 5,
                                          child: Text(
                                            'Download Documnent File',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Color(0xff161616)
                                                    .withOpacity(0.6)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              (patientReports.length == 0)
                                                  ? ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'No reports available'),
                                                      backgroundColor:
                                                          appblueColor,
                                                    ))
                                                  : showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                content:
                                                                    Container(
                                                                  height:
                                                                      250.0, // Change as per your requirement
                                                                  width: 300.0,
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount: patientReports
                                                                              .length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return (patientReports[index]['reportfile'].toString() == '')
                                                                                ? Container()
                                                                                : Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            patientReports[index]['reportfile'].toString().replaceAll("http://ciam.notionprojects.tech/assets/uploaded/", ""),
                                                                                            style: GoogleFonts.montserrat(fontSize: 10),
                                                                                          ),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                            onTap: () {
                                                                                              Pop(context);
                                                                                              downloadFile(patientReports[index]['reportfile']);
                                                                                            },
                                                                                            child: Image.asset('assets/pngs/Icon feather-download.png'))
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                          }),
                                                                ),
                                                              ));
                                            },
                                            child: Row(
                                              children: [
                                                Text('-'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  // width: MediaQuery.of(context).size.width / 1.65,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Document',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 12,
                                                                color:
                                                                    apptealColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Image.asset(
                                                          'assets/pngs/Icon feather-download.png')
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Push(context, OpenPdf(url: path));
                                    },
                                    child: Text('Comments :-',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Color(0xff161616)
                                                .withOpacity(0.6))),
                                  ),
                                  Text(
                                    patientdetails
                                        .data.patientPersonal.patientComments,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Color(0xff161616),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 12,
                          ),
                          (patientdetails.data.bookingDetails.bookingFor ==
                                  'Relative')
                              ? Container()
                              : Container(
                                  height: 450,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'LifeStyle And Clinical Details',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              color: textColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: textColor.withOpacity(0.4),
                                          thickness: 1,
                                        ),

                                        doctorProfileRow(
                                          title: 'Alcohol Consumption',
                                          value: patientdetails.data
                                              .patientLifestyle.patientAlchol,
                                        ),
                                        doctorProfileRow(
                                          title: 'Smoking Consumption',
                                          value: patientdetails.data
                                              .patientLifestyle.patientSmoking,
                                        ),
                                        doctorProfileRow(
                                          title: 'Workout',
                                          value: patientdetails
                                              .data
                                              .patientLifestyle
                                              .patientWorkoutLevel,
                                        ),
                                        doctorProfileRow(
                                          title: 'Sports',
                                          value: patientdetails
                                              .data
                                              .patientLifestyle
                                              .patientSportsInvolvement,
                                        ),
                                        Divider(),
                                        doctorProfileRow(
                                          title: 'Allergies',
                                          value: patientdetails.data
                                              .patientMedical.patientAllergies
                                              .toString(),
                                        ),
                                        doctorProfileRow(
                                          title: 'Chronic Diseases',
                                          value: patientdetails
                                              .data
                                              .patientMedical
                                              .patientChronicDisease
                                              .toString(),
                                        ),
                                        doctorProfileRow(
                                          title: 'Medication',
                                          value: patientdetails.data
                                              .patientMedical.patientMedication
                                              .toString(),
                                        ),
                                        doctorProfileRow(
                                          title: 'Injury',
                                          value: patientdetails
                                              .data
                                              .patientMedical
                                              .patientSurgeryInjury
                                              .toString(),
                                        ),

                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Container(
                                        //       width:
                                        //           MediaQuery.of(context).size.width / 5,
                                        //       child: Text(
                                        //         'Amount Status',
                                        //         style: GoogleFonts.montserrat(
                                        //             fontSize: 12,
                                        //             color: Color(0xff161616)
                                        //                 .withOpacity(0.6)),
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 15,
                                        //     ),
                                        //     Text('-'),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     Container(
                                        //       width: MediaQuery.of(context).size.width /
                                        //           1.65,
                                        //       child: Row(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.spaceBetween,
                                        //         children: [
                                        //           Text(
                                        //             'Pending',
                                        //             style: GoogleFonts.montserrat(
                                        //                 fontSize: 12,
                                        //                 color: Color(0xff161616),
                                        //                 fontWeight: FontWeight.bold),
                                        //           ),
                                        //           commonBtn(
                                        //             s: 'Pay Now',
                                        //             bgcolor: appblueColor,
                                        //             textColor: Colors.white,
                                        //             onPressed: () {},
                                        //             width: 153,
                                        //             height: 30,
                                        //             textSize: 12,
                                        //             borderRadius: 0,
                                        //           )
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Container(
                                        //       width:
                                        //           MediaQuery.of(context).size.width / 5,
                                        //       child: Text(
                                        //         'Upload Document',
                                        //         style: GoogleFonts.montserrat(
                                        //             fontSize: 12,
                                        //             color: Color(0xff161616)
                                        //                 .withOpacity(0.6)),
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 15,
                                        //     ),
                                        //     Text('-'),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     Container(
                                        //       width: MediaQuery.of(context).size.width /
                                        //           1.65,
                                        //       child: Row(
                                        //         children: [
                                        //           Padding(
                                        //             padding: const EdgeInsets.only(
                                        //                 right: 10.0),
                                        //             child: Text(
                                        //               'Document',
                                        //               style: GoogleFonts.montserrat(
                                        //                   fontSize: 12,
                                        //                   color: apptealColor,
                                        //                   fontWeight: FontWeight.bold),
                                        //             ),
                                        //           ),
                                        //           Image.asset(
                                        //               'assets/pngs/Icon feather-download.png')
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Container(
                                        //       width:
                                        //           MediaQuery.of(context).size.width / 5,
                                        //       child: Text(
                                        //         'Download Report File',
                                        //         style: GoogleFonts.montserrat(
                                        //             fontSize: 12,
                                        //             color: Color(0xff161616)
                                        //                 .withOpacity(0.6)),
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 15,
                                        //     ),
                                        //     Text('-'),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     Container(
                                        //       width: MediaQuery.of(context).size.width /
                                        //           1.65,
                                        //       child: Row(
                                        //         children: [
                                        //           Padding(
                                        //             padding: const EdgeInsets.only(
                                        //                 right: 10.0),
                                        //             child: Text(
                                        //               'Report',
                                        //               style: GoogleFonts.montserrat(
                                        //                   fontSize: 12,
                                        //                   color: apptealColor,
                                        //                   fontWeight: FontWeight.bold),
                                        //             ),
                                        //           ),
                                        //           Image.asset(
                                        //               'assets/pngs/Icon feather-download.png')
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                          Container(
                            color: Colors.white,
                            height: reportList.isEmpty ? 200 : 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  commonBtn(
                                    borderColor: apptealColor,
                                    borderWidth: 2,
                                    s: 'Add Report',
                                    bgcolor: Colors.white,
                                    textColor: apptealColor,
                                    onPressed: () {
                                      pickFile();
                                    },
                                    borderRadius: 10,
                                  ),
                                  (reportList.length == 0)
                                      ? Container()
                                      : Column(
                                          children: [
                                            Container(
                                              height: 100,
                                              child: ListView.builder(
                                                  itemCount: reportList.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Text('Report ' +
                                                        index.toString());
                                                  }),
                                            ),
                                            commonBtn(
                                                borderColor: appblueColor,
                                                borderWidth: 2,
                                                borderRadius: 10,
                                                s: 'Upload',
                                                bgcolor: Colors.white,
                                                textColor: appblueColor,
                                                onPressed: () {
                                                  submitmultiple()
                                                      .then((value) {
                                                    setState(() {
                                                      reportList = [];
                                                    });
                                                  });
                                                })
                                          ],
                                        ),
                                  commonBtn(
                                    s: 'Chat',
                                    bgcolor: Colors.white,
                                    textColor: apptealColor,
                                    onPressed: () {
                                      Push(
                                          context,
                                          TextPage(
                                              patientid: patientdetails.data
                                                  .patientPersonal.patientId,
                                              patientName: patientdetails
                                                  .data
                                                  .patientPersonal
                                                  .patientName));
                                    },
                                    height: 45,
                                    borderRadius: 8,
                                    borderColor: apptealColor,
                                    borderWidth: 2,
                                  ),

                                  commonBtn(
                                    s: 'Start Video',
                                    bgcolor: appblueColor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      FirebaseNotificationHandling()
                                          .sendNotification(
                                              user_id: patientdetails.data
                                                  .patientPersonal.patientId)
                                          .then((value) {
                                        if (!value['status']) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: value['message']));
                                        } else {
                                          Push(
                                              context,
                                              VideoCallPage(
                                                channelName: value['data']
                                                    ['Channel Name'],
                                              ));
                                        }
                                      });
                                    },
                                    height: 45,
                                    borderRadius: 8,
                                  )
                                  // : commonBtn(
                                  //     s: 'Join Call',
                                  //     bgcolor: appblueColor,
                                  //     textColor: Colors.white,
                                  //     height: 45,
                                  //     borderRadius: 8,
                                  //     onPressed: () {
                                  //       Push(
                                  //           context,
                                  //           VideoCallPage(
                                  //             channelName: channelName,
                                  //           ));
                                  //     }),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 40),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: appblueColor,
                                size: 20,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(2, 5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
    );
  }

  Future<ViewBookingDetails> getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_patient_view_booking_details.php',
        params: {
          'token': Token,
          'doctor_id': prefs.getString('user_id'),
          'booking_id': widget.booking_id
        });

    return ViewBookingDetails.fromJson(response);
  }

  Future getPatientReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: 'get_patient_reports.php', params: {
      'token': Token,
      'doctor_id': prefs.getString('user_id'),
      'booking_id': widget.booking_id
    });

    return response;
  }

  Future submitmultiple() async {
    for (int i = 0; i < reportList.length; i++) {
      uploadMultiple(i);
    }
  }

  Future uploadMultiple(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loader = ProgressView(context);
    loader.show();
    // if user don't pick any thi
    await PostDataWithImage(
            PARAM_URL: 'upload_patient_report.php',
            params: {
              'token': Token,
              'doctor_id': prefs.getString('user_id')!,
              'patient_id': patientdetails.data.patientPersonal.patientId,
              'booking_id': widget.booking_id,
            },
            imagePath: reportList[i].path.toString(),
            imageparamName: 'doctor_report')
        .then((value) {
      loader.dismiss();
      value['status']
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Report uploaded successfully'),
              backgroundColor: apptealColor,
            ))
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Report was not uploaded, try again later'),
              backgroundColor: Colors.red,
            ));
    });
  }

  List<File> reportList = [];
  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
        ]);
    if (result == null) {
      return;
    } else {
      setState(() {
        reportList = result.paths.map((path) => File(path!)).toList();
      });
    }
    // ng then do nothing just return.
  }
}
