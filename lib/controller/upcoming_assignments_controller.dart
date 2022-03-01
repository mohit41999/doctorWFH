import 'package:doctor/API/api_constants.dart';
import 'package:doctor/model/upcoming_assignmentsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpcomingAssignmentsController {
  late UpcomingAssignmentsModel data;
  Future<UpcomingAssignmentsModel> getUpcomingAssignments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_upcoming_booking.php',
        params: {'token': Token, 'doctor_id': prefs.getString('user_id')});
    return UpcomingAssignmentsModel.fromJson(response);
  }
}
