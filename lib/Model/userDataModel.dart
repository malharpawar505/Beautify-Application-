// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

// UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

// String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String id;
  String adminId;
  String uName;
  String uEmail;
  String uNumber;
  String uAddress;
  int productPurchasing;
  int servicesPurchasing;
  int totalSpent;
  int totalVisits;
  String uDate;

  UserDataModel({
    required this.id,
    required this.adminId,
    required this.uName,
    required this.uEmail,
    required this.uNumber,
    required this.uAddress,
    required this.productPurchasing,
    required this.servicesPurchasing,
    required this.totalSpent,
    required this.totalVisits,
    required this.uDate
  });

  // factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
  //   id: json["id"],
  //   adminId: json["admin_id"],
  //   uName: json["u_name"],
  //   uEmail: json["u_email"],
  //   uNumber: json["u_number"],
  //   uAddress: json["u_address"],
  //   uDate: json["u_address"],
  // );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "admin_id": adminId,
  //   "u_name": uName,
  //   "u_email": uEmail,
  //   "u_number": uNumber,
  //   "u_address": uAddress,
  // };
}


class MonthlyAggregate {
  String month;
  int totalService;
  int totalProduct;

  MonthlyAggregate(this.month, this.totalService, this.totalProduct);
}



class AdminId {
  final String id;
  final String? adminId;
  final String? name;
  final String? address;
  final String? mobile;
  final String? email;
  final List<dynamic> companyId;

  AdminId({required this.id, this.name, this.address, this.mobile, this.email,this.adminId, required this.companyId});

  // factory AdminId.fromJson(Map<String, dynamic> json) {
  //   return AdminId(
  //       id: json['_id'],
  //       adminId: json['admin_id'],
  //       name: json['admin_name'],
  //       mobile: json['admin_phone'].toString(),
  //       address: json['admin_address'],
  //       email: json['admin_email'],
  //       companyId: List<dynamic>.from(json['companyId']),
  //   );
  // }
}


class UserHistory {
  String id;
  String adminId;
  String userid;
  int totalPrice;
  int totalDiscount;
  int noOfItems;
  int noOfService;
  int noOfItemsPrice;
  int noOfServicePrice;
  List<dynamic> products;
  List<dynamic> services;

  String date;

  UserHistory({
    required this.id,
    required this.adminId,
    required this.userid,
    required this.totalPrice,
    required this.totalDiscount,
    required this.noOfItems,
    required this.noOfService,
    required this.noOfItemsPrice,
    required this.noOfServicePrice,
    required this.products,
    required this.services,
    required this.date
  });

}


class Product {
  String id;
  String pCompany;
  String pCompanyId;
  String pName;
  int pPrice;
  int pQuantity;
  String pDescription;

  Product({
    required this.id,
    required this.pCompany,
    required this.pCompanyId,
    required this.pName,
    required this.pPrice,
    required this.pQuantity,
    required this.pDescription,
  });
}


class User {
  String userName;
  String userAddress;
  int userMobile;
  String userEmail;
  String adminId;
  String id;
  String userDate;

  User({
    required this.userName,
    required this.userAddress,
    required this.userMobile,
    required this.userEmail,
    required this.adminId,
    required this.id,
    required this.userDate
  });

}


class Services {
  String id;
  String name;
  int price;
  int time;

  Services({
    required this.id,
    required this.name,
    required this.price,
    required this.time
  });
}

class MonthlySale {
  String id;
  String adminid;
  int productSale;
  int serviceSale;
  String month;

  MonthlySale({
    required this.id,
    required this.adminid,
    required this.productSale,
    required this.serviceSale,
    required this.month
  });
}


class Schedule {
  String id;
  String adminid;
  String userid;
  String name;
  String date;
  String time;
  String comments;
  String complete;

  Schedule({
    required this.id,
    required this.adminid,
    required this.userid,
    required this.name,
    required this.date,
    required this.time,
    required this.comments,
    required this.complete
  });
}

