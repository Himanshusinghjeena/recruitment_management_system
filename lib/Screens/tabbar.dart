// import 'package:flutter/material.dart';
// import 'package:recruitment_management_system/components/listbuilder.dart';
//
// class Tabbar extends StatefulWidget {
//  IconData icon1;
//  IconData icon2;
//  Tabbar({required this.icon1,required this.icon2});
//
//
//   @override
//   State<Tabbar> createState() => _TabbarState();
// }
//
// class _TabbarState extends State<Tabbar> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           bottom: const TabBar(
//             indicatorSize: TabBarIndicatorSize.tab,
//             tabs: [
//               Tab(icon: Icon(Icons.person_add,size: 40,)),
//               Tab(icon: Icon(Icons.hourglass_empty,size: 40,)),
//             ],
//           ),
//           title: Text('Tabs Demo'),
//         ),
//         body: TabBarView(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Container(
//                   color: Colors.white, child: CustomListBuilder(candidate: newCandidate)),
//             ),
//             Icon(Icons.directions_transit, size: 350),
//           ],
//         ),
//       ),
//     );
//   }
// }
