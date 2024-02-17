import 'package:beautify/Model/global.dart';
import 'package:beautify/Model/sharedPrefClass.dart';
import 'package:beautify/Model/userDataModel.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;


class DemoGraph extends StatefulWidget {

  @override
  State<DemoGraph> createState() => _DemoGraphState();
}

class _DemoGraphState extends State<DemoGraph> {
  List<DataPoint> dataPoints = [];

  List<String> months = ["Jan", "Feb","Mar","Apr","May","June","Jul","Aug","Sep","Oct","Nov","Dec"];

  @override
  void initState() {
    super.initState();
    // fetchDataFromMongoDB();
    // fetchData();
  }


  @override
  Widget build(BuildContext context) {
    final series = <ChartSeries>[
      LineSeries<MonthlySale, String>(
        name: "Product Sale",
        dataSource: monthlySale,
        // color: Color.fromRGBO(8, 142, 255, 1),
        xValueMapper: (MonthlySale point, _) => months[int.parse(point.month.substring(6,7)) -1],
        yValueMapper: (MonthlySale point, _) => point.productSale,
        markerSettings:  const MarkerSettings(
          isVisible: true, // Set the marker to be visible
          shape: DataMarkerType.circle, // Set the shape of the marker to circle
          borderWidth: 2, // Customize the border width of the marker
        ),

      ),
      LineSeries<MonthlySale, String>(
        name: "Services Sale",
        dataSource: monthlySale,
        xValueMapper: (MonthlySale point, _) => months[int.parse(point.month.substring(6,7)) -1],
        yValueMapper: (MonthlySale point, _) => point.serviceSale,
        markerSettings: const MarkerSettings(
          isVisible: true, // Set the marker to be visible
          shape: DataMarkerType.circle, // Set the shape of the marker to circle
          borderWidth: 2, // Customize the border width of the marker
        ),
      ),
    ];

    final chart = SfCartesianChart(
      // backgroundColor: primary2,
      series: series,
      primaryXAxis: CategoryAxis(),

      legend: Legend(isVisible: true,position: LegendPosition.bottom,),      // Chart title
      title: ChartTitle(text: 'Half yearly sales analysis'),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      // primaryYAxis: NumericAxis(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('MongoDB Atlas Chart'),
        actions: [
          IconButton(onPressed: (){
            String adminId = UserSharedprefs.getAdminId() ?? '';
            Api.getMonthlySale(adminId).then((value) {
              print("monthly Sale Retrived");
              monthlySale.sort((a, b) => a.month.compareTo(b.month));
            });
            setState(() {

            });
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Container(
          height: 300,
          padding: EdgeInsets.all(16),
          child: chart,
        ),
      ),
    );


  }

}

class DataPoint {
  final String month;
  final double value;

  DataPoint(this.value, this.month); // Set index value as needed for the x-axis
}
