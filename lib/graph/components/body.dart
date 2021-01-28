import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:m2m_coin/graph/components/my_bar_chart.dart';
import 'package:m2m_coin/services/ChartService.dart';

import '../../constants.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //ตัวแปล
  ChartService chartService = ChartService();
  Map<String, dynamic> returnStatus;
  List dataAll = [];
  String tabSelect = 'Days';
  List listTabs = [
    'Days',
    'Weeks',
    'Months',
  ];

  //method
  Future getPostsFuture() async {
    returnStatus = await chartService.getDataToChart(tabSelect);

    if (returnStatus['status'] == "Sucsess") {
      return dataAll = returnStatus['sites'];
    } else {
      print("---> else : $returnStatus");

      Flushbar(
        title: returnStatus['status'],
        message: returnStatus['message'],
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: returnStatus['color'],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: returnStatus['color'],
      )..show(context);

      return null;
    }
  }

  Future<Null> onPullToRefresh() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPostsFuture(),
      builder: (context, snapshot) {
        print("........เริ่ม Body Chart page.........");

        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: onPullToRefresh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildRegionTabBar(),
                Expanded(
                  child: ListView.builder(
                    itemCount: 3, //snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyBarChart(
                        listChart: snapshot.data[index]['data_Chart'].length > 0
                            ? snapshot.data[index]['data_Chart']
                            : [{}],
                        nameStore: snapshot.data[index]['site_name'],
                        maxy: double.parse('${snapshot.data[index]['maxy']}'),
                        interval:
                            double.parse('${snapshot.data[index]['interval']}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Container();
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Text(
        "Statistics",
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildRegionTabBar() {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: TabBar(
          indicator: BubbleTabIndicator(
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
            indicatorHeight: size.height * 0.04,
            indicatorColor: Colors.white,
          ),
          labelStyle: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.w600),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          tabs: listTabs.map((value) => Text(value)).toList(),
          onTap: (index) {
            print('Tab $index on ${listTabs[index]} ');
            setState(() {
              tabSelect = listTabs[index];
            });
          },
        ),
      ),
    );
  }
}
