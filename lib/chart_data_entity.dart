import 'package:custom_barchart_flutter/child_chart_data.dart';
import 'package:flutter/material.dart';

class ChartData {
    final String displayName;
    final double data;
    final List<ChildChartData> child;
    final Color color;
    static const List<ChildChartData> initChild = [];

    ChartData({this.displayName = "", this.data = 0, this.child = initChild, this.color = Colors.white});
}

