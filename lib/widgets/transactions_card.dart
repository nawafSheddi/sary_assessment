// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:sary_assessment/const/colors.dart' as colors;
import 'package:sary_assessment/screens/transaction_details.dart';

class TransactionsCard extends StatelessWidget {
  const TransactionsCard({
    Key? key,
    required this.itemName,
    required this.itemCode,
    required this.itemSize,
    required this.itemPrice,
    required this.transactionsDate,
    required this.isIn,
    required this.transactionsId,
    required this.itemId,
  }) : super(key: key);

  final String itemName;
  final String itemCode;
  final String itemSize;
  final String itemPrice;
  final String transactionsDate;
  final bool isIn;
  final int transactionsId;
  final int itemId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetails(
              transactionId: transactionsId,
              itemId: itemId,
            ),
          ),
        );
      },
      child: Container(
        height: size.height * 0.1315,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Column(
                  children: [
                    Text(
                      itemCode,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      itemSize,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Text(
                  "$itemPrice SR",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.02),
                      child: Text(
                        isIn ? "Stock In" : "Stock Out",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Icon(
                      isIn ? Icons.south_rounded : Icons.north_rounded,
                      color: isIn ? Colors.green : Colors.red,
                    )
                  ],
                ),
                Text(
                  transactionsDate.substring(0, 10).replaceAll("-", "/"),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                )
              ],
            )
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.008),
        padding: EdgeInsets.all(size.width * 0.05),
        decoration: BoxDecoration(
          color: colors.cardsBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
