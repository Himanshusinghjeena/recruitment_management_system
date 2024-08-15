import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Services/api.dart';
import 'package:recruitment_management_system/Services/dbhelper.dart';
import 'package:recruitment_management_system/components/listbuilder.dart';


class ActiveScreen extends StatefulWidget {
  const ActiveScreen({super.key});

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  List<Candidates> newCandidate = [];
  List<Candidates> inProgressCandidate = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    AppDataBase().getDatabase();
    List<Candidates> newCandidates = await AppDataBase().showNewCandidateList();
    List<Candidates> inProgressCandidates = await AppDataBase().showInProgressCandidateList();
    setState(() {
      newCandidate = newCandidates;
      inProgressCandidate=inProgressCandidates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          title: const Text("ACTIVE CANDIDATES"),
          bottom:  TabBar(
  indicatorColor: Theme.of(context).primaryColor,
  labelColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(

                text:"New",
                  icon: Icon(Icons.person_add,size: 40,)),
              Tab(text:"in_Progress",
                  icon: Icon(Icons.hourglass_empty,size: 40,)),
            ],
          ),

        ),
        body: TabBarView(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  color: Theme.of(context).canvasColor, child: CustomListBuilder(active:true,candidate: newCandidate)),
            ),
        Expanded(
          flex: 1,
          child: Container(
              color: Theme.of(context).canvasColor, child: CustomListBuilder(active: true, candidate: inProgressCandidate)),
        ),
          ],
        ),
      ),
    );


  }
}
