import 'package:beautify/Model/userDataModel.dart';



List<Product> productbyId =[];
List<Product> productInCart =[];
List<String> productInCartId =[];

List<Services> servicesList =[];
List<Services> servicesInCart =[];
List<String> serviceCartId =[];

List<MonthlySale> monthlySale =[];
List<MonthlyAggregate> aggregatedData =[];

List<Schedule> schedule=[];

String ip="";

var totalPrice = 0;
var totalDiscount =0;
var totalProductPrice=0;
var totalServicePrice=0;

var userDataIndex = 0;


List<MonthlyAggregate> aggregateMonthlySales(List<MonthlySale> monthlySales) {
  Map<String, MonthlyAggregate> aggregateMap = {};

  for (var sale in monthlySales) {
    String month = sale.month;
    int service = sale.serviceSale;
    int product = sale.productSale;

    if (aggregateMap.containsKey(month)) {
      aggregateMap[month]!.totalService += service;
      aggregateMap[month]!.totalProduct += product;
    } else {
      aggregateMap[month] = MonthlyAggregate(month, service, product);
    }
  }

  return aggregateMap.values.toList();
}
