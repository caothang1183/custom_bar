import 'package:custom_barchart_flutter/chart_data_entity.dart';
import 'package:custom_barchart_flutter/child_chart_data.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {

    final double width;
    final double height;
    final double weightBar;
    final double weightStroke;
    final double labelPadding;
    final double dataPadding;
    final double dataFontSize;
    final Color dataColor;
    final double dataInsidePadding;
    final double dataInsideFontSize;
    final Color dataInsideColor;
    final double barsPadding;
    final double chartPadding;
    final List<ChartData> data;

    const ChartPage(
        {Key key, this.width = 200, this.height = 250, this.weightBar = 30, this.weightStroke = 1,
            this.labelPadding = 8, this.dataPadding = 8, this.barsPadding = 5, this.chartPadding = 24,
            this.dataFontSize = 14, this.dataColor = Colors.black, this.dataInsideFontSize = 12,
            this.dataInsideColor = Colors.black, this.dataInsidePadding = 5, this.data})
        : super(key: key);


    @override
    _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
    List<ChartData> _data;
    double _highestData;


    @override
    void initState() {
        super.initState();
        _data = widget.data;
        _data.sort((a, b) => b.data.compareTo(a.data));
        _highestData = _data.first.data;
    }

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                body: Container(
                    alignment: Alignment.center,
                    height: widget.height,
                    padding: EdgeInsets.all(widget.chartPadding),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text("Bar Chart"),
                            Container(
                                height: 200,
                                padding: EdgeInsets.only(top: 8),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                        ...List.generate(
                                            _data.length, (index) =>
                                            _itemView(_data[index])),
                                    ],
                                ),
                            )
                        ],
                    ),
                ),
            ),
        );
    }

    _itemView(ChartData data) {
        double dataRenderBar = data.data;
        return Container(
            padding: EdgeInsets.fromLTRB(
                0, widget.barsPadding, 0, widget.barsPadding),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: widget.labelPadding),
                        child: Text(data.displayName),
                    ),
                    _initChildView(data.child.length > 0, data),
                    Padding(
                        padding: EdgeInsets.only(left: widget.dataPadding),
                        child: Text(
                            dataRenderBar.round().toString(),
                            style: TextStyle(
                                fontSize: widget.dataFontSize,
                                fontWeight: FontWeight.bold,
                                color: widget.dataColor
                            ),
                        ),
                    ),

                ],
            ),
        );
    }

    Widget _initChildView(bool hasChild, ChartData data) {
        double parentWidth = data.data * widget.width / _highestData;
        if (hasChild) {
            List<ChildChartData> childList = data.child;
            childList.sort((a, b) => a.data.compareTo(b.data));
            return Container(
                height: widget.weightBar,
                width: parentWidth,
                color: Colors.white,
                child: Row(
                    children: <Widget>[
                        ...List.generate(data.child.length, (index) =>
                            Row(
                                children: <Widget>[
                                    Container(
                                        color: childList[index].color,
                                        width: (parentWidth *
                                            childList[index].data / data.data) -
                                            widget.weightStroke,
                                        child: Container(
                                            height: widget.weightBar,
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(left: widget.dataPadding),
                                            child: Text('${childList[index]
                                                .displayName} ${childList[index]
                                                .data.round()}',
                                                style: TextStyle(
                                                    fontSize: widget
                                                        .dataInsideFontSize,
                                                    color: widget
                                                        .dataInsideColor,
                                                ),),
                                        ),
                                    ),
                                    Padding(padding: EdgeInsets.only(
                                        right: widget.weightStroke))
                                ],
                            ),
                        ),
                    ],
                ),
            );
        } else {
            return Container(
                height: widget.weightBar,
                width: data.data * widget.width / _highestData,
                color: data.color,
            );
        }
    }

    double sumData(List<ChildChartData> child) {
        double sum = 0;
        for (ChildChartData item in child) {
            sum += item.data;
        }
        return sum;
    }
}
