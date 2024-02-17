import 'dart:async';

import 'package:beautify/login/splashScreen..dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../Model/global.dart';
import '../Model/sharedPrefClass.dart';
import '../Screens/HomePage.dart';
import '../Services/api.dart';
import '../Widgets/AccountSetup.dart';
import 'package:http/http.dart' as http;

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  bool isloading = false;
  // DocumentSnapshot varible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataupload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/nointernet.json", height: 270, width: 270),
                    const SizedBox(
                      height: 150,
                    ),
                    const Text("Cannot Connet to Server",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        )),
                    Container(
                      child: isloading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              child: const Text("Retry"),
                              onPressed: () {
                                setState(() {
                                  isloading = true;
                                });
                                // checkConnection();
                                checkServerConnection();
                              },
                            ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> checkConnection() async {
  //   final connected = await checkServerConnection();
  //   bool isConnected = connected;
  //   try{
  //     Timer(const Duration(seconds: 3), () async {
  //       if (isConnected) {
  //
  //       } else {
  //
  //       }
  //     });
  //   }catch(e){
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  Future<bool> checkServerConnection() async {
    String serverUrl = 'http://$ip:8080/';

    try {
      final response = await http.get(Uri.parse(serverUrl));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Connected to Server");

        userName = UserSharedprefs.getName() ?? '';
        String adminId = UserSharedprefs.getAdminId() ?? '';
        setState(() {
          if (adminId != '') {
            Api.getAdminData(adminId).then((value) {
              print(adminData[0].adminId);
              check_bool = adminData[0].companyId!;
              adminData[0].companyId?.forEach((element) {
                companyIdData.add("$element");
              });
            });
            Api.getServices().then((value) {});
            Api.getMonthlySale(adminId).then((value) {
              // userData.sort((a, b) => a.uName.compareTo(b.uName));
              // userData.forEach((element) {
              //   print(element.uDate);
              // });
              print("monthly Sale Retrived");
              monthlySale.sort((a, b) => a.month.compareTo(b.month));
            });
            Api.getUserData(adminId).then((value) {
              print("User Data Retrived");
            });
          } else {
            print("Account Can't be fetched");
          }
          // print(userName.toString());
        });
        if (userName.isEmpty) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccountSetUP()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
        }

        return true; // Server is reachable
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) => NoInternet()));
        return false; // Server is not reachable
      }
    } catch (e) {
      return false; // Error occurred, server is not reachable
    }
  }
}
