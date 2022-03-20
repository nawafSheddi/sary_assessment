// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_portal/flutter_portal.dart';

// class FilterWidget extends StatelessWidget {
//   const FilterWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PortalEntry(
//       visible: true,
//       portalAnchor: Alignment.topLeft,
//       childAnchor: Alignment.topRight,
//       portal: Material(
//         elevation: 8,
//         child: IntrinsicWidth(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(title: Text('option 1')),
//               ListTile(title: Text('option 2')),
//             ],
//           ),
//         ),
//       ),
//       child: RaisedButton(
//         onPressed: () {},
//       ),
//     );
//   }
// }

// class MenuItem {
//   final String text;
//   final IconData icon;

//   const MenuItem({
//     required this.text,
//     required this.icon,
//   });
// }

// class MenuItems {
//   static const List<MenuItem> firstItems = [home, share, settings];
//   static const List<MenuItem> secondItems = [logout];

//   static const home = MenuItem(text: 'Home', icon: Icons.home);
//   static const share = MenuItem(text: 'Share', icon: Icons.share);
//   static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
//   static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

//   static Widget buildItem(MenuItem item) {
//     return Row(
//       children: [
//         Icon(item.icon, color: Colors.white, size: 22),
//         const SizedBox(
//           width: 10,
//         ),
//         Text(
//           item.text,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }
