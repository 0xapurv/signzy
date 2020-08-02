import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart' as linechart;


class EarningTabView extends StatefulWidget {
  @override
  _EarningTabViewState createState() => _EarningTabViewState();
}

class _EarningTabViewState extends State<EarningTabView> {

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;
    const dateTextStyle = TextStyle(
        fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Earnings Overview",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: linechart.LineChart(
                        linechart.LineChartData(
                          lineTouchData:
                          const linechart.LineTouchData(enabled: false),
                          lineBarsData: [
                            linechart.LineChartBarData(
                              spots: const [
                                linechart.FlSpot(0, 4),
                                linechart.FlSpot(1, 3.5),
                                linechart.FlSpot(2, 4.5),
                                linechart.FlSpot(3, 1),
                                linechart.FlSpot(4, 4),
                                linechart.FlSpot(5, 6),
                                linechart.FlSpot(6, 6.5),
                                linechart.FlSpot(7, 6),
                                linechart.FlSpot(8, 4),
                                linechart.FlSpot(9, 6),
                                linechart.FlSpot(10, 6),
                                linechart.FlSpot(11, 7),
                              ],
                              isCurved: true,
                              barWidth: 1,
                              colors: [
                                Colors.black,
                              ],
                              belowBarData: linechart.BarAreaData(
                                show: true,
                                colors: [Colors.yellowAccent],
                                cutOffY: cutOffYValue,
                                applyCutOffY: true,
                              ),
                              aboveBarData: linechart.BarAreaData(
                                show: true,
                                colors: [Color(0xff303645)],
                                cutOffY: cutOffYValue,
                                applyCutOffY: true,
                              ),
                              dotData: const linechart.FlDotData(
                                show: false,
                              ),
                            ),
                          ],
                          minY: 0,
                          titlesData: linechart.FlTitlesData(
                            bottomTitles: linechart.SideTitles(
                                showTitles: true,
                                reservedSize: 14,
                                textStyle: dateTextStyle,
                                getTitles: (value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return 'Jan';
                                    case 1:
                                      return 'Feb';
                                    case 2:
                                      return 'Mar';
                                    case 3:
                                      return 'Apr';
                                    case 4:
                                      return 'May';
                                    case 5:
                                      return 'Jun';
                                    case 6:
                                      return 'Jul';
                                    case 7:
                                      return 'Aug';
                                    case 8:
                                      return 'Sep';
                                    case 9:
                                      return 'Oct';
                                    case 10:
                                      return 'Nov';
                                    case 11:
                                      return 'Dec';
                                    default:
                                      return '';
                                  }
                                }),
                            leftTitles: linechart.SideTitles(
                              showTitles: true,
                              getTitles: (value) {
                                return '\$ ${value + 0.5}';
                              },
                            ),
                          ),
                          axisTitleData: const linechart.FlAxisTitleData(
                              leftTitle: linechart.AxisTitle(showTitle: true),
                              bottomTitle: linechart.AxisTitle(
                                  showTitle: true,
                                  margin: 0,
                                  textStyle: dateTextStyle,
                                  textAlign: TextAlign.right)),
                          gridData: linechart.FlGridData(
                            show: true,
                            checkToShowHorizontalLine: (double value) {
                              return value == 1 ||
                                  value == 6 ||
                                  value == 4 ||
                                  value == 5;
                            },
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}