import 'package:flutter/material.dart';

import '../Model/sharedPrefClass.dart';
import '../Screens/HomePage.dart';
import '../login/Signup.dart';

class AccountSetUP extends StatefulWidget {
  const AccountSetUP({Key? key}) : super(key: key);

  @override
  _AccountSetUPState createState() => _AccountSetUPState();
}

class _AccountSetUPState extends State<AccountSetUP> {
  String ass= "Lets SetUp Your";
  String asw = "Account";

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30,top: 140),
            child: Container(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's SetUp Your",
                    style: TextStyle(
                        fontSize: 50
                    ),
                  ),
                  Text(
                    'Account',
                    style:  TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  )
                ],
              ),
            ),
          ),

          const Spacer(),
          // button
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (_)=> Signup()));
              },
              child: Container(
                width: size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // gradient: const LinearGradient(
                    //     colors: [
                    //       Color(0xFFFFB473),
                    //       Color(0xFFFF42BA)
                    //     ],
                    //     begin: Alignment.centerLeft,
                    //     end: Alignment.centerRight)
                  color: Colors.black
                ),
                child: const Center(
                  child: Text(
                    "Sign up",
                    style:  TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60,),
        ],
      ),
    );
  }
}
