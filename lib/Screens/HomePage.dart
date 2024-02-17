import 'dart:io';

import 'package:beautify/Model/global.dart';
import 'package:beautify/Model/userDataModel.dart';
import 'package:beautify/Screens/Customers.dart';
import 'package:beautify/Screens/Statistics/allSats.dart';
import 'package:beautify/Screens/adminData.dart';
import 'package:beautify/Screens/scheduling.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:uuid/uuid.dart';

import '../Model/sharedPrefClass.dart';
import '../login/splashScreen..dart';
import 'adminCompanyPanel.dart';
import 'demograph.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    // print(adminData[0].adminId);
    // print(adminData[0].companyId);
    // check_bool = adminData[0].companyId!;
    // // adminData[0].companyId?.forEach((element) {
    // //             //   companyIdData.add("$element");
    // //             // });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var h = size.height;
    var w = size.width;
    return WillPopScope(
      onWillPop:(){
        exit(0);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () async {
                  String adminId = UserSharedprefs.getAdminId() ?? '';
                  await Api.getAdminData(adminId).then((value) {
                    print(adminData[0].adminId);
                    check_bool = adminData[0].companyId!;
                    adminData[0].companyId?.forEach((element) {
                      companyIdData.add("$element");
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const AdminData()));

                  });
                },
                icon: const Icon(Icons.person),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: kToolbarHeight + 56,
              ),
              // SizedBox(height: h/,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 30, bottom: 15),
                    child: Text("Beautify",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.7
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100,),
              Column(
                children: [

                  // Stats
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary2,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        height: h/11,
                        child: Row(
                          children: [
                            Container(
                              // color: Colors.grey,
                              width: w/4,
                              child: const Icon(Icons.analytics_outlined, size: 35,),
                            ),
                            Container(
                              width: w/2,
                              height: h/11,
                              // color: Colors.redAccent,
                              child: Column(
                                children: [
                                  Container(
                                    height: h/22,
                                    // color: Colors.grey,
                                    child: const Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Real-Time Stats",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: h/22,
                                    child: const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Track your Success",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueGrey,

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // color: Colors.grey,
                              width: w/4-20,
                              child: IconButton(
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => const HomePageStats()));
                                },
                                icon: Icon(Icons.arrow_forward_ios, size: 20,),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // scheduling
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary2,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GestureDetector(
                        onTap: ()  {



                        },
                        child: Container(
                          height: h/11,
                          child: Row(
                            children: [
                              Container(
                                // color: Colors.grey,
                                width: w/4,
                                child: const Icon(Icons.schedule, size: 35,),
                              ),
                              Container(
                                width: w/2,
                                height: h/11,
                                // color: Colors.redAccent,
                                child: Column(
                                  children: [
                                    Container(
                                      height: h/22,
                                      // color: Colors.grey,
                                      child: const Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Smart Scheduling",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,

                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: h/22,
                                      child: const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Plan Like a PRO",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blueGrey,

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // color: Colors.grey,
                                width: w/4-20,
                                child: IconButton(
                                  onPressed: () async{
                                    String adminId = UserSharedprefs.getAdminId() ?? '';
                                    await Api.getSchedule(adminId).then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => const Scheduling()));
                                      print("Scheduled Received");
                                      print(prettyJson(schedule));
                                    });
                                  },
                                  icon: Icon(Icons.arrow_forward_ios, size: 20,),
                                )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Customers
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary2,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          String adminId = UserSharedprefs.getAdminId() ?? '';

                        },
                        child: Container(
                          height: h/11,
                          child: Row(
                            children: [
                              Container(
                                // color: Colors.grey,
                                width: w/4,
                                child: const Icon(Icons.people_alt_outlined, size: 35,),
                              ),
                              Container(
                                width: w/2,
                                height: h/11,
                                // color: Colors.redAccent,
                                child: Column(
                                  children: [
                                    Container(
                                      height: h/22,
                                      // color: Colors.grey,
                                      child: const Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Customers",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,

                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: h/22,
                                      child:const  Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Access your Customers",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blueGrey,

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // color: Colors.grey,
                                width: w/4-20,
                                child: IconButton(
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const Customers()));
                                  },
                                  icon: Icon(Icons.arrow_forward_ios, size: 20,),
                                )                            ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h/8,),
            ],
          ),
        ),
      ),
    );
  }
}
