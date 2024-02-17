import 'package:beautify/Model/sharedPrefClass.dart';
import 'package:beautify/Screens/Customers.dart';
import 'package:beautify/Screens/demograph.dart';
import 'package:beautify/Services/api.dart';
import 'package:beautify/Widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Model/global.dart';
import '../../Model/userDataModel.dart';

class HomePageStats extends StatefulWidget {
  const HomePageStats({super.key});

  @override
  State<HomePageStats> createState() => _HomePageStatsState();
}

class _HomePageStatsState extends State<HomePageStats> {

  List<DataPoint> dataPoints = [];
  String selectedTimeSlot = '';
  List<String> timeSlots = [
    '9:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 1:00 PM',
    '1:00 PM - 2:00 PM',
    '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM',
    '4:00 PM - 5:00 PM',
  ];
  List<String> months = ["Jan", "Feb","Mar","Apr","May","June","Jul","Aug","Sep","Oct","Nov","Dec"];


  @override
  void initState() {
    // TODO: implement initState
    for(int i=0;i<monthlySale.length;i++){
      print("${monthlySale[i].serviceSale} ${monthlySale[i].productSale} ${monthlySale[i].month}");
    }


    for (var data in aggregatedData) {
      print('Month: ${data.month}');
      print('Total Service: ${data.totalService}');
      print('Total Product: ${data.totalProduct}');
      print('------------------');
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    var h = s.height;
    var w = s.width;

    final series = <ChartSeries>[
      LineSeries<MonthlyAggregate, String>(
        name: "Product Sale",
        dataSource: aggregatedData,
        // color: Color.fromRGBO(8, 142, 255, 1),
        xValueMapper: (MonthlyAggregate point, _) => months[int.parse(point.month.substring(6,7)) -1],
        yValueMapper: (MonthlyAggregate point, _) => point.totalProduct,
        markerSettings:  const MarkerSettings(
          isVisible: true, // Set the marker to be visible
          shape: DataMarkerType.circle, // Set the shape of the marker to circle
          borderWidth: 2, // Customize the border width of the marker
        ),

      ),
      LineSeries<MonthlyAggregate, String>(
        name: "Services Sale",
        dataSource: aggregatedData,
        xValueMapper: (MonthlyAggregate point, _) => months[int.parse(point.month.substring(6,7)) -1],
        yValueMapper: (MonthlyAggregate point, _) => point.totalService,
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
      title: ChartTitle(text: 'Monthly sales analysis'),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      // primaryYAxis: NumericAxis(),
    );


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
            child: Text("Statistics"),
          ),
          actions: [
            IconButton(
                onPressed: () async{
                  // print(userData[userDataIndex].uName);
                  String adminId = UserSharedprefs.getAdminId() ?? '';
                  await Api.getMonthlySale(adminId).then((value) {
                    print("monthly Sale Retrived");
                    monthlySale.sort((a, b) => a.month.compareTo(b.month));
                  });
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ],
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
              height: 300,
              padding: EdgeInsets.all(16),
              child: chart,
            ),

            // TextButton(
            //   onPressed: () {
            //     // add length of all user history with admin id
            //   },
            //   child: const Text("Customer Visit"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     _showTimeSlotSelection(context);
            //   },
            //   child: Text('Select Time Slot'),
            // ),
          ],
        ),
      ),
    );
  }

  void _showTimeSlotSelection(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          // color: primary2,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Time Slot',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  final timeSlot = timeSlots[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeSlot = timeSlot;
                      });
                      Navigator.pop(context);
                    },
                    child: Card(
                      elevation: 0,
                      color: selectedTimeSlot == timeSlot ? Colors.blue : primary2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            timeSlot,
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedTimeSlot == timeSlot ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
