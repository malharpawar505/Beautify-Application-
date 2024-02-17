// ignore_for_file: prefer_const_constructors

// import 'package:beauty_shop_management/Screens/AddCustomer.dart';
// import 'package:beauty_shop_management/Screens/AddProducts.dart';
// import 'package:beauty_shop_management/Widgets/color.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:beautify/Model/sharedPrefClass.dart';
import 'package:beautify/Model/userDataModel.dart';
import 'package:beautify/Screens/AddCustomer.dart';
import 'package:beautify/Screens/AddProducts.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:flutter/material.dart';

import '../Model/global.dart';
import '../Services/api.dart';
import '../login/splashScreen..dart';

List<UserDataModel> userData = [];

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  var items = {'Name', 'Date', 'New'};
  String? value;

  // UserDataFilter filter = UserDataFilter.all;
  bool sortAscending = true;
  String searchString = "";

  // Future<List<UserDataModel>> getUserData() async {
  //   // Retrieve all data from the API
  //   List<UserDataModel> allData = await Api.getUserData();
  //
  //   // Apply filtering based on the selected filter option
  //   // List<UserDataModel> filteredData=[];
  //   // switch (filter) {
  //   //   case UserDataFilter.all:
  //   //     filteredData = allData;
  //   //     break;
  //   //   case UserDataFilter.purchased:
  //   //     filteredData = allData.where((data) => data.productPurchased == true).toList();
  //   //     break;
  //   //   case UserDataFilter.notPurchased:
  //   //     filteredData = allData.where((data) => data.productPurchased == false).toList();
  //   //     break;
  //   // }
  //
  //   // Sort the filtered data based on the sorting order
  //   allData.sort((a, b) {
  //     if (sortAscending) {
  //       return a.uName.compareTo(b.uName);
  //     } else {
  //       return b.uName.compareTo(a.uName);
  //     }
  //   });
  //
  //   print(allData);
  //   print("+================++++++++");
  //   return allData;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Date
    // products.sort((a, b) => a.uDate.compareTo(b.uDate));
    userData.sort((a, b) => a.uName.compareTo(b.uName));
    userData.forEach((element) {
      print(element.uName);
    });
    setState(() {});
  }

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
          child: Icon(Icons.add, color: Colors.white,),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddCustomer()));
          },
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  String adminId = UserSharedprefs.getAdminId() ?? '';

                  Api.getUserData(adminId).then((value) {
                    userData.sort((a, b) => a.uName.compareTo(b.uName));
                    userData.forEach((element) {
                      print(element.uDate);
                    });
                    setState(() {});
                  });
                },
                icon: Icon(Icons.refresh))
          ],
          elevation: 0,
        ),
      ),
      body: Container(
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
            Container(
              height: kToolbarHeight + 56,
              color: Colors.white,
            ),
            // search bar
            Container(
              height: 75,
              width: w,
              // color here
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 60.0, right: 60),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      onChanged: (value) {
                        // filterSearchResults(value);
                        setState(() {
                          searchString = value.toString();
                          print(searchString);
                        });
                      },
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // filters
            Container(
              height: 80,
              width: w,
              child: Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: w / 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("adfd");
                    },
                    child: Container(
                      width: w / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 13),
                            child: Text(
                              "Filters :",
                              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 40,
                      width: (w / 4) - 10,
                      padding: EdgeInsets.only(left: 13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        hint: Text("Name",style: TextStyle( fontSize: 14),),
                        isExpanded: true,
                        value: value,
                        items: items.map(buildMenu).toList(),
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                            print(value);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: userData.isEmpty
                  ? Center(child: Text("No Customer Present"))
                  : ListView.builder(
                      itemCount: userData.length ?? 0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return userData[index]
                                .uName
                                .toLowerCase()
                                .toString()
                                .contains(searchString.toLowerCase())
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 5, right: 5),
                                child: GestureDetector(
                                    onTap: () {
                                      if(userDataIndex!= index){
                                        setState(() {
                                          productInCartId.clear();
                                          productInCart.clear();
                                          servicesInCart.clear();
                                          serviceCartId.clear();
                                          userDataIndex = index;
                                        });
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => AddProducts()));
                                      // Api.getHistory( userData[index].id.toString()).then((value) {
                                      // });
                                      //   print(userHistory[0].products);
                                      print("User History Above");
                                    },
                                    child: Card(
                                      elevation: 0,
                                      color: primary2,
                                      child: ListTile(
                                        title: Text(
                                            userData[index].uName.toString()),
                                        subtitle: Text(
                                            "${userData[index].uAddress.toString()}"),
                                        trailing: IconButton(icon: Icon(Icons.info_outline), onPressed: () {

                                        },)
                                        // trailing: Visibility(
                                        //   visible: boolCondition,
                                        //   maintainSize: false, // This prevents the widget from occupying extra space when invisible
                                        //   child: Icon(Icons.check),
                                        // ),
                                      ),
                                    )),
                              )
                            : SizedBox();
                      }),
            ),
            // Expanded(
            //   child: FirebaseAnimatedList(
            //     query: firebaseref.orderByChild("name").startAt("a"),
            //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
            //         Animation<double> animation, int index) {
            //       return Text("HIII");
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenu(String it) => DropdownMenuItem(
        value: it,
        child: Text(
          it,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      );
}
