// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sary_assessment/const/colors.dart' as colors;
import 'package:sary_assessment/widgets/filter_widget.dart';
import 'package:sary_assessment/widgets/send_receive_buttons.dart';
import 'package:sary_assessment/widgets/transactions_card.dart';
import 'package:sary_assessment/widgets/search_%20field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../controller/item_notifier.dart';
import '../widgets/toast_widget.dart';

class Transactions extends StatefulWidget {
  static const routeName = "/transactions-page";
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late final Box box;
  TextEditingController searchController = TextEditingController();
  String searchInput = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box("ItemData");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context);
    var result = context.read<ItemNotifier>().searchFunction(searchInput) ?? "";

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.appBarColor,
        elevation: 0.1,
        centerTitle: true,
        title: Text(
          "Transactions",
          style: TextStyle(
            color: colors.appBarTitleColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.05),
            child: GestureDetector(
              child: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset("assets/Icons/tag.png"),
              ),
              onTap: () async {
                // TODO ask them  what to do here
                // box.clear();
              },
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SearchField(
                      searchController: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchInput = value!;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: colors.searchFieldBorderColor),
                          borderRadius: BorderRadius.circular(50),
                          color: colors.searchFieldbackgroundColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.filter_alt_outlined,
                            color: colors.sortIconColor,
                          ),
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                margin: EdgeInsets.only(top: size.height * 0.025),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: size.height * 0.015, top: size.height * 0.03),
                                      child: Text(
                                        'Filter by',
                                        style: TextStyle(color: colors.appBarTitleColor, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.onetwothree_rounded),
                                      title: Text('Quantity'),
                                      onTap: () {
                                        context.read<ItemNotifier>().sortByQuantity();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.calendar_month),
                                      title: Text('Date created'),
                                      onTap: () {
                                        context.read<ItemNotifier>().sortByDate();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.south_rounded, color: Colors.green),
                                      title: Text('Inbound'),
                                      onTap: () {
                                        context.read<ItemNotifier>().sortByType("inbound");
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: size.height * 0.03),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.north_rounded,
                                          color: Colors.red,
                                        ),
                                        title: Text('Outbound'),
                                        onTap: () {
                                          context.read<ItemNotifier>().sortByType("outbound");
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    // FilterWidget(),
                  ],
                ),
                SizedBox(
                  height: size.height,
                  child: result == "no result"
                      ? Center(
                          child: Text(
                          "No result!!",
                          style: TextStyle(color: colors.appBarTitleColor, fontSize: 22),
                        ))
                      : context.watch<ItemNotifier>().transactionsList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: result.length == 0 ? context.watch<ItemNotifier>().transactionsList.length : result.length,
                              itemBuilder: (BuildContext context, int index) {
                                // get the transactions data
                                var transactionsData = result.length == 0 ? context.watch<ItemNotifier>().transactionsList[index] : result[index];
                                // to know if it's inbound or outbound
                                bool isInbound = transactionsData["type"] == "inbound" ? true : false;
                                // to get the item data
                                var itemData = context.read<ItemNotifier>().getItemData(transactionsData["itemId"]);

                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index + 1 == context.watch<ItemNotifier>().transactionsList.length ? size.height * 0.32 : 0,
                                  ),
                                  child: TransactionsCard(
                                    itemName: itemData["name"],
                                    itemCode: itemData["sku"],
                                    itemPrice: itemData["price"],
                                    itemSize: itemData["description"],
                                    transactionsId: transactionsData["id"],
                                    itemId: transactionsData["itemId"],
                                    isIn: isInbound,
                                    transactionsDate: isInbound ? transactionsData["inbound_at"] : transactionsData["outbound_at"],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "Please make transactions first!",
                                style: TextStyle(color: colors.appBarTitleColor, fontSize: 22),
                              ),
                            ),
                ),
              ],
            ),
          ),
          SendAndReceiveButtons(),
        ],
      ),
    );
  }
}
