import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sary_assessment/const/colors.dart' as colors;
import 'package:sary_assessment/controller/item_notifier.dart';

import 'toast_widget.dart';

class SaveItemButton extends StatelessWidget {
  SaveItemButton({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.priceController,
    required this.skuController,
    required this.descriptionController,
  }) : super(key: key);

  final formKey;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController skuController;
  final TextEditingController descriptionController;
  final Box box = Hive.box("ItemData");
  @override
  Widget build(BuildContext context) {
    ItemNotifier userNotifier = Provider.of<ItemNotifier>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.015, left: size.width * 0.1, right: size.width * 0.1),
        width: double.infinity,
        height: 62,
        decoration: BoxDecoration(
          color: colors.mainButtonsColor,
          borderRadius: BorderRadius.circular(20),
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
      onTap: () async {
        if (formKey.currentState!.validate()) {
          context.read<ItemNotifier>().addItem(
                name: nameController.text,
                price: priceController.text,
                sku: skuController.text,
                description: descriptionController.text,
              );
          Toast.show("Item hase been saved Successfully", context, backgroundColor: colors.mainToastColor);
          Navigator.pop(context);
        } else {
          Toast.show("Please don't leave the fields empty", context, backgroundColor: Colors.red);
        }
      },
    );
  }
}
