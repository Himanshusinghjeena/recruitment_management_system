// import 'package:flutter/material.dart';
// import 'package:recruitment_management_system/api/api.dart';
// import 'package:recruitment_management_system/components/listbuilder.dart';
// import 'package:recruitment_management_system/database/dbhelper.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:recruitment_management_system/Screens/details.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   List<Candidates> active = [];
//   List<Candidates> inactive = [];
//
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   loadData() async {
//     AppDataBase().getDatabase();
//     List<Candidates> activedata = await AppDataBase().showActiveCandidateList();
//     List<Candidates> inactivedata =
//     await AppDataBase().showInActiveCandidateList();
//
//
//
//     setState(() {
//       active = activedata;
//       inactive = inactivedata;
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: Colors.cyan,
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   "Active Candidates",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   color: Colors.white,
//                   child: CustomListBuilder(candidate: active)
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   "Inactive Candidates",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   color: Colors.white,
//                   child:CustomListBuilder(candidate: inactive)
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
