import 'package:beautify/Services/api.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:flutter/material.dart';

import '../login/splashScreen..dart';

class AdminCompanyP extends StatefulWidget {
  const AdminCompanyP({Key? key}) : super(key: key);

  @override
  State<AdminCompanyP> createState() => _AdminCompanyPState();
}

class _AdminCompanyPState extends State<AdminCompanyP> {
  List companyId = ["101", "102", "103"];
  List companyName = ["Mama Earth", "Maybelline", "Lakme"];

  @override
  void initState() {
    // TODO: implement initState
    print(companyIdData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Text("Add Company Panel"),
          ),
          elevation: 0,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: kToolbarHeight ,
              // color: Colors.greenAccent,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: companyId.length,
                  itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: primary2,
                    elevation: 0,
                    child: ListTile(
                      title: Text("${companyName[index]}"),
                      subtitle: Text("${companyId[index]}"),
                      trailing: !companyIdData.contains(companyId[index])
                          ? TextButton(
                        onPressed: () async {
                          // Subscribe button logic
                          // adminData[0].companyId?.add(companyId[index]);
                          // adminData[0].companyId?.forEach((element) {
                          //   print(element);
                          // });
                          // var data = {
                          //   "companyId" : companyIdData
                          // };

                          companyIdData.add("${companyId[index]}");
                          print(companyIdData);
                          print(adminData[0].id);
                          await Api.updateAdminProduct(
                              adminData[0].id, companyIdData);
                          setState(() {});
                        },
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
                        child: const Text(
                          'Subscribe',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      )
                          : TextButton(
                        onPressed: () async {
                          // Unsubscribe button logic
                          companyIdData.remove(companyId[index]);
                          await Api.updateAdminProduct(
                              adminData[0].id, companyIdData);
                          setState(() {});
                        },
                        child: const Text(
                          'Unsubscribe',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
