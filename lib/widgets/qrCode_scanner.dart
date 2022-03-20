import 'dart:developer';
import 'dart:io';
import 'package:sary_assessment/const/colors.dart' as colors;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controller/item_notifier.dart';
import 'toast_widget.dart';

class QrCodeScanner extends StatefulWidget {
  static const routeName = "/QR-Scanner";
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context);
    Size size = MediaQuery.of(context).size;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutWidth: size.width * 0.75, cutOutHeight: size.height * 0.2),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        await controller.pauseCamera();
        context.read<ItemNotifier>().addItem(name: "Ava water", price: "1", sku: "PRO-SA4", description: "6 x 330 ml");
        Toast.show("Item has been saved Successfully", context, backgroundColor: colors.mainToastColor);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
