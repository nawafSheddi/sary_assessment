// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sary_assessment/const/colors.dart' as colors;
import 'package:sary_assessment/screens/add_item.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AddItem.routeName);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: size.height * 0.05, left: size.width * 0.05, right: size.width * 0.05),
          width: double.infinity,
          height: 62,
          decoration: BoxDecoration(
            color: colors.mainButtonsColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: colors.mainButtonsTextColor, size: 20),
              Text(
                "Add Item",
                style: TextStyle(color: colors.mainButtonsTextColor, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
