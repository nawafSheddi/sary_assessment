import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sary_assessment/const/colors.dart' as colors;
import 'package:sary_assessment/controller/item_notifier.dart';
import 'package:sary_assessment/widgets/qrCode_scanner.dart';

class QrCodeScannerButton extends StatelessWidget {
  QrCodeScannerButton({
    Key? key,
  }) : super(key: key);

  final Box box = Hive.box("ItemData");
  @override
  Widget build(BuildContext context) {
    ItemNotifier userNotifier = Provider.of<ItemNotifier>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.05, left: size.width * 0.1, right: size.width * 0.1),
        width: double.infinity,
        height: 62,
        decoration: BoxDecoration(
          color: colors.mainButtonsColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner_rounded, color: colors.mainButtonsTextColor, size: 20),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.015),
              child: Text(
                "Scan Item",
                style: TextStyle(color: colors.mainButtonsTextColor, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
// TODO navigat to scanner
        Navigator.pushNamed(context, QrCodeScanner.routeName);
      },
    );
  }
}
