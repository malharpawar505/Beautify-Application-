import 'package:beautify/Model/global.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Scheduling extends StatefulWidget {
  const Scheduling({super.key});

  @override
  State<Scheduling> createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    var h = s.height;
    var w = s.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Daily Schedule"),
          ),
          elevation: 0,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: kToolbarHeight + 56,
              // color: Colors.greenAccent,
            ),
            schedule.isEmpty
                ? Center(child: Text("No Schedule Present"))
                : ListView.builder(
                    itemCount: schedule.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var name = schedule[index].name;
                      var complete = schedule[index].complete;
                      var time = schedule[index].time;
                      var id = schedule[index].id;
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: primary2,
                          elevation: 0,
                          child: ListTile(
                            title: Text(
                              name,
                              style: TextStyle(fontSize: 15),
                            ),
                            leading: Text(
                              "${index + 1}] ",
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              time,
                              style: const TextStyle(color: Colors.black54),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                if (kDebugMode) {
                                  print("---------------------------------");
                                }
                                servicesInCart.removeAt(index);
                                print(id);
                                serviceCartId.remove(id);
                                setState(() {});
                              },
                              icon: const Icon(Icons.info_outline),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
