import 'dart:async';

// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:beautify/Screens/HomePage.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/login/splashScreen..dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:my_car_expense/DB/dbClass.dart';
// import 'package:my_car_expense/Screens/signup_widgets.dart';
// import 'package:my_car_expense/Screens/splashScreen..dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../Model/sharedPrefClass.dart';

// import 'bottomNavigation.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _address = TextEditingController();

  int selectedNo = 1;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isloading = false;


  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username.text = UserSharedprefs.getName() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("jsd"),
      // ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
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
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 80,
                ),

                // User Name TextField
                NameTextField(size: size, username: _username),
                const SizedBox(height: 30),

                MobileTextField(size: size, username: _mobile),
                const SizedBox(height: 30),

                AddressTextField(size: size, username: _address),
                const SizedBox(height: 30),
                // Sign UP button
                Container(
                  height: 50,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // gradient: const LinearGradient(
                      //     colors: [
                      //       Color(0xFFFFB473),
                      //       Color(0xFFFF42BA)
                      //     ],
                      //     begin: Alignment.centerLeft,
                      //     end: Alignment.centerRight)),
                    color: Colors.black
                  ),
                  child: Center(
                    child: TextButton(

                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          insertData();
                          Timer(const Duration(seconds: 2), () async {
                            setState(() {
                              String adminId = UserSharedprefs.getAdminId() ?? '';
                              if(adminId!=''){
                                Api.getAdminData(adminId).then((value) {
                                  print(adminData[0].adminId);
                                  check_bool = adminData[0].companyId!;
                                  adminData[0].companyId?.forEach((element) {
                                    companyIdData.add("$element");
                                  });
                                });

                              }else{
                                print("Account Can't be fetched");
                              }

                            });
                            Fluttertoast.showToast(msg: "Sign Up Successfully");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          });
                        }
                      },
                      child: isloading? const CircularProgressIndicator(): const Text(
                        "Sign Up",
                        style:  TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void insertData() async {
    setState(() {
      isloading= true;
    });
    var uuid = Uuid();
    String Admin_id =  uuid.v4();
    await UserSharedprefs.setName(_username.text);
    await UserSharedprefs.setAdminId(Admin_id);
    var data ={
      "admin_name":_username.text,
      "admin_phone": _mobile.text,
      "admin_address":_address.text,
      "admin_id": Admin_id,
    };
    Api.addAdmin(data);

  }
}


class NameTextField extends StatelessWidget {
  const NameTextField({
    Key? key,
    required this.size,
    required TextEditingController username,
  }) : _username = username, super(key: key);

  final Size size;
  final TextEditingController _username;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 17,
      width: size.width / 1.5,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          const Icon(Icons.person),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: size.width / 1.5 - 54,
              child: TextFormField(
                // textAlign: TextAlign.center,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Text is empty';
                  }
                  return null;
                },
                controller: _username,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: 'Enter User Name',
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileTextField extends StatelessWidget {
  const MobileTextField({
    Key? key,
    required this.size,
    required TextEditingController username,
  }) : _mobile = username, super(key: key);

  final Size size;
  final TextEditingController _mobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 17,
      width: size.width / 1.5,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          const Icon(Icons.phone),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: size.width / 1.5 - 54,
              child: TextFormField(
                // textAlign: TextAlign.center,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Text is empty';
                  }
                  if(text.length != 10 ){
                    return 'Number must be 10 digit';
                  }
                  return null;
                },
                controller: _mobile,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: 'Enter Mobile Number',
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    Key? key,
    required this.size,
    required TextEditingController username,
  }) : _address = username, super(key: key);

  final Size size;
  final TextEditingController _address;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 17,
      width: size.width / 1.5,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          const Icon(Icons.location_on),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: size.width / 1.5 - 54,
              child: TextFormField(
                // textAlign: TextAlign.center,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Text is empty';
                  }
                  return null;
                },
                controller: _address,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: 'Enter Address',
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}