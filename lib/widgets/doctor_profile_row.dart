import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class doctorProfileRow extends StatelessWidget {
  const doctorProfileRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          // width: MediaQuery.of(context).size.width / 5,
          child: Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 12, color: Color(0xff161616).withOpacity(0.6)),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Text('-'),
              SizedBox(
                width: 10,
              ),
              Container(
                // width: MediaQuery.of(context).size.width / 1.65,
                child: Text(
                  value,
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Color(0xff161616),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
