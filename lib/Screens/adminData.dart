import 'package:beautify/Model/sharedPrefClass.dart';
import 'package:beautify/Screens/HomePage.dart';
import 'package:beautify/Screens/adminCompanyPanel.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../login/splashScreen..dart';

class AdminData extends StatefulWidget {
  const AdminData({Key? key}) : super(key: key);

  @override
  State<AdminData> createState() => _AdminDataState();
}

class _AdminDataState extends State<AdminData> {

  double i = 18;
  String name ="sds";
  String title = "sad";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var h = size.height;
    var w = size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () async {
                  await UserSharedprefs.setName("");
                },
                icon: Icon(Icons.delete))
          ],
          elevation: 0,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: kToolbarHeight + 56,
              color: Colors.white,
            ),
            Card(title: "Customer Name", name: "${adminData[0].name}", i: i),
            Card(title: "Phone Number", name: "+91 ${adminData[0].mobile}", i: i),
            Card(title: "Address", name: "${adminData[0].address}", i: i),
            Card(title: "Id", name: "${adminData[0].id}", i: 16),

            SizedBox(height: 30,),
            Container(
              child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty
                        .all<Color>(Colors
                        .black), // Set the background colo/ Add a border
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust the border radius as needed
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const AdminCompanyP()));

                  },
                  child: const Text("Admin Products Panel",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.title,
    required this.name,
    required this.i,
  });

  final String title;
  final String name;
  final double i;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      // color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$title : ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text( name ,style: TextStyle(
                  fontSize: i,
                  color: Colors.black
              ),),
            )
          ],
        ),
      ),
    );
  }
}
