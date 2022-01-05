import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Utils/progress_view.dart';
import 'package:doctor/controller/doctor_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/widgets/title_enter_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  DoctorProfileController _con = DoctorProfileController();

  initialize() {
    _con.getDocPersonalProfile().then((value) {
      setState(() {
        _con.firstname.text = value.data.firstName;
        _con.lastname.text = value.data.lastName;
        _con.education.text = value.data.education;
        _con.languageSpoken.text = value.data.languageSpoken;
        _con.totalexp.text = value.data.experience;
        _con.address.text = value.data.address;
      });
    });
  }

  Future submit() async {
    var loader = await ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'update_doctor_personal_details.php',
        params: {
          'token': Token,
          'doctor_id': prefs.getString('user_id'),
          'first_name': _con.firstname.text,
          'last_name': _con.lastname.text,
          'specialistid': '1',
          'education': _con.education.text,
          'language_spoken': _con.languageSpoken.text,
          'experience': _con.totalexp.text,
          'address': _con.address.text,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TitleEnterField('Firstname', 'Firstname', _con.firstname),
            TitleEnterField('Lastname', 'Lastname', _con.lastname),
            // TitleEnterField('Specialty', 'Specialty', ),
            TitleEnterField('Education', 'Education', _con.education),
            TitleEnterField('Language Spoken, Language Spoken',
                'Language Spoken', _con.languageSpoken),
            TitleEnterField('Total years of experience',
                'Total years of experience', _con.totalexp),
            TitleEnterField(
              'Address',
              'Address',
              _con.address,
              maxLines: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 130,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/pngs/Rectangle 51.png'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Update Profile',
                            style: GoogleFonts.montserrat(
                                color: Color(0xff161616).withOpacity(0.6),
                                fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: commonBtn(
                              s: 'Choose new photo',
                              bgcolor: Color(0xffB2B1B1),
                              textColor: Colors.black,
                              onPressed: () {},
                              width: 187,
                              height: 30,
                              borderRadius: 4,
                              textSize: 12,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
      ),
    );
  }
}
