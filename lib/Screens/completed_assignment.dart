import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/pdf.dart';
import 'package:doctor/Screens/text_page.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/model/completed_assignment_model.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/title_column.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedAssignment extends StatefulWidget {
  final bool fromHome;
  const CompletedAssignment({Key? key, this.fromHome = false})
      : super(key: key);

  @override
  _CompletedAssignmentState createState() => _CompletedAssignmentState();
}

class _CompletedAssignmentState extends State<CompletedAssignment> {
  TextStyle valueStyle = GoogleFonts.montserrat(
      fontSize: 10, color: Color(0xff252525).withOpacity(0.5));
  late CompletedAssignmentModel completedAssignments;
  bool loading = true;
  List patientReports = [];
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    // TODO: implement initState

    getCompletedAssignments().then((value) {
      setState(() {
        completedAssignments = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.fromHome)
          ? AppBar(
              title: commonAppBarTitleText(
                appbarText: 'Completed Appointments',
              ),
              centerTitle: true,
              leading: commonAppBarLeading(
                  iconData: Icons.arrow_back_ios_new,
                  onPressed: () {
                    Pop(context);
                  }),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : (completedAssignments.data.length == 0)
              ? Center(
                  child: Text('No Assignments Completed Yet'),
                )
              : Stack(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: completedAssignments.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                left: 10,
                                right: 10,
                                bottom: (index + 1 ==
                                        completedAssignments.data.length)
                                    ? navbarht + 20
                                    : 10),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
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
                                                    value: completedAssignments
                                                        .data[index].bookingId),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                    title: 'Assignment Date',
                                                    value: completedAssignments
                                                        .data[index]
                                                        .appointmentDate),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text('Invoice',
                                                    style: valueStyle),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Push(
                                                            context,
                                                            OpenPdf(
                                                              url:
                                                                  completedAssignments
                                                                      .data[
                                                                          index]
                                                                      .invoice,
                                                              isnetwork: true,
                                                            ));
                                                      },
                                                      child: Icon(
                                                        FontAwesomeIcons.eye,
                                                        size: 15,
                                                        color: appblueColor,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        downloadFile(
                                                            completedAssignments
                                                                .data[index]
                                                                .invoice,
                                                            isInvoice: true);
                                                      },
                                                      child: Image.asset(
                                                          'assets/pngs/Icon feather-download.png'),
                                                    )
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
                                                    title: 'Amount paid',
                                                    value: '₹ ' +
                                                        completedAssignments
                                                            .data[index]
                                                            .ammountPaid),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text('Document',
                                                    style: valueStyle),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    getPatientReports(index)
                                                        .then((value) {
                                                      setState(() {
                                                        patientReports =
                                                            value['data'];
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      content:
                                                                          Container(
                                                                        height:
                                                                            250.0, // Change as per your requirement
                                                                        width:
                                                                            300.0,
                                                                        child: ListView.builder(
                                                                            itemCount: patientReports.length,
                                                                            shrinkWrap: true,
                                                                            itemBuilder: (context, ind) {
                                                                              return (patientReports[ind]['reportfile'].toString() == '')
                                                                                  ? Container()
                                                                                  : Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              'Report' + ind.toString(),
                                                                                              style: GoogleFonts.montserrat(fontSize: 10),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                GestureDetector(
                                                                                                    onTap: () {
                                                                                                      Push(
                                                                                                          context,
                                                                                                          OpenPdf(
                                                                                                            url: patientReports[ind]['reportfile'].toString(),
                                                                                                            isnetwork: true,
                                                                                                          ));
                                                                                                    },
                                                                                                    child: Icon(
                                                                                                      FontAwesomeIcons.eye,
                                                                                                      size: 20,
                                                                                                      color: appblueColor,
                                                                                                    )),
                                                                                              ],
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
                                                      });
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                bottomRight:
                                                    Radius.circular(15)),
                                          ))),
                                      onPressed: () {
                                        Push(
                                          context,
                                          TextPage(
                                              patientid: completedAssignments
                                                  .data[index].patientId,
                                              patientName: completedAssignments
                                                  .data[index].patient_name),
                                          withnav: false,
                                        );
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
                    (downloading)
                        ? Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.grey.withOpacity(0.5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: Text(progress)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: LinearProgressIndicator(),
                                  ),
                                ]),
                          )
                        : SizedBox()
                  ],
                ),
    );
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;

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

  Future<void> downloadFile(String pdfUrl, {bool isInvoice = false}) async {
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
      var savepath = (isInvoice)
          ? dirloc + convertCurrentDateTimeToString() + "Invoice" + ".pdf"
          : dirloc + convertCurrentDateTimeToString() + ".pdf";

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

  Future<CompletedAssignmentModel> getCompletedAssignments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: 'completed_assignment.php', params: {
      'token': Token,
      'doctor_id': prefs.getString('user_id'),
    });

    return CompletedAssignmentModel.fromJson(response);
  }

  Future getPatientReports(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: 'get_patient_reports.php', params: {
      'token': Token,
      'doctor_id': prefs.getString('user_id'),
      'booking_id': completedAssignments.data[i].bookingId
    });

    return response;
  }
}
