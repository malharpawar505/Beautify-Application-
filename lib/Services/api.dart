import 'dart:convert';

import 'package:beautify/Model/global.dart';
import 'package:beautify/Model/userDataModel.dart';
import 'package:beautify/Model/userDataModel.dart';
import 'package:beautify/Screens/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_json/pretty_json.dart';

import '../Screens/Customers.dart';
import '../login/splashScreen..dart';

class Api {
  //  192.168.22.50
  static var baseUrl = "http://$ip:8080/api/";

  // post data
  static addUser(Map user_data) async {
    print(user_data);
    var url = Uri.parse("${baseUrl}add_user");
    try {
      var response = await http.post(url, body: user_data);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Data added successull");
      } else {
        print("Failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static addAdmin(Map admin_data) async {
    print(admin_data);
    var url = Uri.parse("${baseUrl}add_admin");
    try {
      var response = await http.post(url, body: admin_data);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Data added successull from App");
      } else {
        print("Failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static addOrder(Map order_data) async {
    print("--------------------------");
    var url = Uri.parse("${baseUrl}user_history");
    try {
      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode(order_data);

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        // print(prettyJson(data));
        print("AddOrder ========= Data added successful from App");
      } else {
        print("Failed to get response");
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static addMonthlySale(Map sale_data) async {
    var url = Uri.parse("${baseUrl}monthlySale");
    try {
      var response = await http.post(url, body: sale_data);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (kDebugMode) {
          print("addMonthlySale ========= Data added successful from App");
        }
      } else {
        print("Failed to get response");
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static addSchedule(Map schedule_data) async {
    var url = Uri.parse("${baseUrl}schedule");
    try {
      var response = await http.post(url, body: schedule_data);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (kDebugMode) {
          print("add Schedule ========= Data added successful from App");
        }
      } else {
        print("Failed to get response");
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Get Data
  static Future<List<UserDataModel>> getUserData(id) async {
    var url = Uri.parse("${baseUrl}get_userData/$id");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (kDebugMode) {
          print(data[0]);
        }
        userData.clear();
        data.forEach((value) => {
              userData.add(UserDataModel(
                  id: value['_id'],
                  adminId: value['adminid'],
                  uName: value['user_name'],
                  uNumber: value['user_mobile'].toString(),
                  uAddress: value['user_address'],
                  uEmail: value['user_email'],
                  uDate: value['user_date'],
                  productPurchasing: value['product_purchasing'],
                  servicesPurchasing: value['services_purchasing'],
                  totalSpent: value['total_spent'],
                  totalVisits: value['total_visits']))
            });
        return userData;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  static Future<List<AdminId>> getAdminData(id) async {
    print("------$id");
    var url = Uri.parse("${baseUrl}get_adminData/$id");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (kDebugMode) {
          print(data[0]);
        }
        adminData.clear();
        data.forEach((value) => {
              adminData.add(AdminId(
                  id: value['_id'],
                  adminId: value['admin_id'],
                  name: value['admin_name'],
                  mobile: value['admin_phone'].toString(),
                  address: value['admin_address'],
                  email: value['admin_email'],
                  companyId: value['companyId']))
            });
        print(adminData.toString());
        return adminData;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  static Future<List<Product>> getProduct(id) async {
    var url = Uri.parse("${baseUrl}productbyCompanyId/$id");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (kDebugMode) {
          print(data[0]);
        }
        productbyId.clear();
        data.forEach((value) => {
              productbyId.add(Product(
                  id: value['_id'],
                  pCompany: value['p_company'],
                  pCompanyId: value['p_companyId'],
                  pName: value['p_name'],
                  pPrice: value['p_price'],
                  pQuantity: value['p_quantity'],
                  pDescription: value['p_description']))
            });
        // print(productbyId.toString());
        print("++++++++++++++++++++++++");
        // productbyId.forEach((element) {
        //
        // });
        return productbyId;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());

    }
    return [];
  }

  static Future<List<Services>> getServices() async {
    var url = Uri.parse("${baseUrl}services");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        servicesList.clear();
        data.forEach((value) => {
              servicesList.add(Services(
                  id: value['_id'],
                  name: value['name'],
                  price: value['price'],
                  time: value['time']))
            });
        // print(productbyId.toString());
        print("++++++++++++++++++++++++");
        return servicesList;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  static Future<List<Services>> getMonthlySale(id) async {
    var url = Uri.parse("${baseUrl}monthlySale/$id");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        monthlySale.clear();
        data.forEach((value) => {
              monthlySale.add(MonthlySale(
                  id: value['_id'],
                  adminid: value['adminid'].toString(),
                  productSale: value['product_sale'],
                  serviceSale: value['service_sale'],
                  month: value['month'].toString()))
            });
        // print(productbyId.toString());
        print("++++++++++++++++++++++++");
        aggregatedData = aggregateMonthlySales(monthlySale);
        return servicesList;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  static Future<List<UserHistory>> getHistory(id) async {
    var url = Uri.parse("${baseUrl}get_userHistory/$id");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (kDebugMode) {
          print(data[0]);
        }
        userHistory.clear();
        data.forEach((value) => {
              userHistory.add(UserHistory(
                id: value['_id'],
                adminId: value['adminid'],
                userid: value['userid'],
                totalPrice: value['total_price'],
                totalDiscount: value['total_discount'],
                noOfItems: value['noOfItems'],
                noOfService: value['noOfService'],
                noOfItemsPrice: value['noOfItems_price'],
                noOfServicePrice: value['noOfService_price'],
                products: value['products'],
                services: value['services'],
                date: value['date'],
              ))
            });
        print(userHistory.toString());
        print("-------------------------------");

        // List<UserHistory> userHistories = List<UserHistory>.from(json.decode(data).map((x) => UserHistory.fromJson(x)));
        // // Access the data
        // for (UserHistory userHistory in userHistories) {
        //   print(userHistory.adminId);
        //   print(userHistory.userid);
        //   // Access other fields and nested products
        //   for (Product product in userHistory.products) {
        //     print(product.pName);
        //     print(product.pPrice);
        //     // Access other product fields
        //   }
        // }
        return userHistory;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  static Future<List<Schedule>> getSchedule(id) async {
    var url = Uri.parse("${baseUrl}schedule/$id");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (kDebugMode) {
          print(data[0]);
        }
        schedule.clear();
        data.forEach((value) => {
              schedule.add(Schedule(
                id: value['_id'],
                adminid: value['adminid'],
                userid: value['userid'],
                date: value['date'],
                time: value['time'],
                comments: value['comments'],
                complete: value['complete'], name: value['name'],
              ))
            });
        print(schedule.toString());
        print("-------------------------------");
        return schedule;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  // Update Data

  static updateAdminProduct(id, body) async {
    var url = Uri.parse("${baseUrl}update_AdminData/$id");
    // var headers = {'Content-Type': 'application/json'};
    // var body = jsonEncode({'companyId': data});

    var data = {
      'companyId': body,
    };

    var headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.put(url, headers: headers, body: jsonEncode(data));
      if (res.statusCode == 200) {
        print(jsonDecode(res.body));
      } else {
        print("Failed to update data");
        print('Failed to update Company ID. Error: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static updateCustomerDataStats(id, body) async {
    var url = Uri.parse("${baseUrl}update_userData/$id");
    // var headers = {'Content-Type': 'application/json'};
    // var body = jsonEncode({'companyId': data});

    // var headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.put(url, body: body);
      if (res.statusCode == 200) {
        print(
            "updateCustomerDataStats ========= Data added successful from App");
      } else {
        print("Failed to update data");
        print('Failed to update Company ID. Error: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
