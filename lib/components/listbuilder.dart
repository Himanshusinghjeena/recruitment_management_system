import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Screens/details.dart';

import '../api/api.dart';

class CustomListBuilder extends StatefulWidget {
  final List<Candidates> candidate;
  CustomListBuilder({required this.candidate});

  @override
  State<CustomListBuilder> createState() => _CustomListBuilderState();
}

class _CustomListBuilderState extends State<CustomListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
               Expanded(
                flex: 2,
                child: Container(

                  // color:Colors.grey,
                  child: const Center(
                    child: Text(
                      ' Id',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  // color:Colors.pink,
                  child: const Center(
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),),

              Expanded(
                flex: 4,
                child: Container(
                  // color:Colors.amber,
                  child: const Text(
                    'Designation',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.candidate.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(widget.candidate[index]),
                    ),
                  );
                },
                child: ListTile(
                  leading: Text(
                    widget.candidate[index].recruitmentNumber ?? "recruit number",
                    style: const TextStyle(fontSize: 15),
                  ),
                  title: Text(
                    '${widget.candidate[index].firstName ?? 'first'} ${widget.candidate[index].lastName ?? 'last'}',
                    style: const TextStyle(
                        color: Colors.black, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.candidate[index].recruitmentStatus ?? 'get-out',
                    style: TextStyle(
                      color: widget.candidate[index].recruitmentStatus == 'rejected'
                          ? Colors.red
                          : widget.candidate[index].recruitmentStatus == 'selected'
                          ? Colors.green
                          : Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  trailing: Text(
                    widget.candidate[index].appliedDesignation ?? '',
                    style: const TextStyle(
                        color: Colors.black, fontSize: 15),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
