import 'package:flutter/material.dart';
import 'package:sary_assessment/const/colors.dart' as colors;
import 'package:sary_assessment/screens/Items_page.dart';

class SendAndReceiveButtons extends StatelessWidget {
  const SendAndReceiveButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.05, left: size.width * 0.05, right: size.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // send button action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Items(
                      isInbound: true,
                    ),
                  ),
                );
              },
              child: Container(
                height: 62,
                width: size.width * 0.44685,
                decoration: BoxDecoration(
                  color: colors.mainButtonsColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.north_rounded,
                        color: colors.mainButtonsTextColor,
                        size: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.025),
                        child: Text(
                          "Send",
                          // textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: colors.mainButtonsTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Receive button action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Items(
                      isInbound: false,
                    ),
                  ),
                );
              },
              child: Container(
                height: 62,
                width: size.width * 0.44685,
                decoration: BoxDecoration(
                  color: colors.mainButtonsColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.south_rounded,
                        color: colors.mainButtonsTextColor,
                        size: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.025),
                        child: Text(
                          "Receive",
                          // textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: colors.mainButtonsTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
