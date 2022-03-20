// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class _ToastAnimatedWidget extends StatefulWidget {
  _ToastAnimatedWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastAnimatedWidget> with SingleTickerProviderStateMixin {
  bool get _isVisible => Toast.isVisible;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((context) {
      if (this.mounted) {
        Future.delayed(Duration(seconds: 2), () {
          Toast.dismiss();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
        top: size.height * 0.055,
        child: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: _isVisible ? 1.0 : 0.0,
          child: widget.child,
        ));
  }
}

// #####################

class Toast {
  static void show(
    String msg,
    BuildContext context, {
    Color backgroundColor = const Color.fromRGBO(0, 0, 0, 0.6),
    Color textColor = Colors.white,
  }) {
    dismiss();
    Toast._createView(msg, context, backgroundColor, textColor);
  }

  static late OverlayEntry _overlayEntry;
  static bool isVisible = false;

  static void _createView(
    String msg,
    BuildContext context,
    Color background,
    Color textColor,
  ) async {
    var overlayState = Overlay.of(context);

    final themeData = Theme.of(context);

    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => _ToastAnimatedWidget(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.80,
              height: 60,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Center(
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: themeData.textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    isVisible = true;
    overlayState!.insert(_overlayEntry);
  }

  static dismiss() async {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    _overlayEntry.remove();
  }
}
