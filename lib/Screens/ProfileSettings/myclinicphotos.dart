import 'dart:convert';

import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/model/clinicImages.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyClinicPhotos extends StatefulWidget {
  const MyClinicPhotos({Key? key}) : super(key: key);

  @override
  State<MyClinicPhotos> createState() => _MyClinicPhotosState();
}

class _MyClinicPhotosState extends State<MyClinicPhotos> {
  late ClinicImagesModel clinicImages;

  bool loading = true;
  Future<ClinicImagesModel> getClinicImages() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response = await PostData(
        PARAM_URL: 'get_doctor_clinic_images.php',
        params: {
          'doctor_id': preferences.getString('user_id'),
          'token': Token
        });

    return ClinicImagesModel.fromJson(response);
  }

  Future editPhoto(String image_id, String image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response = await PostDataWithImage(
        PARAM_URL: 'update_doctor_clinic_image.php',
        params: {
          'doctor_id': preferences.getString('user_id')!,
          'token': Token,
          'image_id': image_id
        },
        imagePath: image,
        imageparamName: 'image');

    initialize();
    return response;
  }

  Future deletePhoto(String image_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response =
        await PostData(PARAM_URL: 'remove_clinic_image.php', params: {
      'image_id': image_id,
      'doctor_id': preferences.getString('user_id'),
      'token': Token
    });
    initialize();
  }

  Future initialize() async {
    getClinicImages().then((value) {
      setState(() {
        clinicImages = value;
        loading = false;
      });
    });
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
        title: commonAppBarTitleText(appbarText: 'My Clinic Photos'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300,
                    child: Stack(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      clinicImages.data[index].image),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _showPicker(context,
                                          clinicImages.data[index].imageId);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      deletePhoto(
                                          clinicImages.data[index].imageId);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0.2)
                                ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: clinicImages.data.length,
            ),
    );
  }

  Future<void> _showPicker(context, String ImageId) async {
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
                          _imgFromGallery(ImageId);
                        });

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      setState(() {
                        _imgFromCamera(ImageId);
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

  Future _imgFromCamera(String image_id) async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      editPhoto(image_id, image!.path);
    });
  }

  Future _imgFromGallery(String image_id) async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    editPhoto(image_id, image!.path);
  }
}
