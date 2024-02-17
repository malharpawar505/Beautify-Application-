import 'dart:async';

import 'package:beautify/Model/global.dart';
import 'package:beautify/Model/userDataModel.dart';
import 'package:beautify/Screens/HomePage.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/login/NoInternert_splash.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/sharedPrefClass.dart';
import '../Widgets/AccountSetup.dart';
import 'package:http/http.dart' as http;

late String userName;
List<String> vechicleList =[];

List<dynamic> check_bool =[];
List<AdminId> adminData = [];

List<UserHistory> userHistory =[];
List<Product> historyProducts =[];


var companyIdData = [];
var companyNameMap = {
  "101": "MamaEarth",
  "102":"Maybelline",
  "103": "Lakme"
};

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isConnected = false;
  bool isloading= true;

  TextEditingController textediting = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState

    // checkConnection();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //     colors: [
        //       Color(0xFF4B6EE8), //0xFFC0CBF1
        //       Color(0xFFC0CBEA), //0xFF9985AD
        //     ],
        //     // stops: [0.1, 0.4],
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: size.height/2.5,
            //   child: const Center(child: rv.RiveAnimation.asset(
            //     'images/car.riv',
            //   )),
            // ),
            const Text("Beautify", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 0.8),),
            isloading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(),

            TextFormField(
              decoration: const InputDecoration(

              ),
              controller: textediting,
            ),
            ElevatedButton(
              child: const Text("Submit"),
              onPressed: (){
                if(textediting.text.isEmpty){
                  Fluttertoast.showToast(msg: "Enter Ip Address");
                }else{
                  ip = textediting.text;
                  checkServerConnection();
                }


              },
            ),
          ],
        ),
      ),
    );
  }


  // Future<void> checkConnection() async {
  //   final connected = await checkServerConnection();
  //   print("uiooo");
  //   Timer(const Duration(seconds: 3), () async {
  //     print("asan");
  //     if (connected) {
  //       setState(() {
  //         userName = UserSharedprefs.getName() ?? '';
  //         String adminId = UserSharedprefs.getAdminId() ?? '';
  //         if (adminId != '') {
  //           Api.getAdminData(adminId).then((value) {
  //             print(adminData[0].adminId);
  //             check_bool = adminData[0].companyId!;
  //             adminData[0].companyId?.forEach((element) {
  //               companyIdData.add("$element");
  //             });
  //           });
  //           Api.getServices().then((value) {});
  //           Api.getMonthlySale(adminId).then((value) {
  //             // userData.sort((a, b) => a.uName.compareTo(b.uName));
  //             // userData.forEach((element) {
  //             //   print(element.uDate);
  //             // });
  //             print("monthly Sale Retrived");
  //             monthlySale.sort((a, b) => a.month.compareTo(b.month));
  //           });
  //           Api.getUserData(adminId).then((value) {
  //             print("User Data Retrived");
  //           });
  //         } else {
  //           print("Account Can't be fetched");
  //         }
  //         // print(userName.toString());
  //       });
  //       if (userName.isEmpty) {
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccountSetUP()));
  //       } else {
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
  //       }
  //     } else {
  //       Navigator.push(context, MaterialPageRoute(builder: (_) => NoInternet()));
  //     }
  //   });
  // }


  // Future<bool> checkServerConnection() async {
  //   const String serverUrl = 'https://beautify3.onrender.com/';
  //
  //   try {
  //     final response = await http.get(Uri.parse(serverUrl));
  //
  //     if (response.statusCode == 200) {
  //       //3
  //       print("cnnected");
  //       return true; // Server is reachable
  //     } else {
  //       return false; // Server is not reachable
  //     }
  //   } catch (e) {
  //     return false; // Error occurred, server is not reachable
  //   }
  // }


  Future<bool> checkServerConnection() async {
    String serverUrl = 'http://$ip:8080/';

    try {
      print(serverUrl);
      final response = await http.get(Uri.parse(serverUrl));

      if (response.statusCode == 200) {

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
      Fluttertoast.showToast(msg: e.toString());
      return false; // Error occurred, server is not reachable
    }
  }


}
//
// List<DropdownMenuItem<String>> get vechicleType {
//   List<DropdownMenuItem<String>> menuItems = const [
//     DropdownMenuItem(value: "Aura", child: Text("Aura")),
//     DropdownMenuItem(value: "Activa", child: Text("Activa")),
//     DropdownMenuItem(value: "Shine", child: Text("Shine")),
//   ];
//   return menuItems;
// }

// List<DropdownMenuItem<String>> get vehicleType {
//   // List<String> types = ['Aura', 'Activa', 'Shine'];
//   // vechicleList
//   List<DropdownMenuItem<String>> menuItems = List.generate(
//     vechicleList.length,
//         (index) => DropdownMenuItem(
//       value: vechicleList[index],
//       child: Text(vechicleList[index]),
//     ),
//   );
//   return menuItems;
// }
