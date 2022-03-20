// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sary_assessment/const/colors.dart' as colors;
import 'package:sary_assessment/widgets/add_item_button.dart';
import 'package:sary_assessment/widgets/item_card.dart';

import '../controller/item_notifier.dart';

class Items extends StatelessWidget {
  static const routeName = "/items-page";
  const Items({Key? key, required this.isInbound}) : super(key: key);
  final bool isInbound;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.appBarColor,
        elevation: 0.1,
        centerTitle: true,
        title: Text(
          "Items",
          style: TextStyle(
            color: colors.appBarTitleColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: colors.appBarIconColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: size.height * 0.01),
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              child: context.watch<ItemNotifier>().itemsList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: context.watch<ItemNotifier>().itemsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index + 1 == context.watch<ItemNotifier>().itemsList.length ? size.height * 0.09 : 0,
                          ),
                          child: ItemCard(
                            itemName: context.watch<ItemNotifier>().itemsList[index]["name"],
                            itemCode: context.watch<ItemNotifier>().itemsList[index]["sku"],
                            itemSize: context.watch<ItemNotifier>().itemsList[index]["description"],
                            itemPrice: context.watch<ItemNotifier>().itemsList[index]["price"],
                            imagePath: context.watch<ItemNotifier>().itemsList[index]["image"],
                            isInbound: isInbound,
                            itemId: context.watch<ItemNotifier>().itemsList[index]["id"],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "Please add items first!",
                        style: TextStyle(color: colors.appBarTitleColor, fontSize: 25),
                      ),
                    ),
            ),
            AddItemButton()
          ],
        ),
      ),
    );
  }
}
