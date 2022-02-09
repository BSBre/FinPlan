import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<String, double> dataMap = {
    "Flutter": 1500,
    "React": 547,
    "Xamarin": 446,
    "Ionic": 312,
  };
  @override
  Widget build(BuildContext context) {
    return Center(
        child: PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 2000),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery
              .of(context)
              .size
              .width,
          initialAngleInDegree: 0,
          chartType: ChartType.disc,
          ringStrokeWidth: 32,
          legendOptions: LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendShape: BoxShape.rectangle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
            decimalPlaces: 0,
          ),
          // gradientList: ---To add gradient colors---
          // emptyColorGradient: ---Empty Color gradient---
        )
    );
  }
}
