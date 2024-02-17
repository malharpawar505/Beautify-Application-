// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:beautify/Model/global.dart';
import 'package:beautify/Model/sharedPrefClass.dart';
import 'package:beautify/Model/userDataModel.dart';
import 'package:beautify/Screens/AddServices.dart';
import 'package:beautify/Screens/Customers.dart';
import 'package:beautify/Screens/Total.dart';
import 'package:beautify/Screens/addSchedule.dart';
import 'package:beautify/Screens/productList.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:beautify/login/splashScreen..dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pretty_json/pretty_json.dart';

import '../Widgets/color.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  List<String> products = ["Face Wash", "Face Cream", "Bath Soap", "Bath Wash"];
  bool isloading = false;
  bool isData = false;
  bool isSchedule = false;
  Future<void> _refreshList() async {
    // Simulate a delay to fetch updated data
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // Update the list of items here
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (productInCart.length + servicesInCart.length == 0) {
        isData = true;
      }
      if(servicesInCart.isNotEmpty && productInCart.isEmpty){
        isSchedule=true;
      }
    });
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Add Products"),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  print(userData[userDataIndex].uName);
                  setState(() {
                    if(servicesInCart.isNotEmpty && productInCart.isEmpty){
                      isSchedule=true;
                    }
                  });
                },
                icon: Icon(Icons.refresh))
          ],
          elevation: 0,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [
          //     Color(0xFFD882E5), //0xFFC0CBF1
          //     Color(0xFFC0CBEA), //0xFF9985AD
          //   ],
          // stops: [0.1, 0.4],
          // ),
        ),
        child: Column(
          children: [
            Container(
              height: kToolbarHeight + 56,
              // color: Colors.greenAccent,
            ),
            SizedBox(
              height: (h / 4) - (kToolbarHeight + 56),
              child: Column(
                children: [
                  SizedBox(
                    width: w,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, left: 10),
                        child: Text(
                          "Aditya More",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: w,
                    // color: Colors.grey,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProductList()));
                              },
                              child: Container(
                                height: 50,
                                width: (w-40)/3,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.add_circle),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Products",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ServiceList()));
                              },
                              child: Container(
                                height: 50,
                                width: (w-40)/3,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.add_circle),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Services",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                if(servicesInCart.isNotEmpty && productInCart.isEmpty){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AddSchedule()));
                                }else if(servicesInCart.isEmpty){
                                  Fluttertoast.showToast(msg: "Add Services to List");
                                }else if(productInCart.isNotEmpty){
                                  Fluttertoast.showToast(msg: "Remove Products in List");
                                }else{

                                }

                              },
                              child: Container(
                                height: 50,
                                width: (w-40)/3,
                                decoration: BoxDecoration(
                                  color: isSchedule ? Colors.black : Colors.black54,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.add_circle, color: Colors.white,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Schedule",
                                        style: TextStyle(
                                            color:Colors.white ,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: h / 1.5,
              // color: Colors.redAccent,
              child: isData ? noProduct() : prodcuctListView(),
            ),
            Spacer(),
            SizedBox(
              height: h / 12,
              width: w,
              child: Center(
                child: Container(
                  height: 60,
                  width: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isData ? Colors.black26 : Colors.black,
                    ),
                    onPressed: () async {


                      if(!isData){
                        CalculateData();
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> const Total()));
                      }else{
                        Fluttertoast.showToast(msg: "Add Product or Services");
                      }


                    },
                    child: isloading
                        ? CircularProgressIndicator()
                        : Text(
                            "Pay",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center noProduct() {
    return Center(
      child: Text("Add Prodcuts Or Services"),
    );
  }

  RefreshIndicator prodcuctListView() {
    return RefreshIndicator(
      onRefresh: _refreshList,
      child: ListView.builder(
        itemCount: productInCart.length + servicesInCart.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // Map<String, dynamic> product =
          //     Map<String, dynamic>.from(userHistory[0].products[index]);
          // return ListTile(
          //   title: Text(),
          //   subtitle: Text(product['p_company']),
          // Display other product information
          // );
          if (index < servicesInCart.length) {
            var name = servicesInCart[index].name;
            var price = servicesInCart[index].price;
            var time = servicesInCart[index].time;
            var id = servicesInCart[index].id;
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
          } else {
            // Product list
            int i = index - servicesInCart.length;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                color: primary2,
                elevation: 0,
                child: ListTile(
                  title: Text(
                    productInCart[i].pName,
                    style: TextStyle(fontSize: 15),
                  ),
                  leading: Text(
                    "${i + 1}] ",
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    productInCart[i].pQuantity.toString(),
                    style: const TextStyle(color: Colors.black54),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("dffffffffffffffffff");
                      }

                      setState(() {
                        productInCart.removeAt(i);
                        productInCartId.remove(productInCart[i].id);
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
  void CalculateData() {

    totalPrice = 0;
    totalDiscount =0;
    totalProductPrice  =0;
    totalServicePrice=0;

    setState(() {
    DateTime startTime = DateTime.now();
    productInCart.forEach((element) {
      totalProductPrice += element.pPrice;
      totalPrice+= element.pPrice;
    });
    servicesInCart.forEach((element) {
      totalServicePrice += element.price;
      totalPrice+= element.price;
    });
    DateTime endTime = DateTime.now();
    Duration duration = endTime.difference(startTime);
    if (kDebugMode) {
      print("--------------------------------------");
      print('Time taken: ${duration} milliseconds');
      print(totalPrice);
      print(totalProductPrice);
      print(totalServicePrice);
    }

    });
  }
}
