import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m2m_coin/constants.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBarChart extends StatelessWidget {
  //ตัวแปล
  List listChart;
  String nameStore;
  double maxy;
  double interval;
  MyBarChart({
    this.listChart,
    this.nameStore,
    this.maxy,
    this.interval,
  });
/*
  List dataBarchart = [
    {'name': 'Mon', 'id': 0, 'y': 15, 'color': Color(0xff19bfff)},
    {'name': 'Tue', 'id': 1, 'y': 12, 'color': Color(0xffff4d94)},
    {'name': 'Wed', 'id': 2, 'y': 11, 'color': Color(0xff2bdb90)},
    {'name': 'Thu', 'id': 3, 'y': 10, 'color': Color(0xffffdd80)},
    {'name': 'Fri', 'id': 4, 'y': 5, 'color': Color(0xff2bdb90)},
    {'name': 'Sat', 'id': 5, 'y': 17, 'color': Color(0xffffdd80)},
    {'name': 'Sun', 'id': 6, 'y': 5, 'color': Color(0xffff4d94)},
  ];
  */
/*
  double maxy = 500;
  double interval = 100;
  */

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print('list >>>>>>"${listChart.length > 1 ? "y" : "n"}"');

    return Container(
      margin: EdgeInsets.only(
        top: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      height: size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            alignment: Alignment.centerLeft,
            child: Text(
              nameStore,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: kDefaultPadding),
              width: size.width * 0.85,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxy,
                  barTouchData: BarTouchData(enabled: true),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.black12),
                    ),
                  ),
                  gridData: FlGridData(
                    checkToShowHorizontalLine: (value) {
                      return value % interval == 0; //แบ่งเส้นปะสีเทา
                    },
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.black12,
                        dashArray: [5],
                        strokeWidth: 0.8,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      //rotateAngle: 35.0, //องศา
                      getTitles: (double index) {
                        return listChart[index.toInt()]['dt'];
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: interval,
                      getTitles: (double value) {
                        return value == 0
                            ? '0'
                            : '${NumberFormat("#,### ฿").format(value.toInt())}';
                      },
                    ),
                  ),
                  barGroups: listChart
                      .asMap()
                      .map((key, value) {
                        return MapEntry(
                          key,
                          BarChartGroupData(
                            x: key,
                            barRods: [
                              BarChartRodData(
                                y: double.parse('${value['coin_value'] ?? 0}'),
                                width: 20,
                                colors: [barColor],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
