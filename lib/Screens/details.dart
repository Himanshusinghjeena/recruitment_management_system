import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Screens/Inactive.dart';
import 'package:recruitment_management_system/Screens/active.dart';
import 'package:recruitment_management_system/Services/api.dart';
import 'package:recruitment_management_system/Services/dbhelper.dart';

class Details extends StatefulWidget {
  Candidates? candidate;
  bool active;
  Details({this.candidate, required this.active});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String? dropdownvalue;
  var status = [
    'new',
    'in_progress',
    'rejected',
    'selected',
  ];
  @override
  void initState() {
    super.initState();
    dropdownvalue = widget.candidate!.recruitmentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).canvasColor,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(height: 30),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Image.asset(
                        fit: BoxFit.fill,
                        widget.candidate!.gender == "Male"
                            ? 'assets/images/default_male.jpg'
                            : 'assets/images/default_female.jpg',
                      ).image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                    "${widget.candidate!.firstName} ${widget.candidate!.lastName} (${widget.candidate!.gender})",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 30))
              ]),
            ),
          ),
          Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon:  Icon(color:Theme.of(context).canvasColor,Icons.arrow_back, size: 40),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          Positioned(
              top: 240,
              left: 30,
              right: 30,
              child: Expanded(
                  child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text.rich(TextSpan(
                        text: "Recruitment Number: ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                        children: [
                          TextSpan(
                              text: "${widget.candidate!.recruitmentNumber}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22))
                        ])),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text.rich(TextSpan(
                        text: "Contact No. : ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                        children: [
                          TextSpan(
                              text: widget.candidate!.phone ?? "Contact Number",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22))
                        ])),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: SizedBox(
                            width: 320,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Address : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      widget.candidate!.street!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      widget.candidate!.city ?? "Address",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text.rich(TextSpan(
                        text: "Email : ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                        children: [
                          TextSpan(
                              text: "${widget.candidate!.email ?? "Email"} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22))
                        ])),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text.rich(TextSpan(
                        text: "Designation : ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                        children: [
                          TextSpan(
                              text:
                                  "${widget.candidate!.appliedDesignation ?? "Applied Designation"} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22))
                        ])),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          "Status:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          width: 200, // Set the width of the DropdownButton
                          height: 50, // Set the height of the DropdownButton
                          child: DropdownButton(
                            value: dropdownvalue,
                            icon:
                                const Icon(Icons.keyboard_arrow_down, size: 40),
                            items: status.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]))),
          Positioned(
            bottom: 50,
            right: 30,
            child: ElevatedButton(
              onPressed: () async {
                await AppDataBase().updateCandidateStatus(
                    widget.candidate!.recruitmentNumber, dropdownvalue!);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Candidate status updated successfully!"),
                    backgroundColor: Colors.green,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(5),
                  ),
                );
                if (widget.active) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ActiveScreen()),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InActiveScreen()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.lightBlueAccent,
              ),
              child: const Text("Save", style: TextStyle(fontSize: 25)),
            ),
          ),
        ],
      ),
    ))


        );
  }
}
