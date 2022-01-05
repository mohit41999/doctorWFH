import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctor/Utils/colorsandstyles.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/navigation_drawer.dart';

class OrderProduct extends StatefulWidget {
  const OrderProduct({Key? key}) : super(key: key);

  @override
  State<OrderProduct> createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  TextStyle pricingname = GoogleFonts.montserrat(
      color: Color(0xff161616).withOpacity(0.6), fontSize: 14);
  TextStyle price = GoogleFonts.montserrat(
      color: Color(0xff161616), fontWeight: FontWeight.bold, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: commonAppBarTitle(),
          backgroundColor: appAppBarColor,
          elevation: 0,
          leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.menu,
                onPressed: () {
                  setState(() {
                    Scaffold.of(context).openDrawer();
                  });
                }),
          )),
      drawer: commonDrawer(),
      body: ListView(
        children: [
          ProductList(context),
          SizedBox(height: 10),
          PriceDetails(context),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: commonBtn(
              s: 'Place Order',
              bgcolor: appblueColor,
              textColor: Colors.white,
              onPressed: () {},
              borderRadius: 8,
            ),
          )
        ],
      ),
    );
  }

  Widget dashedHorizontalLine() {
    return Row(
      children: [
        for (int i = 0; i < 20; i++)
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget ProductList(context) {
    return Container(
      height: 400,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, int) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.purple,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Product Name', style: KHeader),
                                Text(
                                  'Remove',
                                  style: TextStyle(color: Color(0xffD68100)),
                                )
                              ],
                            ),
                            Container(
                              child: Text(
                                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut laborecn et.',
                                style: KBodyText,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text('Dropdown button', style: KPrice),
                                ),
                                Text(
                                  '\$199',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget PriceDetails(context) {
    return Container(
      color: Colors.white,
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price Details',
              style: GoogleFonts.montserrat(
                  color: Color(0xff161616),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Divider(color: Colors.grey, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price \(2 Iteams\)',
                  style: pricingname,
                ),
                Text('\$398', style: price),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount', style: pricingname),
                Text('\$398', style: price),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Charges', style: pricingname),
                Text('Free', style: price),
              ],
            ),
            dashedHorizontalLine(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount', style: price),
                Text('\$398', style: price),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
