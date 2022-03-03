import 'dart:io';

import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/Utils/progress_view.dart';
import 'package:doctor/controller/doctor_profile_controller.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/title_enter_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Clinical extends StatefulWidget {
  const Clinical({Key? key}) : super(key: key);

  @override
  State<Clinical> createState() => _ClinicalState();
}

class _ClinicalState extends State<Clinical> {
  DoctorProfileController _con = DoctorProfileController();
  TextEditingController _clinic_name = TextEditingController();
  TextEditingController _clinic_location = TextEditingController();
  TextEditingController _offlineConsultancyFees = TextEditingController();
  TextEditingController availablestatus = TextEditingController();
  TextEditingController _fromtoTodays = TextEditingController();
  String from_to_days = 'monday to friday';
  String openTime = '';
  String closeTime = '';
  bool loading = true;
  TimeOfDay selectedOpenTime = TimeOfDay.now();
  TimeOfDay selectedCloseTime = TimeOfDay.now();
  _selectOpenTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedOpenTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedOpenTime) {
      setState(() {
        selectedOpenTime = timeOfDay;
        openTime = timeOfDay.hour.toString() +
            ':' +
            timeOfDay.minute.toString() +
            "     ";
      });
    }
  }

  List<String> images = [];

  _selectCloseTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedCloseTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedCloseTime) {
      setState(() {
        selectedCloseTime = timeOfDay;
        closeTime = timeOfDay.hour.toString() +
            ':' +
            timeOfDay.minute.toString() +
            "     ";
      });
    }
  }

  Future<void> _showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        setState(() {
                          _imgFromGallery();
                        });

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      setState(() {
                        _imgFromCamera();
                      });

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _imgFromCamera() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      images.add(image!.path);
    });
  }

  Future _imgFromGallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      images.add(image!.path);
    });
  }

  Future upload_images(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostDataWithImage(
        PARAM_URL: 'upload_clinic_images.php',
        params: {
          ''
              'token': Token,
          'doctor_id': prefs.getString('user_id')!,
        },
        imagePath: imagePath,
        imageparamName: 'image');
    return response;
  }

  initialize() {
    _con.getDocClinicProfile().then((value) {
      setState(() {
        _clinic_name.text = value.data.clinicName;
        _clinic_location.text = value.data.clinicLocation;
        _offlineConsultancyFees.text = value.data.oflineConsultancyFees;
        availablestatus.text = value.data.doctorAvailabilityStatus;
        openTime = value.data.openTime;
        closeTime = value.data.closeTime;
        _fromtoTodays.text = value.data.fromToDays;
        loading = false;
      });
    });
  }

  Future submit() async {
    var loader = await ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: 'update_doctor_clinic.php', params: {
      'token': Token,
      'doctor_id': prefs.getString('user_id'),
      'clinic_name': _clinic_name.text,
      'clinic_location': _clinic_location.text,
      'open_time': openTime,
      'close_time': closeTime,
      'ofline_consultancy_fees': _offlineConsultancyFees.text.toString(),
      'from_to_days': 'monday to friday',
      'doctor_availability_status': availablestatus.text.toString()
    });
    if (response['status']) {
      loader.dismiss();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
    } else {
      loader.dismiss();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          TitleEnterField(
            'Clinic Name',
            'Clinic Name',
            _clinic_name,
          ),
          TitleEnterField(
            'Lorem ipsum dolor sit amet, consetetur.',
            'Location of clinic',
            _clinic_location,
          ),
          // TitleEnterField(
          //   'From to To days',
          //   'From to To days',
          //   _firstname,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: (loading)
                ? Center(child: CircularProgressIndicator())
                : Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Open Time'),
                            Material(
                              color: Colors.white,
                              elevation: 2,
                              borderRadius: BorderRadius.circular(15),
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectOpenTime(context);
                                    });
                                  },
                                  child: Text(openTime)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Close Time'),
                            Material(
                              color: Colors.white,
                              elevation: 2,
                              borderRadius: BorderRadius.circular(15),
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectCloseTime(context);
                                    });
                                  },
                                  child: Text(closeTime)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          // TitleEnterField(
          //   'Open Time',
          //   'Open Time',
          //   _firstname,
          // ),
          // TitleEnterField(
          //   'Close Time',
          //   'Close Time',
          //   _firstname,
          // ),
          TitleEnterField(
            'Offline Consultancy Fees',
            'Offline Consultancy Fees',
            _offlineConsultancyFees,
          ),
          TitleEnterField(
            'From to To days',
            'From to To days',
            _fromtoTodays,
          ),
          TitleEnterField(
            'Doctor’s availability status',
            'Doctor’s availability status',
            availablestatus,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: commonBtn(
              s: 'Add Clinic photo',
              bgcolor: Color(0xffB2B1B1),
              textColor: Colors.black,
              onPressed: () {
                _showPicker(context);
              },
              width: 187,
              height: 50,
              borderRadius: 4,
              textSize: 12,
            ),
          ),
          (images.length == 0)
              ? Container()
              : Container(
                  height: 120,
                  child: ListView.builder(
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(images[index])),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      })),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: commonBtn(
              s: 'Submit',
              bgcolor: appblueColor,
              textColor: Colors.white,
              onPressed: () {
                submit().then((value) {
                  for (int i = 0; i < images.length; i++) {
                    upload_images(images[i]);
                  }
                });
              },
              borderRadius: 8,
              textSize: 20,
            ),
          ),
          SizedBox(height: navbarht + 20),
        ],
      ),
    );
  }
}
