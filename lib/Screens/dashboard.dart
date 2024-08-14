import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../database/dbhelper.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Map<String, double> countMap1 = {};
  Map<String, double> percentageMap1 = {};
  Map<String, double> countMap2 = {};
  Map<String, double> percentageMap2 = {};
  Map<String, double> _designationCountMap = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }




  loadData() async {
    AppDataBase().getDatabase();

    Map<String, double> dataMap1 =
    await AppDataBase().getRecruitmentStatusCount();
    Map<String, double> dataMap2 =
    await AppDataBase().getCandidatesByGenderCount();

    Map<String, double> designationCountMap = await AppDataBase()
        .getCandidatesByDesignationCount();


    // Calculate the total count
    double totalCount1 = 0;
    double totalCount2 = 0;
    dataMap1.forEach((key, value) {
      totalCount1 += value;
    });
    dataMap2.forEach((key, value) {
      totalCount2 += value;
    });

    // Calculate the percentage of each recruitment status
    dataMap1.forEach((key, value) {
      percentageMap1[key] = (value / totalCount1) * 100;
    });
    // Calculate the percentage gender
    dataMap2.forEach((key, value) {
      percentageMap2[key] = (value / totalCount2) * 100;
    });

    setState(() {
      countMap1 = dataMap1;
      percentageMap1 = percentageMap1;
      countMap2 = dataMap2;
      percentageMap2 = percentageMap2;
      _designationCountMap = designationCountMap;
      _isLoading = false;
    });
  }


  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Container(
          color: Colors.cyanAccent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  height:300,
                  child: PieChart(
                    PieChartData(
                      sections: percentageMap1.entries.map((e) => PieChartSectionData(
                        value: e.value,
                        color: colors[percentageMap1.entries.toList().indexOf(e) % colors.length],
                        radius: 60,
                        title: '${e.key} (${e.value.toStringAsFixed(2)}%)',
                        titleStyle: TextStyle(fontSize: 18, color: Colors.black),
                      )).toList(),
                    ),
                  ),
                ),
                Container(
                  margin:EdgeInsets.all(30),
                  height:300,
                  child: PieChart(
                    PieChartData(
                      sections: percentageMap2.entries.map((e) => PieChartSectionData(
                        value: e.value,
                        color: e.key == 'Male' ? Colors.blue : Colors.pink,
                        radius: 60,
                        title: '${e.key} (${e.value.toStringAsFixed(2)}%)',
                        titleStyle: TextStyle(fontSize: 20, color: Colors.white),
                      )).toList(),
                    ),
                  ),
                ),
                Container(
                  height:400,
                  child: BarChart(
                    BarChartData(
                      barGroups: _designationCountMap.entries.map((e) => BarChartGroupData(
                        x: _designationCountMap.keys.toList().indexOf(e.key),
                        barRods: [
                          BarChartRodData(
                            fromY: 0,
                            color: Colors.purpleAccent,
                            toY: e.value,
                          ),
                        ],
                      )).toList(),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text('Axis Name'),
                          sideTitles: SideTitles(
                            interval: 1, // specify the interval of the titles
                            showTitles: true,
                          ),
                        ),
                        // bottomTitle: AxisTitle(
                        //   showTitle: true,
                        //   titleText: 'Bottom Title',
                        //   textStyle: TextStyle(color: Colors.black, fontSize: 12),
                        //   margin: 10,
                        // ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}