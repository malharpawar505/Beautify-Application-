import 'package:beautify/Model/global.dart';
import 'package:beautify/Model/userDataModel.dart';
import 'package:beautify/Screens/AddProducts.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:beautify/login/splashScreen..dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool isloading = true;
  var currId = companyIdData.isEmpty ? 0 : companyIdData[0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("currId is= $currId");
    loadData(currId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var h = size.height;
    var w = size.width;
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> AddProducts()));
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
              child: Text("Product List"),
            ),
            elevation: 0,
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.file_copy,
              color: Colors.white,
            ),
            onPressed: () {
              print(productInCart[0].id);
              print(currId);

              setState(() {

              });
            },
          ),
        ),
        body: Container(
          width: w,
          height: h,
          decoration: const BoxDecoration(
            color: Colors.white,
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
          child: companyIdData.length == 0
              ? const Center(child: Text("No Company Product Subscribed"))
              : Column(
                  children: [
                    const SizedBox(
                      height: kToolbarHeight + 56,
                    ),
                    Container(
                      height: 70,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: companyIdData.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return companyNameMap
                                    .containsKey(companyIdData[index])
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(20),
                                        color: currId == companyIdData[index]
                                            ? Colors.black
                                            : Colors.transparent,
                                      ),
                                      width: w / 3,
                                      child: Center(
                                        child: TextButton(
                                          onPressed: () {
                                            if (currId != companyIdData[index]) {
                                              currId = companyIdData[index];
                                              loadData(currId);
                                            }
                                            setState(() {});
                                          },
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateProperty
                                                .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed)) {
                                                  return Colors
                                                      .transparent; // Set transparent color for pressed state
                                                }
                                                return Colors
                                                    .transparent; // Use default splash color for other states
                                              },
                                            ),
                                          ),
                                          child: Text(
                                            companyNameMap[companyIdData[index]]!,
                                            style: TextStyle(
                                                color:
                                                    currId == companyIdData[index]
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox();
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: isloading
                          ? const Center(child: Text("Loading......"))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: productbyId.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                var name = productbyId[index].pName;
                                var company = productbyId[index].pCompany;
                                var price = productbyId[index].pPrice;
                                var id = productbyId[index].id;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, bottom: 5),
                                  child: Card(
                                    elevation: 0,
                                    color:  productInCartId.contains(id)
                                        ? primary : primary2,
                                    child: ListTile(
                                      title: Text(
                                        name,
                                        style:
                                            const TextStyle(color: Colors.black),
                                      ),
                                      leading: Text("${index + 1}]", style: const TextStyle(fontSize: 15),),
                                      subtitle: Text(company ,style:
                                          const TextStyle(color: Colors.black54),),
                                      trailing: IconButton(
                                              onPressed: () {
                                                if (kDebugMode) {
                                                  print("---------------------------------");
                                                }
                                                productInCart.add(Product(
                                                    id: id,
                                                    pCompany: productbyId[index].pCompany,
                                                    pCompanyId: productbyId[index].pCompanyId,
                                                    pName: name,
                                                    pPrice: price,
                                                    pQuantity: productbyId[index].pQuantity,
                                                    pDescription: productbyId[index].pDescription));
                                                productInCartId.add(id);
                                                setState(() {});
                                              },
                                              icon: productInCartId.contains(id)
                                                  ? const Icon(Icons.check_circle)
                                                  : const Icon(Icons.add_circle),
                                            ),
                                    ),
                                  ),
                                );
                              }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void loadData(var id) {
    Api.getProduct(id).then((value) {
      setState(() {
        isloading = false;
      });
    });
  }
}
