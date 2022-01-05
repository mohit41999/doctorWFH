import 'dart:convert';

import 'package:doctor/API/api_constants.dart';
import 'package:http/http.dart' as http;

class FirebaseNotificationHandling {
  Future sendNotification({required String user_id}) async {
    var response = await http.post(
        Uri.parse(
            'http://ciam.notionprojects.tech/api/patient/send_notification.php'),
        body: {'token': Token, 'user_id': user_id});
    print(response.body);
    var Response = jsonDecode(response.body);
    return Response;
  }
}
