import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Screens/bottom_navigator.dart';
import 'package:recruitment_management_system/Screens/forgot.dart';
import 'package:recruitment_management_system/Screens/homescreen.dart';
import 'package:recruitment_management_system/database/dbhelper.dart';
import 'package:recruitment_management_system/Screens/login.dart';
import 'package:recruitment_management_system/Screens/signup.dart';

import 'constant/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDataBase appDatabase = AppDataBase();

  bool isDatabaseInitialized = await appDatabase.isDatabaseInitialized();

  if (!isDatabaseInitialized) {
    await appDatabase.getDatabase();
    await appDatabase.storeDataInDatabase();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: color1,
        canvasColor: color2,
        highlightColor:color3
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  LogInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot':(context)=>const ForgotPassword(),
        '/home':(context)=>const Home(),
        '/bottom':(context)=>const BottomNavigationWidget(),
      },
    );
  }
}
