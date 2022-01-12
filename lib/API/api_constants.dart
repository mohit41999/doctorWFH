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

Future PostDataWithImage(
    {required String PARAM_URL,
    required Map<String, String> params,
    required String imagePath,
    required String imageparamName}) async {
  var request =
      await http.MultipartRequest('POST', Uri.parse(BASE_URL + PARAM_URL));
  request.fields.addAll(params);
  var pic = await http.MultipartFile.fromPath(imageparamName, imagePath);
  request.files.add(pic);
  var responseData = await request.send();
  // post(Uri.parse(BASE_URL + PARAM_URL), body: params);
  var response = await responseData.stream.toBytes();
  var responseString = String.fromCharCodes(response);
  // print(response.body);
  // var Response = jsonDecode(response.body);
  print('----------->' + responseString.toString());
  var finalresponse = jsonDecode(responseString);

  return finalresponse;
}

Future Getdata({required String PARAM_URL}) async {
  var response = await http.get(
    Uri.parse(BASE_URL + PARAM_URL),
  );
  print(response.body);
  var Response = jsonDecode(response.body);
  return Response;
}
