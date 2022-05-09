import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/title_enter_field.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: commonAppBarTitleText(appbarText: 'Account Setting'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              TitleEnterField('Enter Old Password', 'Change Password', oldPass),
              TitleEnterField('Enter New Password', 'New Password', newPass),
              TitleEnterField(
                  'Enter Payment gateway ID', 'Payment gateway ID', newPass),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Deactivate Account',
                    style: GoogleFonts.montserrat(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  EdgeInsets.only(left: 8.0, right: 8.0, bottom: navbarht + 20),
              child: commonBtn(
                s: 'Submit  ',
                bgcolor: appblueColor,
                textColor: Colors.white,
                onPressed: () {},
                borderRadius: 8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
