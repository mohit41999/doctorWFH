import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:flutter/material.dart';
import 'package:doctor/widgets/title_column.dart';

class WalletTransactionHistory extends StatefulWidget {
  const WalletTransactionHistory({Key? key}) : super(key: key);

  @override
  _WalletTransactionHistoryState createState() =>
      _WalletTransactionHistoryState();
}

class _WalletTransactionHistoryState extends State<WalletTransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                top: 8.0,
                left: 8,
                right: 8,
                bottom: (index + 1 == 15) ? navbarht + 20 : 8),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                child: Container(
                  height: 86,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            titleColumn(
                                title: 'Transaction Id', value: '99563281201'),
                            titleColumn(
                                title: 'Order Id / Service Id',
                                value: '1543679284'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            titleColumn(
                                title: 'Transaction Date', value: '27/09/2021'),
                            titleColumn(
                                title: 'Transaction Amount', value: '\$199'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 15,
      ),
    );
  }
}
