import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:doctor/Screens/LabProfile.dart';
import 'package:doctor/Screens/order_medicine.dart';
import 'package:doctor/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/common_button.dart';

class MedicineProfile extends StatefulWidget {
  const MedicineProfile({Key? key}) : super(key: key);

  @override
  _MedicineProfileState createState() => _MedicineProfileState();
}

class _MedicineProfileState extends State<MedicineProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonAppBarTitleText(appbarText: 'Medicine Profile'),
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: appAppBarColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Color(0xff161616).withOpacity(0.6),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Search',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Color(0xff161616).withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: (index + 1 == 10)
                        ? EdgeInsets.only(
                            left: 10, right: 10, bottom: 50, top: 10)
                        : const EdgeInsets.all(10.0),
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(2, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child:
                                      Image.asset('assets/pngs/pngegg (1).png'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Medicines name', style: KHeader),
                                        Text(
                                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et.',
                                            style: KBodyText),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$199',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  commonBtn(
                                    s: 'Add to Cart',
                                    bgcolor: Colors.white,
                                    textColor: appblueColor,
                                    onPressed: () {
                                      Push(context, OrderMedicine());
                                    },
                                    height: 30,
                                    textSize: 12,
                                    width: 130,
                                    borderWidth: 1,
                                    borderColor: appblueColor,
                                    borderRadius: 4,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
