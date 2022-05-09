// import 'package:doctor/Utils/APIIDS.dart';
// import 'package:doctor/Utils/colorsandstyles.dart';
// import 'package:doctor/controller/NavigationController.dart';
// import 'package:doctor/widgets/common_app_bar_title.dart';
// import 'package:doctor/widgets/common_button.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'AGORA/video_call.dart';
//
// class AcceptReject extends StatefulWidget {
//   const AcceptReject({Key? key, required this.channel_name}) : super(key: key);
//   final String channel_name;
//   @override
//   _AcceptRejectState createState() => _AcceptRejectState();
// }
//
// class _AcceptRejectState extends State<AcceptReject> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         title: commonAppBarTitle(),
//         backgroundColor: appAppBarColor,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Container(
//           height: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Incoming Call\n\n  ',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.montserrat(
//                               fontSize: 20,
//                               color: apptealColor,
//                               fontWeight: FontWeight.bold)),
//                       Material(
//                         elevation: 1,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             'IF you wish to Reject ... You can Join again From "My Online Consultants Page"',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   commonBtn(
//                       width: 100,
//                       borderRadius: 5,
//                       s: 'Reject',
//                       bgcolor: Colors.red,
//                       textColor: Colors.white,
//                       onPressed: () {
//                         Pop(context);
//
//                       }),
//                   commonBtn(
//                       width: 100,
//                       s: 'Accept',
//                       borderRadius: 5,
//                       bgcolor: appblueColor,
//                       textColor: Colors.white,
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => VideoCallPage(
//                                     channelName: widget.channel_name)));
//                       }),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
