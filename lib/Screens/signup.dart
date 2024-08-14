// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_final_fields, non_constant_identifier_names, avoid_print, unnecessary_null_comparison, use_build_context_synchronously, unnecessary_string_interpolations, await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_management_system/bloc/signup/signup_bloc.dart';
import 'package:recruitment_management_system/bloc/signup/signup_event.dart';
import 'package:recruitment_management_system/components/button.dart';
import 'package:recruitment_management_system/components/customInput.dart';
import 'package:recruitment_management_system/components/customSnackbar.dart';
import 'package:recruitment_management_system/database/dbhelper.dart';

import '../bloc/signup/signup_state.dart';
import '../constant/constant.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  TextEditingController usernameController = TextEditingController();
  RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,16}$');

  TextEditingController passwordController = TextEditingController();
  RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{4,12}$');

  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RegExp phoneRegExp = RegExp(r'^[6789]\d{9}$');

  final signupkey = GlobalKey<FormState>();
  var agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<SignupBloc>(
            create: (context) => SignupBloc(),
            child: BlocListener<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state is SignupSuccessState) {
                  CustomSnackBar.show(
                    context,
                    "Signup Successfully.........",
                    backgroundColor: Theme.of(context).primaryColor,
                  );
                  // AppDataBase().addAdmin();
                  Navigator.pushNamed(context, '/');
                }
                if (state is AlreadySignupState) {
                  Navigator.pushNamed(context, '/');
                }
                if (state is SignupFailureState) {
                  CustomSnackBar.show(
                    context,
                    state.message,
                    backgroundColor: Theme.of(context).primaryColor,
                  );
                }
              },
              child: BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                if (state is InitialState) {
                  return Stack(children: [
                    Container(
                        color: Theme.of(context).primaryColor,
                        height: MediaQuery.of(context).size.height),
                    Column(children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.6,
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
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                            decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40),
                                )),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                const SizedBox(height: 15),
                                Form(
                                    key: signupkey,
                                    child: Column(children: [
                                      Text(
                                        signupHeader,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 30),
                                      CustomInputField(
                                        controller: usernameController,
                                        icon: Icon(Icons.person),
                                        labelText: "Username",
                                        hintText: "Enter Username",
                                        validator: (value) {
                                          if (value!.isEmpty || value == null) {
                                            return 'Please enter Username';
                                          } else if (usernameController
                                                      .text.length >
                                                  16 ||
                                              usernameController.text.length <=
                                                  3) {
                                            return "Username length should be greater than 3 and less than 16";
                                          } else if (!usernameRegExp
                                              .hasMatch(value)) {
                                            return "Please Enter a Valid Username";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      CustomInputField(
                                        controller: emailController,
                                        icon: Icon(Icons.email_outlined),
                                        labelText: 'Email',
                                        hintText: "Enter Email",
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                      const SizedBox(height: 15),
                                      CustomInputField(
                                        controller: passwordController,
                                        icon: Icon(Icons.key),
                                        labelText: 'Password',
                                        hintText: "Enter Password",
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
                                      const SizedBox(height: 15),
                                      CustomInputField(
                                        controller: repeatPasswordController,
                                        icon: Icon(Icons.key),
                                        labelText: 'Confirm Password',
                                        hintText: "re-type Password",
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please confirm your password';
                                          }
                                          if (value !=
                                              passwordController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        suffixIcon: true,
                                      ),
                                      const SizedBox(height: 15),
                                      CustomInputField(
                                        controller: phoneController,
                                        icon: Icon(Icons.phone_outlined),
                                        labelText: 'Phone No.',
                                        hintText: "Enter Phone Number",
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value!.isEmpty || value == null) {
                                            return 'Please enter Phone Number';
                                          } else if (!phoneRegExp
                                              .hasMatch(value)) {
                                            return "Please Enter A Valid phone Number";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: agree,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                agree = value!;
                                              });
                                            },
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Text("I agree to the Processing of ",
                                              style: TextStyle(
                                                  color: Colors.black45)),
                                          Text("Personal Data ",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      CustomButton(
                                          innerText: "SignUp",
                                          onPressed: () {
                                            if (signupkey.currentState!
                                                    .validate() &&
                                                agree) {
                                              context.read<SignupBloc>().add(
                                                  OnSignupSuccessEvent(

                                                          usernameController
                                                              .text,
                                                          emailController.text,

                                                          passwordController
                                                              .text,
                                                       phoneController
                                                          .text));
                                            } else if (signupkey.currentState!
                                                    .validate() &&
                                                agree == false) {
                                              context.read<SignupBloc>().add(
                                                  OnSignupFailureEvent(
                                                      message:
                                                          "Please Agree the term's and Services"));
                                            }
                                            else{
                                              context.read<SignupBloc>().add(OnSignupFailureEvent(message:"Login failure"));
                                            }
                                          }),
                                      // Container(
                                      //     decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(20)),
                                      //     width: double.infinity,
                                      //     child: ElevatedButton(
                                      //         onPressed: () {
                                      //           Navigator.push(
                                      //               context,
                                      //               MaterialPageRoute(
                                      //                   builder: (context) => Home()));
                                      //           // if (signupkey.currentState!.validate() &&
                                      //           //     agree &&
                                      //           //     selectedDate != null) {
                                      //           //   // await Sharedpref().saveUserProfile(
                                      //           //   //     username: usernameController.text,
                                      //           //   //     email: emailController.text,
                                      //           //   //     password: passwordController.text,
                                      //           //   //     address: addressController.text,
                                      //           //   //     phone: phoneController.text,
                                      //           //   //     dob: date!,
                                      //           //   //     profilePicPath:
                                      //           //   //     profilepic?.path ?? "no-image");
                                      //           //   // Navigator.push(
                                      //           //   //     context,
                                      //           //   //     MaterialPageRoute(
                                      //           //   //         builder: (context) =>
                                      //           //   //             LogInScreen()));
                                      //           //   ScaffoldMessenger.of(context)
                                      //           //       .showSnackBar(
                                      //           //     SnackBar(
                                      //           //       duration: Duration(seconds: 1),
                                      //           //       content:
                                      //           //       Text('Sign up Successfully'),
                                      //           //     ),
                                      //           //   );
                                      //           // } else if (signupkey.currentState!
                                      //           //     .validate() &&
                                      //           //     agree == false) {
                                      //           //   ScaffoldMessenger.of(context)
                                      //           //       .showSnackBar(
                                      //           //     SnackBar(
                                      //           //       duration: Duration(seconds: 1),
                                      //           //       content: Text(
                                      //           //           'Please Agree the Policy & Services'),
                                      //           //     ),
                                      //           //   );
                                      //           // } else if (!signupkey.currentState!
                                      //           //     .validate()) {
                                      //           //   ScaffoldMessenger.of(context)
                                      //           //       .showSnackBar(
                                      //           //     SnackBar(
                                      //           //       duration: Duration(seconds: 1),
                                      //           //       content: Text(
                                      //           //           'Please Fill Correct Details'),
                                      //           //     ),
                                      //           //   );
                                      //           // } else if (signupkey.currentState!
                                      //           //     .validate() &&
                                      //           //     agree &&
                                      //           //     selectedDate == null) {
                                      //           //   ScaffoldMessenger.of(context)
                                      //           //       .showSnackBar(
                                      //           //     SnackBar(
                                      //           //       duration: Duration(seconds: 1),
                                      //           //       content: Text(
                                      //           //           'Please Select you Date Of Birth'),
                                      //           //     ),
                                      //           //   );
                                      //           // }
                                      //         },
                                      //         style: ElevatedButton.styleFrom(
                                      //           backgroundColor:
                                      //               const Color.fromARGB(255, 7, 73, 127),
                                      //           foregroundColor: Colors.white,
                                      //         ),
                                      //         child: Text("Sign up"))),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Already have an account? ',
                                            style: TextStyle(
                                              color: Colors.black45,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<SignupBloc>()
                                                  .add(OnLoginEvent());
                                            },
                                            child: Text(
                                              'Log in',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20)
                                    ]))
                              ]),
                            ),
                          ))
                    ])
                  ]);
                }
                return SizedBox.shrink(child: Text("Nothing Here...."));
              }),
            )));
  }
}

int calcAge(DateTime selectedDate) {
  DateTime now = DateTime.now();
  DateTime dob = selectedDate;
  int age = now.year - dob.year;
  // Sharedpref().setAge(age);
  return age;
}
