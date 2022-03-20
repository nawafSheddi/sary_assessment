// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sary_assessment/const/colors.dart' as colors;
import 'package:sary_assessment/widgets/add_item_field.dart';
import 'package:sary_assessment/widgets/save_item_button.dart';

import '../controller/item_notifier.dart';
import '../widgets/qrCode_scanner_button.dart';

class AddItem extends StatelessWidget {
  static const routeName = "/AddItem";
  AddItem({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ItemNotifier userNotifier = Provider.of<ItemNotifier>(context);
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.appBarColor,
        elevation: 0.1,
        centerTitle: true,
        title: Text(
          "Add Item",
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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: AddItemTextField(
                  textController: nameController,
                  fieldName: "Item Name",
                  isNumber: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
                child: AddItemTextField(
                  textController: priceController,
                  fieldName: "Price",
                  isNumber: true,
                ),
              ),
              AddItemTextField(
                textController: skuController,
                fieldName: "Item SKU",
                isNumber: false,
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.025, bottom: size.height * 0.05),
                child: AddItemTextField(
                  textController: descriptionController,
                  fieldName: "Item Description",
                  isNumber: false,
                ),
              ),
              SaveItemButton(
                formKey: formKey,
                nameController: nameController,
                priceController: priceController,
                skuController: skuController,
                descriptionController: descriptionController,
              ),
              QrCodeScannerButton(),
            ],
          ),
        ),
      ),
    );
  }
}
