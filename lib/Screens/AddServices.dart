import 'package:beautify/Model/global.dart';
import 'package:beautify/Model/userDataModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Widgets/color.dart';
import 'AddProducts.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({super.key});

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    var h = s.height;
    var w = s.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const AddProducts()));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Add Services"),
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
                height: kToolbarHeight + 56,
                // color: Colors.greenAccent,
              ),
              Container(
                height: h / 1.5,
                // color: Colors.redAccent,
                child: ListView.builder(
                  itemCount: servicesList.length,
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

                    var name = servicesList[index].name;
                    var price = servicesList[index].price;
                    var time = servicesList[index].time;
                    var id = servicesList[index].id;
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
                          trailing: serviceCartId.contains(id)
                              ? IconButton(
                                  onPressed: () {
                                  },
                                  icon: Icon(Icons.check_circle)
                                )
                              : IconButton(
                                  onPressed: () {
                                    if (kDebugMode) {
                                      print(
                                          "---------------------------------");
                                    }
                                    servicesInCart.add(Services(
                                        id: id,
                                        name: name,
                                        price: price,
                                        time: time));
                                    print(id);
                                    for (int i = 0;
                                        i < servicesInCart.length;
                                        i++) {
                                      print(servicesInCart[i].name);
                                    }
                                    serviceCartId.add(id);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.add_circle),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
