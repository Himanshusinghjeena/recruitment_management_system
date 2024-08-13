import 'package:flutter/material.dart';
import 'package:recruitment_management_system/api/api.dart';
import 'package:recruitment_management_system/database/dbhelper.dart';

class Details extends StatefulWidget {
  Candidates? candidate;
  Details(this.candidate);
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
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.lightBlueAccent,
          child: Stack(
            children: [
              const Positioned(
                top: 10,
                left: 30,
                child: CircleAvatar(
                  radius: 70,
                  child: Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
              ),
              Positioned(
                top: 180,
                right: 40,
                left: 40,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                            "Recruitment Number: ${widget.candidate!.recruitmentNumber}",
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            "Name: ${widget.candidate!.firstName} ${widget.candidate!.lastName}",
                            style: const TextStyle(fontSize: 20)),
                        Text("Email: ${widget.candidate!.email}",
                            style: const TextStyle(fontSize: 20)),
                        Text("Phone: ${widget.candidate!.phone}",
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            "Address: ${widget.candidate!.street}, ${widget.candidate!.city ?? "Address"} ",
                            style: const TextStyle(fontSize: 20)),
                        Text("Gender: ${widget.candidate!.gender}",
                            style: const TextStyle(fontSize: 20)),
                        Row(
                          children: [
                            const Text("Status:",
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 15),
                            DropdownButton(
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: status.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items,
                                      style: const TextStyle(fontSize: 20)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),

                        // Text("Status: ${widget.candidate!.recruitmentStatus}",
                        //     style: const TextStyle(fontSize: 20)),
                        Text(
                            "Designation: ${widget.candidate!.appliedDesignation}",
                            style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 90,
                right: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await AppDataBase().updateCandidateStatus(widget.candidate!.recruitmentNumber,
                        dropdownvalue! );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Candidate status updated successfully!"),
                        backgroundColor: Colors.green,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                      ),
                    );
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
        ),
      ),
    );
  }
}
