import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class commonAppBarTitle extends StatelessWidget {
  const commonAppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.045,
        child: Image(image: AssetImage('assets/pngs/logo.png')));
  }
}

class commonAppBarTitleText extends StatelessWidget {
  const commonAppBarTitleText({
    Key? key,
    required this.appbarText,
  }) : super(key: key);
  final String appbarText;
  @override
  Widget build(BuildContext context) {
    return Text(
      appbarText,
      style: GoogleFonts.montserrat(
          fontSize: 20, color: apptealColor, fontWeight: FontWeight.bold),
    );
  }
}
