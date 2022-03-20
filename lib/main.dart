// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sary_assessment/screens/add_item.dart';
import 'package:sary_assessment/screens/items_page.dart';
import 'package:sary_assessment/screens/transactions_page.dart';
import 'package:sary_assessment/widgets/qrCode_scanner.dart';

import 'controller/item_notifier.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('ItemData');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => Transactions(),
        Transactions.routeName: (context) => Transactions(),
        AddItem.routeName: (context) => AddItem(),
        QrCodeScanner.routeName: (context) => QrCodeScanner(),
      },
    );
  }
}
