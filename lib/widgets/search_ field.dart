// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sary_assessment/const/colors.dart' as colors;

class SearchField extends StatelessWidget {
  SearchField({Key? key, required this.searchController, required this.onChanged}) : super(key: key);
  final TextEditingController searchController;
  final void Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 40,
      width: size.width * 0.75,
      margin: EdgeInsets.only(
        top: size.width * 0.05,
        bottom: size.width * 0.05,
        left: size.width * 0.05,
        right: size.width * 0.025,
      ),
      decoration: BoxDecoration(
        color: colors.searchFieldbackgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        controller: searchController,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: colors.searchCursorColor,
        cursorHeight: 10,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: colors.searchIconColor,
          ),
          iconColor: colors.searchIconColor,
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 14, color: colors.searchFieldHintColor),
          // errorStyle: GoogleFonts.cairo(color: Colors.red),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: colors.searchFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: colors.searchFieldBorderColor),
          ),
        ),
      ),
    );
  }
}
