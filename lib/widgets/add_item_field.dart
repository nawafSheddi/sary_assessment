// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sary_assessment/const/colors.dart' as colors;

class AddItemTextField extends StatelessWidget {
  const AddItemTextField({Key? key, required this.textController, required this.fieldName, required this.isNumber}) : super(key: key);

  final TextEditingController textController;
  final String fieldName;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      // height: size.height * 0.5,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      decoration: BoxDecoration(color: colors.cardsBackgroundColor, borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        controller: textController,
        textAlign: TextAlign.left,
        validator: (value) => value!.isEmpty ? "Please don't leave it empty" : null,
        cursorColor: colors.searchCursorColor,
        textAlignVertical: TextAlignVertical.bottom,
        cursorHeight: 10,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          label: Text(fieldName),
          labelStyle: TextStyle(fontSize: 14, color: colors.searchFieldHintColor),
          hintText: '',
          hintStyle: TextStyle(fontSize: 14, color: colors.searchFieldHintColor),
          errorStyle: TextStyle(fontSize: 14, color: Colors.red),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: colors.searchFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: colors.searchFieldBorderColor),
          ),
        ),
      ),
    );
  }
}
