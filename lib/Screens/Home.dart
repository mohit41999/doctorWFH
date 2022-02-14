import 'package:doctor/Screens/MYScreens/MyQuestionsScreen.dart';
import 'package:doctor/Screens/MYScreens/MyReviewRating.dart';
import 'package:doctor/Screens/MYScreens/MyWalletTabs/wallet_transaction_history.dart';
import 'package:doctor/Screens/MYScreens/my_online_consultants.dart';
import 'package:doctor/Screens/ProfileSettings/profile_setting.dart';
import 'package:doctor/Screens/account_settings.dart';
import 'package:doctor/Screens/completed_assignment.dart';
import 'package:doctor/Screens/search_screen.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/widgets/commonAppBarLeading.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:doctor/widgets/common_button.dart';
import 'package:doctor/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
final List<Map<dynamic, dynamic>> hometile = [
  {
    'label': 'My Online Consultants',
    'Screen': MyOnlineConsultants(),
    'profile': 'Rectangle 69.png'
  },
  {
    'label': 'Completed Assignments',
    // 'Screen': 'null',
    'Screen': CompletedAssignment(),
    'profile': 'Rectangle -7.png'
  },
  {
    'label': 'My Reviews',
    // 'Screen': 'null',
    'Screen': MyReviewRatingsScreen(),
    'profile': 'Rectangle -1.png'
  },
  {
    'label': 'My Questions',
    'Screen': MyQuestionsScreen(),
    'profile': 'Rectangle -6.png'
  },
  {
    'label': 'Billing Segment',
    // 'Screen': 'null',
    'Screen': WalletTransactionHistory(),
    'profile': 'Rectangle -4.png'
  },
  {
    'label': 'Account Settings',
    'Screen': AccountSetting(),
    'profile': 'Rectangle 69.png'
  },
  {
    'label': 'Profile Setting',
    // 'Screen': 'null',
    'Screen': ProfileSetting(),
    'profile': 'Rectangle 69.png'
  },
  {'label': 'Knowledge Forum', 'Screen': 'null', 'profile': 'Rectangle -2.png'},
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<Widget> widgetSliders(BuildContext context) => hometile
      .map((item) => Container(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffF6F6F6),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(2, 5),
                ),
              ],
            ),
            // height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 160,
                        child: Text(
                          item['label'],
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: appblueColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 160,
                        child: Text(
                          'India\'s largest home health care company',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Color(0xff161616),
                          ),
                        ),
                      ),
                      commonBtn(
                        s: 'Consult Now',
                        bgcolor: appblueColor,
                        textColor: Colors.white,
                        onPressed: () {
                          (item['Screen'] == 'null')
                              ? print('nooooooo')
                              : Push(context, item['Screen']);
                        },
                        width: 120,
                        height: 30,
                        textSize: 12,
                        borderRadius: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/pngs/${item['profile']}',
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          )))
      .toList();
  TextEditingController _search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Push(context, SearchScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
                        width: 15,
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
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Column(children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: CarouselSlider(
                      items: widgetSliders(context),
                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.5,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: hometile.asMap().entries.map((entry) {
                    return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == entry.key
                                ? appblueColor.withOpacity(0.9)
                                : appblueColor.withOpacity(0.4),
                          ),
                        ));
                  }).toList(),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 300,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // maxCrossAxisExtent: 100,
                          childAspectRatio: 1.45 / 1,
                          // crossAxisSpacing: 10,
                          // mainAxisSpacing: 10,
                          crossAxisCount: 2),
                      itemCount: hometile.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              (hometile[index]['Screen'].toString() == 'null')
                                  ? {print('blablabla')}
                                  : Push(context, hometile[index]['Screen']);
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: appblueColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.asset(
                                      'assets/pngs/${hometile[index]['profile']}'),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      hometile[index]['label'].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
