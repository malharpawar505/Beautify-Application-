// ignore_for_file: prefer_const_constructors

import 'package:beautify/Model/sharedPrefClass.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();

  DateTime selectedDate = DateTime.now();
// String data = DateFormat('dd-MM-yyyy').format(selectedDate).toString();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    var h = s.height;
    var w = s.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 70,
            width: w,
            color: primary,
          ),
          Container(
            height: 70,
            width: w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Center(
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.black
                ),
                child: IconButton(
                  onPressed: () {
                    print(_name.text);
                    String admin_id = UserSharedprefs.getAdminId() ?? '';
                    var date = DateTime.now(); // Replace with the actual dat
                    var year = date.year;
                    var month = date.month;
                    var day= date.day;
                    var dateString = "${year}-${month}-${day}";
                    var data = {
                      "user_name": _name.text,
                      "user_mobile": _mobile.text,
                      "user_address": _address.text,
                      "user_email": _email.text,
                      "adminid": admin_id,
                      "user_date":dateString
                    };
                    print(data);
                    Api.addUser(data);

                    print("success");

                    Fluttertoast.showToast(msg: "Data Added Successfully");
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.insert_drive_file,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: h,
          decoration: const BoxDecoration(
            color: Colors.white
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //     Color(0xFFD882E5), //0xFFC0CBF1
            //     Color(0xFFC0CBEA), //0xFF9985AD
            //   ],
            //   // stops: [0.1, 0.4],
            // ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: kToolbarHeight + 56,
              ),
              // title
              SizedBox(
                height: (h / 3) - 50,
                width: w,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 50),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                         Text(
                          "Add Your Customers",
                          style: TextStyle(fontSize: 35),
                        ),
                        Text(
                          'Details',
                          style: TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold,),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: w,
                // color: Colors.blueAccent,
                child: Padding(
                  padding: EdgeInsets.only(left: 25, top: 10),
                  child: Text(
                    "Details :",
                    style: TextStyle(fontSize: 20, color: black),
                  ),
                ),
              ),
              // Container
              Container(
                height: h / 3,
                width: w,
                child: Column(
                  children: [
                    // name
                    Container(
                      height: (h / 3) / 5,
                      width: w,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                          ),
                          bottom: BorderSide.none,
                          left: BorderSide(
                            width: 1,
                          ),
                          right: BorderSide(
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: w / 3,
                            decoration: BoxDecoration(
                                border:
                                    Border(right: BorderSide(width: 1))),
                            child: Center(
                              child: Text(
                                "Name",
                                style:
                                    TextStyle(fontSize: 15, color: black),
                              ),
                            ),
                          ),
                          Container(
                            width: ((2 * w) / 3) - 2,
                            child: Center(
                              child: TextFormField(
                                controller: _name,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // _mobile
                    Container(
                      height: (h / 3) / 5,
                      width: w,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                          ),
                          bottom: BorderSide.none,
                          left: BorderSide(
                            width: 1,
                          ),
                          right: BorderSide(
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: w / 3,
                            decoration: BoxDecoration(
                                border:
                                    Border(right: BorderSide(width: 1))),
                            child: Center(
                              child: Text(
                                "Mobile",
                                style:
                                    TextStyle(fontSize: 15, color: black),
                              ),
                            ),
                          ),
                          Container(
                            width: ((2 * w) / 3) - 2,
                            child: Center(
                              child: TextFormField(
                                controller: _mobile,
                                textAlign: TextAlign.center,

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // address
                    Container(
                      height: (h / 3) / 5,
                      width: w,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                          ),
                          bottom: BorderSide.none,
                          left: BorderSide(
                            width: 1,
                          ),
                          right: BorderSide(
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: w / 3,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(width: 1))),
                            child: Center(
                              child: Text(
                                "Address",
                                style: TextStyle(
                                    fontSize: 15, color: black),
                              ),
                            ),
                          ),
                          Container(
                            height: 2 * ((h / 3) / 5),
                            width: (2 * w / 3) - 2,
                            child: Container(
                              width: ((2 * w) / 3) - 2,
                              child: Center(
                                child: TextFormField(
                                  controller: _address,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(border: InputBorder.none,
                                    hintStyle: const TextStyle(
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // email
                    Container(
                      height: (h / 3) / 5,
                      width: w,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                          ),
                          bottom: BorderSide(
                            width: 1,
                          ),
                          left: BorderSide(
                            width: 1,
                          ),
                          right: BorderSide(
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: w / 3,
                            decoration: BoxDecoration(
                                border:
                                    Border(right: BorderSide(width: 1))),
                            child: Center(
                              child: Text(
                                "E-mail",
                                style:
                                    TextStyle(fontSize: 15, color: black),
                              ),
                            ),
                          ),
                          Container(
                            width: ((2 * w) / 3) - 2,
                            child: Center(
                              child: TextFormField(
                                controller: _email,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(border: InputBorder.none,
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
