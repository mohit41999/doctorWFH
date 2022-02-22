import 'package:doctor/API/api_constants.dart';
import 'package:doctor/Screens/text_page.dart';
import 'package:doctor/model/chatRooms.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colorsandstyles.dart';
import '../widgets/commonAppBarLeading.dart';
import '../widgets/common_app_bar_title.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  bool loading = true;
  late ChatRooms chatRooms;

  Future<ChatRooms> getchatrooms(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late Map<String, dynamic> response;
    await PostData(PARAM_URL: 'get_chat_user_list.php', params: {
      'token': Token,
      'doctor_id': prefs.getString('user_id'),
    }).then((value) {
      if (value['status']) {
        response = value;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value['message']),
          duration: Duration(seconds: 1),
        ));
      }
    });
    return ChatRooms.fromJson(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getchatrooms(context).then((value) {
      setState(() {
        chatRooms = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Messsages(context),
      appBar: AppBar(
        title: commonAppBarTitleText(appbarText: 'MyChats'),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
    );
  }

  Widget Messsages(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: chatRooms.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TextPage(
                                  patientid: chatRooms.data[index].userId,
                                  patientName: chatRooms.data[index].userName,
                                )));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            NetworkImage(chatRooms.data[index].profileImage)),
                    title: Text(
                      chatRooms.data[index].userName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    subtitle: Text(
                      chatRooms.data[index].message,
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: CircleAvatar(
                      radius: 4,
                      backgroundColor: apptealColor,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
