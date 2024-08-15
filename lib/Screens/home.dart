import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Screens/splashscreen.dart';
import 'package:recruitment_management_system/Services/dbhelper.dart';
import 'package:recruitment_management_system/Services/sp.dart';

class HomeScreen extends StatefulWidget {
  String email;
  HomeScreen({required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, double> countMap1 = {};
  Map<String, double> percentageMap1 = {};
  Map<String, dynamic>? detail = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    final adminDetails = await AppDataBase().getAdminByEmail(widget.email);
    Map<String, double> dataMap1 =
        await AppDataBase().getRecruitmentStatusCount();

    // Calculate the total count
    double totalCount1 = 0;
    double totalCount2 = 0;
    dataMap1.forEach((key, value) {
      totalCount1 += value;
    });

    // Calculate the percentage of each recruitment status
    dataMap1.forEach((key, value) {
      percentageMap1[key] = (value / totalCount1) * 100;
    });

    setState(() {
      countMap1 = dataMap1;
      percentageMap1 = percentageMap1;
      detail = adminDetails!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).primaryColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      Image.asset('assets/images/default.jpeg')
                                          .image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name: ${detail!['name']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                    Text(
                                        "Designation: ${detail!['designation']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                    Text("Contact: ${detail!['contact']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                  ],
                                ))
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.all(20),
                      height: 300,
                      child: PieChart(
                        PieChartData(
                          sections: percentageMap1.entries
                              .map((e) => PieChartSectionData(
                                    value: e.value,
                                    radius: 60,
                                    color: Theme.of(context).canvasColor,
                                    title:
                                        '${e.key} (${e.value.toStringAsFixed(2)}%)',
                                    titleStyle:  TextStyle(
                                        fontSize: 18, color: Theme.of(context).highlightColor),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 20),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).canvasColor,
                          ),
                          height: MediaQuery.of(context).size.height * 0.1,
                          child:  Center(
                            child:  ListTile(
                                leading:  Icon(Icons.directions_run,size:40,
                                    color:Theme.of(context).highlightColor

                                ),
                            title:  Text("Active Candidates",style: TextStyle(fontSize: 24,
                                color:Theme.of(context).highlightColor

                            ))
                            ,trailing: IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen(active: true,)));
                            },icon:  Icon(size:40,Icons.arrow_forward,
                                color:Theme.of(context).highlightColor

                            )),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).canvasColor,
                        ),
                        height: MediaQuery.of(context).size.height * 0.1,
                          child:  Center(
                            child:  ListTile(
                              leading:  Icon(Icons.person,size:38,
                              color:Theme.of(context).highlightColor
                              ),
                              title:  Text("InActive Candidates",style: TextStyle(fontSize: 22,
                                  color:Theme.of(context).highlightColor

                              ))
                              ,trailing: IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen(active: false,)));
                            },icon:  Icon(size:38,Icons.arrow_forward,
                                color:Theme.of(context).highlightColor

                            )),
                            ),
                          )
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
              top: 15,
              right: 20,
              child: IconButton(
                onPressed: () {
                  SharedPreferencesService().clearLoginDetails();
                  Navigator.pop(context);
                },
                icon: const Icon(size: 25, Icons.logout),
              )),
        ]),
      ),
    );
  }
}
