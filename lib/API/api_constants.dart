import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String BASE_URL = 'http://ciam.notionprojects.tech/api/doctor/';
const String Token = '123456789';

Future PostData({required String PARAM_URL, required Map params}) async {
  var response = await http.post(Uri.parse(BASE_URL + PARAM_URL), body: params);
  print(response.body);
  var Response = jsonDecode(response.body);
  return Response;
}

Future PostDatawithimage(
    {required String PARAM_URL,
    required Map<String, String> params,
    required String image_path,
    required image_param_name}) async {
  var request = http.MultipartRequest("POST", Uri.parse(PARAM_URL));
  request.fields.addAll(params);
  var pic = await http.MultipartFile.fromPath("image_param_name", image_path);
  request.files.add(pic);
  request.send().then((response) {
    if (response.statusCode == 200) print("Uploaded!");
  });
}

Future Getdata({required String PARAM_URL}) async {
  var response = await http.get(
    Uri.parse(BASE_URL + PARAM_URL),
  );
  print(response.body);
  var Response = jsonDecode(response.body);
  return Response;
}
