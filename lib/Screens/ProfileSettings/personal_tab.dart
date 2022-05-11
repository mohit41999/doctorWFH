import 'dart:convert';

import 'dart:io';

import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/controller/doctor_profile_controller.dart';
import 'package:doctor/model/diseaseTreatedModel.dart';
import 'package:doctor/model/diseaseTreatedModel.dart';
import 'package:doctor/model/diseaseTreatedModel.dart';
import 'package:doctor/model/specialist_model.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/title_enter_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  DoctorProfileController _con = DoctorProfileController();
  bool loading = true;
  bool diseaseLoading = true;

  late SpecialistModel Data;
  late DiseaseTreated diseaseTreated;
  initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PostData(
            PARAM_URL: 'specialist_doctors_list.php',
            params: {'doctor_id': prefs.getString('user_id'), 'token': Token})
        .then((value) {
      setState(() {
        Data = SpecialistModel.fromJson(value);
      });
    });
    await _con.getDiseaseTreated().then((value) {
      setState(() {
        diseaseTreated = value;
        diseaseLoading = false;
      });
    });

    _con.getDocPersonalProfile().then((value) {
      setState(() {
        _con.oldname = value.data.firstName + ' ' + value.data.lastName;
        _con.email = value.data.email;
        _con.firstname.text = value.data.firstName;
        _con.lastname.text = value.data.lastName;
        _con.education.text = value.data.education;
        _con.languageSpoken.text = value.data.languageSpoken;
        _con.totalexp.text = value.data.experience;
        _con.address.text = value.data.address;
        _con.profileImage = value.data.profileImage;
        _con.about_me.text = value.data.aboutMe;
        for (int i = 0; i < diseaseTreated.data.length; i++) {
          for (int j = 0; j < value.data.diseaseArray.length; j++) {
            if (value.data.diseaseArray[j].diseaseId ==
                diseaseTreated.data[i].id) {
              setState(() {
                diseaseTreated.data[i].isSelected = true;
              });
            }
          }
        }
        _con.speciality_id = null;
        (value.data.specialistid) == '0'
            ? _con.speciality_id = null
            : _con.speciality_id = value.data.specialistid;
        loading = false;
      });
    });
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
        child: (loading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  TitleEnterField('Firstname', 'Firstname', _con.firstname),
                  TitleEnterField('Lastname', 'Lastname', _con.lastname),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Speciality',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.6))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Material(
                        elevation: 2.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        child: DropdownButton(
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          underline: Container(),
                          isExpanded: true,
                          items: Data.data.map<DropdownMenuItem<String>>(
                              (SpecialistModelData item) {
                            return DropdownMenuItem(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.specialistName),
                              ),
                              value: item.specialistId,
                            );
                          }).toList(),
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Select Speciality'),
                          ),
                          value: _con.speciality_id,
                          onChanged: (newVal) {
                            setState(() {
                              _con.speciality_id = newVal.toString();
                              print(newVal);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  TitleEnterField('Education', 'Education', _con.education),
                  TitleEnterField('Language Spoken, Language Spoken',
                      'Language Spoken', _con.languageSpoken),
                  TitleEnterField('Total years of experience',
                      'Total years of experience', _con.totalexp),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Disease Treated',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.6))),
                  ),
                  (diseaseLoading)
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: ExpansionTile(
                                collapsedIconColor: Colors.black,
                                iconColor: Colors.black,
                                title: Text(
                                  'Select Disease Treated',
                                  style: TextStyle(color: Colors.black),
                                ),
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: diseaseTreated.data.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              diseaseTreated
                                                      .data[index].isSelected =
                                                  !diseaseTreated
                                                      .data[index].isSelected;
                                            });
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Checkbox(
                                                    value: diseaseTreated
                                                        .data[index].isSelected,
                                                    onChanged: (v) {
                                                      setState(() {
                                                        diseaseTreated
                                                            .data[index]
                                                            .isSelected = v!;
                                                      });
                                                    }),
                                                Text(diseaseTreated
                                                    .data[index].diseaseName)
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ]),
                          ),
                        ),
                  TitleEnterField(
                    'Address',
                    'Address',
                    _con.address,
                    maxLines: 10,
                  ),
                  TitleEnterField(
                    'About Me',
                    'About Me',
                    _con.about_me,
                    maxLines: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 130,
                      child: Row(
                        children: [
                          (loading)
                              ? Container()
                              : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: (_con.mediaFile != null)
                                                ? FileImage(
                                                    File(_con.mediaFile!.path))
                                                : NetworkImage(
                                                        _con.profileImage)
                                                    as ImageProvider,
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
                                    onPressed: () {
                                      _showPicker(context);
                                    },
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
                        List<String> selectedData = [];
                        diseaseTreated.data.forEach((element) {
                          if (element.isSelected) {
                            selectedData.add(element.id);
                          }
                        });
                        _con.submit(context, selectedData);
                      },
                      borderRadius: 8,
                      textSize: 20,
                    ),
                  ),
                  SizedBox(height: navbarht + 20),
                ],
              ),
      ),
    );
  }

  Future<void> _showPicker(context) async {
    showModalBottomSheet(
        context: context,
        useRootNavigator: false,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: double.maxFinite,
              child: ListView(
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
                  SizedBox(
                    height: navbarht + 20,
                  )
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
      _con.mediaFile = image;
    });
  }

  Future _imgFromGallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _con.mediaFile = image;
    });
  }
}
