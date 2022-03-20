import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sary_assessment/const/colors.dart' as colors;
import 'package:sary_assessment/screens/transactions_page.dart';

import '../controller/item_notifier.dart';
import 'dialog_text_field.dart';
import 'toast_widget.dart';

class ItemCard extends StatelessWidget {
  ItemCard({
    Key? key,
    required this.itemName,
    required this.itemCode,
    required this.itemSize,
    required this.itemPrice,
    required this.imagePath,
    required this.isInbound,
    required this.itemId,
  }) : super(key: key);

  final String itemName;
  final String itemCode;
  final String itemSize;
  final String itemPrice;
  final String imagePath;
  final bool isInbound;
  final int itemId;

  TextEditingController dialogTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context);
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Enter the quantity'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  content: SizedBox(
                    height: size.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DialogTextField(
                          textController: dialogTextController,
                          fieldName: "quantity",
                          isNumber: true,
                        ),
                        ButtonTheme(
                          minWidth: size.width * 0.25,
                          buttonColor: colors.mainButtonsColor,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Done",
                              style: TextStyle(color: colors.mainButtonsTextColor),
                            ),
                            onPressed: () {
                              if (dialogTextController.text.isNotEmpty) {
                                if (RegExp("[0-9]").hasMatch(dialogTextController.text)) {
                                  context.read<ItemNotifier>().addTransactions(
                                        isInbound: isInbound,
                                        itemId: itemId,
                                        quantity: int.parse(dialogTextController.text),
                                        inbound_at: DateTime.now().toString(),
                                        outbound_at: DateTime.now().toString(),
                                      );

                                  Navigator.pop(context);
                                  Navigator.pushNamedAndRemoveUntil(context, Transactions.routeName, (route) => false);
                                  Toast.show('Transactions have been done Successfully!', context, backgroundColor: colors.mainToastColor);
                                } else {
                                  Toast.show('Please enter just numbers', context, backgroundColor: Colors.red);
                                }
                              } else {
                                Toast.show('Please enter a quantity', context, backgroundColor: Colors.red);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Slidable(
          key: ValueKey(itemId),
          child: Container(
            height: size.height * 0.1315,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: size.width * 0.05),
                  width: size.width * 0.305,
                  height: size.height * 0.7866,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.435,
                      height: size.height * 0.029,
                      child: AutoSizeText(
                        itemName,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        maxFontSize: 16,
                        minFontSize: 9,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          itemCode,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          itemSize,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Text(
                      "$itemPrice SR",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.008),
            padding: EdgeInsets.all(size.width * 0.05),
            decoration: BoxDecoration(
              color: colors.cardsBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {
              context.read<ItemNotifier>().deleteItem(itemId);
            }),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: deleteItem,
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteItem(BuildContext context) {
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context, listen: false);
    context.read<ItemNotifier>().deleteItem(itemId);
  }
}
