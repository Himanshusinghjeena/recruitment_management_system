import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Screens/Inactive.dart';
import 'package:recruitment_management_system/Screens/active.dart';
import 'package:recruitment_management_system/constant/constant.dart';

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
    animationController=AnimationController(vsync: this,duration:const Duration(milliseconds: 600));
    animation=Tween(begin: 40.0,end: 300.0 ).animate(animationController);

    animationController.addListener((){
      setState(() {

      });
    });
    animationController.forward();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (widget.active) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ActiveScreen()),
        );
      }
      else
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const InActiveScreen()),
          );
        }
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Center(child:
          Container(
            height:animation.value,
            width:animation.value,
            decoration: const BoxDecoration(
            shape: BoxShape.circle,
              image: DecorationImage(
                fit:BoxFit.fill,
                image: AssetImage("assets/images/chetu.jpeg")
              )
            ),
          )
      )
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
