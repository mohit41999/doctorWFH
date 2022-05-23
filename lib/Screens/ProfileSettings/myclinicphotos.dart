import 'dart:convert';

import 'package:doctor/API/api_constants.dart';
import 'package:doctor/model/clinicImages.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClinicImages().then((value) {
      setState(() {
        clinicImages = value;
        loading = false;
      });
    });
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
                                  Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
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
}
