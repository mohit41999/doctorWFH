import 'dart:convert';

import 'dart:io';

import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/Utils/progress_view.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/controller/doctor_profile_controller.dart';
import 'package:doctor/model/specialist_model.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/title_enter_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddKnowledgeForum extends StatefulWidget {
  const AddKnowledgeForum({Key? key}) : super(key: key);

  @override
  State<AddKnowledgeForum> createState() => _AddKnowledgeForumState();
}

class _AddKnowledgeForumState extends State<AddKnowledgeForum> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future submit(BuildContext context) async {
    var loader = await ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    Map<String, String> bodyparams = {
      'token': Token,
      'doctor_id': user_id!,
      'knowledge_title': titleController.text,
      'knowledge_description': descriptionController.text,
    };

    var response = await PostData(
        PARAM_URL: 'add_knowledge_forum.php', params: bodyparams);

    loader.dismiss();
    if (response['status']) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
      Pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
      Pop(context);
    }
  }

  void validation() {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter Title'),
        backgroundColor: Colors.red,
      ));
    } else if (descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter Description'),
        backgroundColor: Colors.red,
      ));
    } else {
      submit(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: commonAppBarTitleText(appbarText: 'Add Knowledge Forum'),
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
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  TitleEnterField('Title', 'Title', titleController),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.6))),
                        SizedBox(height: 7),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 150),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: null,

                                // autovalidateMode: AutovalidateMode.onUserInteraction,
                                // validator: validator,
                                // maxLength: maxLength,
                                // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                                enableSuggestions: true,

                                controller: descriptionController,
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

                                  labelStyle: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  labelText: 'description',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,

                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15)
                      ],
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
                        validation();
                      },
                      borderRadius: 8,
                      textSize: 20,
                    ),
                  ),
                  SizedBox(height: navbarht + 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
