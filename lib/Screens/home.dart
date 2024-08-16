import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Screens/splashscreen.dart';
import 'package:recruitment_management_system/Services/dbhelper.dart';
import 'package:recruitment_management_system/Services/sp.dart';
import 'package:recruitment_management_system/appColors.dart';
import 'package:recruitment_management_system/indicator.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, double> countMap1 = {};
  Map<String, double> percentageMap1 = {};
  Map<String, dynamic>? detail = {};
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Method to load data asynchronously
  loadData() async {
    final adminDetails = await AppDataBase().getAdminByEmail(widget.email);
    final dataMap1 = await AppDataBase().getRecruitmentStatusCount();

    // Calculate the total count
    double totalCount1 = dataMap1.values.fold(0, (sum, item) => sum + item);

    // Calculate the percentage of each recruitment status
    percentageMap1 = dataMap1.map((key, value) => MapEntry(key, (value / totalCount1) * 100));

    setState(() {
      countMap1 = dataMap1;
      detail = adminDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(detail?['name'] ?? 'N/A'),
                accountEmail: Text(widget.email),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/default.jpeg'),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  await SharedPreferencesService().clearLoginDetails();
                  Navigator.pop(context);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),

                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).canvasColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height:MediaQuery.of(context).size.height*0.3,
                      width:MediaQuery.of(context).size.width*0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/home.jpg')
                        )
                      ),
                    ),
                    _buildPieChart(),
                    const SizedBox(height: 30),
                    _buildActionTile(
                      context,
                      icon: Icons.directions_run,
                      label: "Active Candidates",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreen(active: true),
                          ),
                        );
                      },
                    ),
                    _buildActionTile(
                      context,
                      icon: Icons.person,
                      label: "Inactive Candidates",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreen(active: false),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display the pie chart
  Widget _buildPieChart() {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Row(
        children: [
          // const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          _buildIndicators(),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  // Widget to display the indicators for the pie chart
  Widget _buildIndicators() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Indicator(
          color: AppColors.contentColorBlue,
          text: 'New',
          isSquare: true,
        ),
        SizedBox(height: 4),
        Indicator(
          color: AppColors.contentColorYellow,
          text: 'In Progress',
          isSquare: true,
        ),
        SizedBox(height: 4),
        Indicator(
          color: AppColors.contentColorPurple,
          text: 'Rejected',
          isSquare: true,
        ),
        SizedBox(height: 4),
        Indicator(
          color: AppColors.contentColorGreen,
          text: 'Selected',
          isSquare: true,
        ),
        SizedBox(height: 18),
      ],
    );
  }

  // Widget to create a reusable action tile
  Widget _buildActionTile(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Center(
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: Theme.of(context).canvasColor,
            ),
            title: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).canvasColor,
              ),
            ),
            trailing: IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.arrow_forward,
                size: 40,
                color: Theme.of(context).canvasColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to dynamically generate pie chart sections based on percentageMap1 data
  List<PieChartSectionData> showingSections() {
    int i = 0;
    return percentageMap1.entries.map((entry) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      final color = _getColorByStatus(entry.key);
      final section = PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.value.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
      i++;
      return section;
    }).toList();
  }

  // Helper method to determine color based on the status key
  Color _getColorByStatus(String key) {
    switch (key) {
      case 'new':
        return AppColors.contentColorBlue;
      case 'in_progress':
        return AppColors.contentColorYellow;
      case 'rejected':
        return AppColors.contentColorPurple;
      case 'selected':
        return AppColors.contentColorGreen;
      default:
        return Colors.grey;
    }
  }
}
