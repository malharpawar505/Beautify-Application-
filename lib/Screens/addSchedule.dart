import 'package:beautify/Model/global.dart';
import 'package:beautify/Model/sharedPrefClass.dart';
import 'package:beautify/Screens/Customers.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pretty_json/pretty_json.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {

  String selectedTimeSlot = '';
  List<String> timeSlots = [
    '9:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 1:00 PM',
    '1:00 PM - 2:00 PM',
    '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM',
    '4:00 PM - 5:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    var h = s.height;
    var w = s.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
          onPressed: () {
            if(selectedTimeSlot != ""){
              addData();
            }else{
              Fluttertoast.showToast(msg: "Select Time Slot");
            }
          },
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Add Schedule"),
          ),
          elevation: 0,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: kToolbarHeight + 56,
              // color: Colors.greenAccent,
            ),
            Container(
              height: 60,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Customer Name : ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54
                    ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(userData[userDataIndex].uName,style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      ),),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Time Slot : ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black, // Set the desired background color
                          onPrimary: Colors.white, // Set the text color
                        ),
                        onPressed: () {
                          _showTimeSlotSelection(context);
                        },
                        child: Text('Select Time Slot'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 60,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: w/5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(selectedTimeSlot,style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      ),),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: productInCart.length + servicesInCart.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                  var name = servicesList[index].name;
                  var price = servicesList[index].price;
                  var time = servicesList[index].time;
                  var id = servicesList[index].id;
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
                          "$price, $time min",
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
                          icon: Icon(Icons.delete),
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

  void _showTimeSlotSelection(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          // color: primary2,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Time Slot',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  final timeSlot = timeSlots[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeSlot = timeSlot;
                      });
                      Navigator.pop(context);
                    },
                    child: Card(
                      elevation: 0,
                      color: selectedTimeSlot == timeSlot ? Colors.blue : primary2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            timeSlot,
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedTimeSlot == timeSlot ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void addData() async{
    String adminId = UserSharedprefs.getAdminId() ?? '';
    var date = DateTime.now(); // Replace with the actual dat
    var year = date.year;
    var month = date.month;
    var day= date.day;
    var dateString = "${year}-${month}-${day}";
    var data =
    {
      "adminid": "$adminId",
      "userid": "${userData[userDataIndex].id}",
      "name":"${userData[userDataIndex].uName}",
      "date": "$dateString",
      "time": "$selectedTimeSlot",
      "comments": ".",
      "complete": "false"
    };
    print(prettyJson(data));
    await Api.addSchedule(data);
    Navigator.pop(context);
  }
}
