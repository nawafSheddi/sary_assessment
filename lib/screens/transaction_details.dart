// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sary_assessment/const/colors.dart' as colors;

import '../controller/item_notifier.dart';

class TransactionDetails extends StatelessWidget {
  TransactionDetails({
    Key? key,
    required this.transactionId,
    required this.itemId,
  }) : super(key: key);

  final int transactionId;
  final int itemId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context);
    var itemData = context.watch<ItemNotifier>().getItemData(itemId);
    var transactionsData = context.watch<ItemNotifier>().getTransactionsData(transactionId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.appBarColor,
        elevation: 0.1,
        centerTitle: true,
        title: Text(
          "Transaction Details",
          style: TextStyle(
            color: colors.appBarTitleColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_rounded,
            color: colors.appBarIconColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Container(
            margin: EdgeInsets.all(size.width * 0.05),
            padding: EdgeInsets.all(size.width * 0.05),
            height: size.height * 0.445,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: colors.cardsBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(itemData['image']),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 9),
                            child: SizedBox(
                              height: size.height * 0.04,
                              width: size.width * 0.4,
                              child: AutoSizeText(
                                itemData["name"],
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                minFontSize: 11,
                              ),
                            ),
                          ),
                          Text(
                            itemData["sku"],
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            itemData["description"],
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactionsData["quantity"].toString(),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Quantity",
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${itemData['price']} SR",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.02),
                          child: Text(
                            transactionsData["type"] == "inbound" ? "Stock In" : "Stock Out",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Icon(
                          transactionsData["type"] == "inbound" ? Icons.south_rounded : Icons.north_rounded,
                          color: transactionsData["type"] == "inbound" ? Colors.green : Colors.red,
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.015),
                      child: Text(
                        "Inbound",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transactionsData["inbound_at"].substring(0, 10).replaceAll("-", "/"),
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Date",
                                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reformatTime(transactionsData["inbound_at"]),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Time",
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.015),
                      child: Text(
                        "Outbound",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transactionsData["outbound_at"].substring(0, 10).replaceAll("-", "/"),
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Date",
                                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reformatTime(transactionsData["outbound_at"]),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Time",
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  reformatTime(String date) {
    String time = date.substring(11, 16);

    if (time.substring(1, 2) == ":") {
      date = date.substring(0, 11) + "0" + date.substring(11);

      time = date.substring(11, 16);
    }

    int hours = int.parse(time.substring(0, 2));

    if (hours > 12) {
      return "${hours - 12}" "${date.substring(13, 16)} PM";
    } else if (hours < 12) {
      return "${date.substring(12, 16)} AM";
    } else if (hours == 12) {
      return "${date.substring(11, 16)} PM";
    } else {
      return "${date.substring(12, 16)} Am";
    }
  }
}
