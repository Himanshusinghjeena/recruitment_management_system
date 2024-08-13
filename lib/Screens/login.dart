// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_management_system/Screens/forgot.dart';
import 'package:recruitment_management_system/bloc/login/login_bloc.dart';
import 'package:recruitment_management_system/bloc/login/login_state.dart';
import 'package:recruitment_management_system/components/button.dart';
import 'package:recruitment_management_system/components/customInput.dart';
import 'package:recruitment_management_system/Screens/signup.dart';

import '../bloc/login/login_event.dart';
import '../constant/constant.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  TextEditingController passwordController = TextEditingController();
  RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{4,12}$');

  final formKey = GlobalKey<FormState>();
  bool rememberPassword = false;
  bool _obscureText = true;

  // Future<bool?> login(String email, String password) async {
  //   final storedEmail = await Sharedpref().getDetail('email');
  //   final storedPassword = await Sharedpref().getDetail('password');
  //   if (storedEmail == null && storedPassword == null) {
  //     return false;
  //   } else if (storedEmail == email && storedPassword == password) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
            child: BlocListener<LoginBloc, LoginState>(listener:
                (context, state) {
              if (state is SnackbarState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(5),
                  ),
                );
              } else if (state is SignupScreenState) {
                Navigator.pushNamed(context, '/signup');
              } else if (state is HomeScreenState) {
                Navigator.pushNamed(context, '/home');
              } else if (state is ForgotScreenState) {
                Navigator.pushNamed(context, '/forgot');
              }
            }, child:
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              if (state is InitialState) {
              return  Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height,
                        color: Theme.of(context).primaryColor),
                    Column(children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(navbarLogo))),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(25, 50, 25, 50),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                          ),
                          child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(loginHeader,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 30),
                                    CustomInputField(
                                      controller: emailController,
                                      icon: Icon(Icons.email_outlined),
                                      labelText: 'Email',
                                      hintText: "Enter your email",
                                      validator: (value) {
                                        if (value!.isEmpty || value == null) {
                                          return 'Please enter Email';
                                        } else if (!emailRegExp
                                            .hasMatch(value)) {
                                          return 'Please Enter a Valid Email';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    CustomInputField(
                                      controller: passwordController,
                                      labelText: 'password',
                                      hintText: "Enter your password",
                                      validator: (value) {
                                        if (value!.isEmpty || value == null) {
                                          return 'Please enter Password';
                                        } else if (!passwordRegExp
                                            .hasMatch(value)) {
                                          return "Please Enter A Valid Password";
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      suffixIcon: true,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: rememberPassword,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  rememberPassword = value!;
                                                });
                                              },
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text("Remember me",
                                                style: TextStyle(
                                                    color: Colors.black45)),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<LoginBloc>().add(OnForgotEvent());
                                          },
                                          child: Text(
                                            'Forgot password?',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    CustomButton(
                                        innerText: "Log in",
                                        onPressed: () {
                                          context
                                              .read<LoginBloc>()
                                              .add(OnLoginEvent());
                                        }),
                                    // Container(
                                    //     width: double.infinity,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(20)),
                                    //     child: ElevatedButton(
                                    //         style: ElevatedButton.styleFrom(
                                    //             backgroundColor:
                                    //                 const Color.fromARGB(255, 7, 55, 94),
                                    //             foregroundColor: Colors.white),
                                    //         onPressed: () {}
                                    //         // if (formKey.currentState!.validate()) {
                                    //         //   bool? isLogIn = await login(
                                    //         //       emailController.text,
                                    //         //       passwordController.text);
                                    //         //   if (isLogIn == true) {
                                    //         //     // Navigator.push(
                                    //         //     //   context,
                                    //         //     //   MaterialPageRoute(
                                    //         //     //       builder: (context) =>
                                    //         //     //           BottomNavigation()),
                                    //         //     // );
                                    //         //     ScaffoldMessenger.of(context)
                                    //         //         .showSnackBar(
                                    //         //       const SnackBar(
                                    //         //           duration:
                                    //         //           Duration(seconds: 1),
                                    //         //           content: Text(
                                    //         //               'Log in SuccessFull')),
                                    //         //     );
                                    //         //   } else if (isLogIn == false) {
                                    //         //     ScaffoldMessenger.of(context)
                                    //         //         .showSnackBar(
                                    //         //       const SnackBar(
                                    //         //           duration:
                                    //         //           Duration(seconds: 1),
                                    //         //           content:
                                    //         //           Text('Login Failed')),
                                    //         //     );
                                    //         //   }
                                    //         // } else if (emailController
                                    //         //       .text.isEmpty ||
                                    //         //       passwordController.text.isEmpty) {
                                    //         //     ScaffoldMessenger.of(context)
                                    //         //         .showSnackBar(
                                    //         //       const SnackBar(
                                    //         //           duration: Duration(seconds: 1),
                                    //         //           content: Text(
                                    //         //               'Invalid Email & Invalid Password')),
                                    //         //     );
                                    //         //   }
                                    //         // },
                                    //         ,
                                    //         child: Text("Log in"))),

                                    SizedBox(height: 10),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Doesn't have an account? "),
                                        GestureDetector(
                                            onTap: () {
                                             context.read<LoginBloc>().add(OnSignupEvent());
                                            },
                                            child: Text("Sign up",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .highlightColor)))
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ])
                  ],
                );
              }
              return SizedBox.shrink(
                child:Text("Nothing to Show......")
              );
            }))));
  }
}
