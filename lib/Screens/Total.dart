// ignore_for_file: prefer_const_constructors

import 'package:beautify/Model/dashedLine.dart';
import 'package:beautify/Model/global.dart';
import 'package:beautify/Screens/Customers.dart';
import 'package:beautify/Screens/HomePage.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';

import '../Model/sharedPrefClass.dart';

class Total extends StatefulWidget {
  const Total({Key? key}) : super(key: key);

  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   child: Icon(Icons.arrow_forward, color: Colors.white,),
      //   onPressed: () {
      //     print("-----------------");
      //     print(totalPrice);
      //     print(totalProductPrice);
      //   },
      // ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Summary"),
          ),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         setState(() {});
          //       },
          //       icon: Icon(Icons.refresh))
          // ],
          elevation: 0,
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primary2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 25),
                  child: Text(
                    "${totalPrice+100}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, bottom: 8),
                  child: Text(
                    totalPrice.toString(),
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  addOrder();
                  updateUserData();
                  addMonthlySale();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => HomePage()));
                  // print(userData[userDataIndex].totalSpent);
                },
                child: Container(
                  height: 50,
                  width: w/2.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                  ),
                  child: Center(
                    child: Text("Place Order", style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        height: h,
        width: w,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: kToolbarHeight + 56,
              // color: Colors.greenAccent,
            ),
            Expanded(
              child: CustomScrollView(slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {

                          if (index == (servicesInCart.length) || index == productInCart.length + servicesInCart.length+1) {
                            return Container(
                              height: 1,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: DashedLine(),
                            );
                          }
                          if (index < servicesInCart.length) {
                            var name = servicesList[index].name;
                            var price = servicesList[index].price;
                            var time = servicesList[index].time;
                            return Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                              child: Container(
                                height: h / 13,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: primary2,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: (w / 6) - 15,
                                      // color: Colors.redAccent,
                                      child: Center(
                                        child: Text(
                                          " ${index + 1}]  ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: h / 26,
                                          width: w-(w / 6) - 25 ,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 3.0),
                                                child: Text(
                                                  name,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    letterSpacing: .5,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: h / 26,
                                          width: w-(w / 6) - 25 ,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "$time min",
                                                style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 15,
                                                  // letterSpacing: .5,
                                                ),

                                              ),
                                              Spacer(),
                                              SizedBox(
                                                // color: Colors.greenAccent,
                                                width: w / 3,
                                                // Text(
                                                //   "90  ",
                                                //   style: TextStyle(
                                                //       color: Colors.grey,
                                                //       decoration: TextDecoration.lineThrough,
                                                //       fontSize: 16),
                                                // ),
                                                child: Text(
                                                  "$price Rs",
                                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                                ),
                                              ),
                                              // Spacer(),
                                              SizedBox(
                                                width: (w/ 4)-40,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: const [
                                                    Text(
                                                      "Size: 1",
                                                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            // Product list
                            int i = index - servicesInCart.length-1;
                            return Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                              child: Container(
                                height: h / 13,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: primary2,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: (w / 6) - 15,
                                      // color: Colors.redAccent,
                                      child: Center(
                                        child: Text(
                                          " ${i+servicesInCart.length+1}]  ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: h / 26,
                                          width: w-(w / 6) - 25 ,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 3.0),
                                                child: Text(
                                                  productInCart[i].pName,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    letterSpacing: .5,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: h / 26,
                                          width: w-(w / 6) - 25 ,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${productInCart[i].pQuantity} ml",
                                                style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 15,
                                                  // letterSpacing: .5,
                                                ),

                                              ),
                                              Spacer(),
                                              SizedBox(
                                                // color: Colors.greenAccent,
                                                width: w / 3,
                                                // Text(
                                                //   "90  ",
                                                //   style: TextStyle(
                                                //       color: Colors.grey,
                                                //       decoration: TextDecoration.lineThrough,
                                                //       fontSize: 16),
                                                // ),
                                                child: Text(
                                                  "${productInCart[i].pPrice} Rs",
                                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                                ),
                                              ),
                                              // Spacer(),
                                              SizedBox(
                                                width: (w/ 4)-40,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: const [
                                                    Text(
                                                      "Size: 1",
                                                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                    },
                    childCount: productInCart.length + servicesInCart.length +2 ,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: Container(
                      height: 220,
                      width: w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primary2,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16, left: 24, right: 24, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Price Breakdown",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 24, right: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Product Price",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "$totalProductPrice Rs",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 24, right: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Service Price",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "$totalServicePrice Rs",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 24, right: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: const [
                                Text(
                                  "Discount",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "- 100 Rs",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Total
                          Padding(
                            padding: EdgeInsets.only(
                                top: 12, left: 24, right: 24, bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.info_outline))
                                  ],
                                ),
                                Text(
                                  "$totalPrice Rs",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
              // child: ListView.separated(
              //
              //   itemCount: productInCart.length + servicesInCart.length,
              //     padding: EdgeInsets.zero,
              //     shrinkWrap: true,
              //   separatorBuilder: (context, index) {
              //     if (index == (servicesInCart.length -1) || index == productInCart.length + 1) {
              //       return Container(
              //         height: 1,
              //         margin: EdgeInsets.symmetric(horizontal: 16),
              //         child: DashedLine(),
              //       );
              //     } else {
              //       // Return an empty container for other separators
              //       return Container();
              //     }
              //   },
              //   itemBuilder: (context, index) {
              //     // Map<String, dynamic> product =
              //     //     Map<String, dynamic>.from(userHistory[0].products[index]);
              //     // return ListTile(
              //     //   title: Text(),
              //     //   subtitle: Text(product['p_company']),
              //     // Display other product information
              //     );


                // },
                //              ),
            ),
            SizedBox(
              height: 80,
            )
            // bottom Navigaton Bar
          ],
        ),
      ),
    );
  }

  void addOrder() async{
    String adminId = UserSharedprefs.getAdminId() ?? '';
    Map<String, Object> data = {
      "adminid": adminId,
      "userid": userData[userDataIndex].id,
      "total_price": totalPrice,
      "total_discount": "100",
      "noOfItems": productInCart.length,
      "noOfService": servicesInCart.length,
      "noOfItems_price": totalProductPrice,
      "noOfService_price": totalServicePrice,
      "products": productInCart.map((element) {
        return {
          'p_company': element.pCompany,
          'p_companyId': element.pCompanyId,
          'p_name': element.pName,
          'p_price': element.pPrice,
          'p_quantity': element.pQuantity,
          'p_description': element.pDescription,
        };
      }).toList(),
      "services": servicesInCart.map((element) {
        return {
          'name': element.name,
          'price': element.price,
          'time': element.time
        };
      }).toList()
    };
    await Api.addOrder(data).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          productInCartId.clear();
          productInCart.clear();
          servicesInCart.clear();
          serviceCartId.clear();
        });
      } else {
        print("Failed to get response-----------------");
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void updateUserData()async {
    var body = {
      "total_spent": "${userData[userDataIndex].totalSpent + totalPrice}",
      "total_visits":"${userData[userDataIndex].totalVisits+1}",
      "product_purchasing":"${userData[userDataIndex].productPurchasing + totalProductPrice}",
      "service_purchasing":"${userData[userDataIndex].servicesPurchasing + totalServicePrice}"
    };
    print(prettyJson(body));
    await Api.updateCustomerDataStats(userData[userDataIndex].id, body);
  }

  void addMonthlySale() async{
    String adminId = UserSharedprefs.getAdminId() ?? '';
    var date = DateTime.now(); // Replace with the actual dat
    var year = date.year;
    var month = date.month;
    var day= date.day;
    var dateString = "${year}-${month}-${day}";
    var sale_data ={
      "adminid":adminId,
      "day":day.toString(),
      "product_sale": "$totalProductPrice",
      "service_sale":"$totalServicePrice"
    };
    print(sale_data);
    print("=============================");
    await Api.addMonthlySale(sale_data);
  }
}



