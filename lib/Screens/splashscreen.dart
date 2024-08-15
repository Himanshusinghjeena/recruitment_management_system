import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Screens/Inactive.dart';
import 'package:recruitment_management_system/Screens/active.dart';

class SplashScreen extends StatefulWidget {
  bool active;
  SplashScreen({required this.active});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(vsync: this,duration:const Duration(milliseconds: 700));
    animation=Tween(begin: 80.0,end: 500.0 ).animate(animationController);

    animationController.addListener((){
      setState(() {

      });
    });
    animationController.forward();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (widget.active) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ActiveScreen()),
        );
      }
      else
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InActiveScreen()),
          );
        }
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Center(child: Text("widget.sign",style: TextStyle(fontSize: animation.value)))
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
