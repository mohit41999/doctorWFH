import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Utils/progress_view.dart';
import 'package:doctor/controller/doctor_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/title_enter_field.dart';
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
  String from_to_days = 'monday to friday';
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
      });
    }
  }

  _selectCloseTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedCloseTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedCloseTime) {
      setState(() {
        selectedCloseTime = timeOfDay;
      });
    }
  }

  initialize() {
    _con.getDocClinicProfile().then((value) {
      setState(() {
        _clinic_name.text = value.data.clinicName;
        _clinic_location.text = value.data.clinicLocation;
        _offlineConsultancyFees.text = value.data.oflineConsultancyFees;
        availablestatus.text = value.data.doctorAvailabilityStatus;
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
      'open_time': '${selectedOpenTime.hour}:${selectedOpenTime.minute}:00',
      'close_time': '${selectedCloseTime.hour}:${selectedCloseTime.minute}:00',
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
            child: Row(
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
                            child: Text(selectedOpenTime.hour.toString() +
                                ':' +
                                selectedOpenTime.minute.toString())),
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
                            child: Text(selectedCloseTime.hour.toString() +
                                ':' +
                                selectedCloseTime.minute.toString())),
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
            'Doctor’s availability status',
            'Doctor’s availability status',
            availablestatus,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: commonBtn(
              s: 'Submit',
              bgcolor: appblueColor,
              textColor: Colors.white,
              onPressed: () {
                submit();
              },
              borderRadius: 8,
              textSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
