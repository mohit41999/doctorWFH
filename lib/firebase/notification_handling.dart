import 'dart:convert';

import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/AGORA/video_call.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirebaseNotificationHandling {
  Future sendNotification({required String user_id}) async {
    var response = await http.post(
        Uri.parse(
            'http://ciam.notionprojects.tech/api/doctor/send_notification.php'),
        body: {'token': Token, 'doctor_id': user_id});
    print(response.body);
    var Response = jsonDecode(response.body);
    return Response;
  }

  void setupFirebase(BuildContext context) {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((event) {
      String? channel_name = event.notification!.title.toString();
      print('onMessage ' + event.toString());
      print(event.data);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              VideoCallPage(channelName: event.data['chanel_name'])));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // String? channel_name = event.notification!.title.toString();

      print('onMessageOpenedApp');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VideoCallPage(channelName: event.data['chanel_name'])));
      // Navigator.of(context).push(
      //     context,
      //     );
      // Push(context, );
    });

    // notificationhandler(context);
  }
}
