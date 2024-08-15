import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Services/api.dart';
import 'package:recruitment_management_system/Services/dbhelper.dart';
import 'package:recruitment_management_system/components/listbuilder.dart';


class InActiveScreen extends StatefulWidget {
  const InActiveScreen({super.key});

  @override
  State<InActiveScreen> createState() => _InActiveScreenState();
}

class _InActiveScreenState extends State<InActiveScreen> {
  List<Candidates> selectedCandidate = [];
  List<Candidates> rejectedCandidate = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    AppDataBase().getDatabase();
    List<Candidates> selectedCandidates = await AppDataBase().showSelectedCandidateList();
    List<Candidates> rejectedCandidates = await AppDataBase().showRejectedCandidateList();
    setState(() {
      selectedCandidate = selectedCandidates;
      rejectedCandidate=rejectedCandidates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("INACTIVE CANDIDATES"),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                  text:"Selected",
                  icon: Icon(Icons.badge,size: 40,)),
              Tab(text:"Rejected",
                  icon: Icon(Icons.cancel,size: 40,)),
            ],
          ),

        ),
        body: TabBarView(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  color: Colors.white, child: CustomListBuilder(active: false, candidate: selectedCandidate)),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  color: Colors.white, child: CustomListBuilder(active: false, candidate: rejectedCandidate)),
            ),
          ],
        ),
      ),
    );

    //   Scaffold(
    //     body: Container(
    //         child: Column(children: [
    //   const Padding(
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       "Active Candidates",
    //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //     ),
    //   ),
    //   Expanded(
    //     flex: 1,
    //     child: Container(
    //         color: Colors.white, child: CustomListBuilder(candidate: newCandidate)),
    //   ),
    // ])));
  }
}
