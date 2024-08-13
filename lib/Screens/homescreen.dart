import 'package:flutter/material.dart';
import 'package:recruitment_management_system/api/api.dart';
import 'package:recruitment_management_system/database/dbhelper.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:recruitment_management_system/Screens/details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  List<Candidates> active = [];
  List<Candidates> inactive = [];
  Map<String, double> countMap = {};
  Map<String, double> percentageMap = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      loadData();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  loadData() async {
    AppDataBase().getDatabase();
    List<Candidates> activedata = await AppDataBase().showActiveCandidateList();
    List<Candidates> inactivedata =
    await AppDataBase().showInActiveCandidateList();
    Map<String, double> dataMap =
    await AppDataBase().getRecruitmentStatusCount();

    // Calculate the total count
    double totalCount = 0;
    dataMap.forEach((key, value) {
      totalCount += value;
    });

    // Calculate the percentage of each recruitment status
    dataMap.forEach((key, value) {
      percentageMap[key] = (value / totalCount) * 100;
    });

    setState(() {
      active = activedata;
      inactive = inactivedata;
      countMap = dataMap;
      percentageMap = percentageMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.cyan,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: AppDataBase().getRecruitmentStatusCount(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, double> dataMap =
                      snapshot.data as Map<String, double>;

                      // Calculate the total count
                      double totalCount = 0;
                      dataMap.forEach((key, value) {
                        totalCount += value;
                      });

                      // Calculate the percentage of each recruitment status
                      Map<String, double> percentageMap = {};
                      dataMap.forEach((key, value) {
                        percentageMap[key] = (value / totalCount) * 100;
                      });

                      return Container(
                        color: Colors.cyanAccent,
                        child: PieChart(
                          dataMap: percentageMap,
                          chartRadius: 200,
                          chartType: ChartType.disc,
                          ringStrokeWidth: 20,
                          legendOptions: const LegendOptions(
                            legendTextStyle: TextStyle(fontSize: 18),
                            showLegends: true,
                            legendPosition: LegendPosition.right,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Active Candidates",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: active.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(active[index]),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Text(
                            active[index].recruitmentNumber ?? "recruit number",
                            style: const TextStyle(fontSize: 15),
                          ),
                          title: Text(
                            '${active[index].firstName ?? 'first'} ${active[index].lastName ?? 'last'}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          subtitle: Text(
                            active[index].recruitmentStatus ?? 'get-out',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          trailing: Text(
                            active[index].appliedDesignation ?? '',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Inactive Candidates",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: inactive.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(inactive[index]),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Text(
                            inactive[index].recruitmentNumber ??
                                "recruit number",
                            style: const TextStyle(fontSize: 15),
                          ),
                          trailing: Text(
                            inactive[index].appliedDesignation ?? '',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                          title: Text(
                            '${inactive[index].firstName ?? 'first'} ${inactive[index].lastName ?? 'last'}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          subtitle: Text(
                            inactive[index].recruitmentStatus ?? 'get-out',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: inactive[index].recruitmentStatus ==
                                  'rejected'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

