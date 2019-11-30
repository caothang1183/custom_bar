import 'package:custom_barchart_flutter/chart_data_entity.dart';
import 'package:custom_barchart_flutter/chart_page.dart';
import 'package:custom_barchart_flutter/child_chart_data.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
    List<ChartData> data = [
        ChartData(
            displayName: "Data 1", data: 15, color: Colors.red.shade900),
        ChartData(displayName: "Data 22323 ", data: 14,
            child: [
                ChildChartData(displayName: "Bata",
                    data: 7,
                    color: Colors.red.shade500),
                ChildChartData(displayName: "Ata",
                    data: 4,
                    color: Colors.red.shade500),
                ChildChartData(displayName: "Cata",
                    data: 3,
                    color: Colors.red.shade500),
            ],
        ),
        ChartData(
            displayName: "Data 3", data: 9, color: Colors.redAccent),
    ];

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Custom Bar Chart',
            theme: ThemeData(
                primaryColor: Colors.black,
            ),
            home: ChartPage(
                data: data,
                chartPadding: 24,
                weightBar: 40,
                barsPadding: 5,
                weightStroke: 2,
                dataInsideColor: Colors.white,
                dataInsideFontSize: 9,
            ),
        );
    }
}
