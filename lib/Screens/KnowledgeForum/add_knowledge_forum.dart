import 'dart:convert';

import 'dart:io';

import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/Utils/progress_view.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/controller/doctor_profile_controller.dart';
import 'package:doctor/model/knowledge_forum_model.dart';
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
  KnowledgeForumModel? knowledgeForum;
  bool catload = true;
  var selectedCategroy;
  Future<KnowledgeForumModel?> getKnowledgeForumCategories() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var response = await PostData(
          PARAM_URL: 'get_knowledge_forum_categories.php',
          params: {
            'token': Token,
            'user_id': preferences.getString('user_id')
          });
      return KnowledgeForumModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future submit(BuildContext context) async {
    var loader = await ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    Map<String, String> bodyparams = {
      'token': Token,
      'doctor_id': user_id!,
      'category_id': selectedCategroy.toString(),
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
    if (selectedCategroy == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select Category'),
        backgroundColor: Colors.red,
      ));
    } else if (titleController.text.isEmpty) {
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
    getKnowledgeForumCategories().then((value) {
      setState(() {
        knowledgeForum = value!;
        catload = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      body: (knowledgeForum == null && catload == false)
          ? Center(child: Text('Please try again later'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        (catload)
                            ? Center(child: CircularProgressIndicator())
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2.0),
                                    child: Align(
                                      child: Text(
                                        'Category',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    child: Material(
                                      elevation: 5,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: 50,
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: double.infinity,
                                        child: DropdownButton(
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          underline: Container(),
                                          dropdownColor: Colors.white,

                                          isExpanded: true,

                                          // Initial Value
                                          hint: Text(
                                            'Select Category',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),

                                          // Array list of items
                                          items: knowledgeForum!.data.map(
                                              (KnowledgeForumModelData items) {
                                            return DropdownMenuItem(
                                              value: items.categoryId,
                                              child: Text(items.categoryName),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (newValue) {
                                            setState(() {
                                              print(newValue);
                                              selectedCategroy =
                                                  newValue.toString();
                                            });
                                          },
                                          value: selectedCategroy,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minHeight: 10, maxHeight: 150),
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: new BorderSide(
                                                color: Colors.transparent)),
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
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
