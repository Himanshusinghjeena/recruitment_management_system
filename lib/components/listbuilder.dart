import 'package:flutter/material.dart';
import 'package:recruitment_management_system/Screens/details.dart';
import 'package:recruitment_management_system/Services/api.dart';


class CustomListBuilder extends StatefulWidget {
  final List<Candidates> candidate;
  bool active;
  CustomListBuilder({required this.candidate, required this.active});

  @override
  State<CustomListBuilder> createState() => _CustomListBuilderState();
}

class _CustomListBuilderState extends State<CustomListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.candidate.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(
                          active: widget.active,
                          candidate: widget.candidate[index]),
                    ),
                  );
                },
                child: ListTile(
                  leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: Image.asset(
                          fit: BoxFit.fill,
                          widget.candidate[index].gender == "Male"
                              ? 'assets/images/default_male.jpg'
                              : 'assets/images/default_female.jpg',
                        ).image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  title: Text(
                    '${widget.candidate[index].firstName ?? 'first'} ${widget.candidate[index].lastName ?? 'last'}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Mob:  ${widget.candidate[index].phone}" ?? '',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  // Text(
                  //   widget.candidate[index].recruitmentStatus ?? 'get-out',
                  //   style: TextStyle(
                  //     color: widget.candidate[index].recruitmentStatus == 'rejected'
                  //         ? Colors.red
                  //         : widget.candidate[index].recruitmentStatus == 'selected'
                  //         ? Colors.green
                  //         : Colors.black,
                  //     fontSize: 18,
                  //   ),
                  // ),
                  trailing: Text(
                    widget.candidate[index].appliedDesignation ?? '',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
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
